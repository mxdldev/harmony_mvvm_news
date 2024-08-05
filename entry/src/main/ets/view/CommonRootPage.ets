import { CommonTitleBar } from './CommonTitleBar'
import { LoadingProps } from './LoadingProps';

@Component
export struct CommonRootPage {
  @Prop isShowBackBtn: boolean = true
  @Prop title: string = ''
  @Prop isShowTitleBar: boolean = true
  @Prop loadingProps: LoadingProps = {
    isShowInitLoading: false,
    isShowTransparentLoading: false,
    isShowNoData: false,
    isShowNetErr: false,
  }
  @Link isRefreshing: boolean
  @Prop enableRefreshing: boolean = true

  @Builder
  buildPageContent() {
  }

  @BuilderParam buildPageContentParam: () => void = this.buildPageContent

  @Styles
  imgSize(){
    .width(100).height(100)
  }

  @Styles
  stateViewAligin(){
    .width('100%').height('100%').backgroundColor(Color.Transparent)
  }

  build() {
    Column() {
      if (this.isShowTitleBar) {
        CommonTitleBar({ isShowBackBtn: this.isShowBackBtn, title: this.title })
      }
      Stack() {
        Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
          this.buildPageContentParam()
        }.onStateChange((refreshStatus: RefreshStatus) => {
          console.info('refresh state is:' + refreshStatus)
        })
        .onRefreshing(() => {
          this.isRefreshing = true
        }).pullToRefresh(true)
        if (this.loadingProps.isShowInitLoading) {
          Column() {
            Image($r('app.media.loading')).imgSize()
            Text('加载中')
          }.stateViewAligin().justifyContent(FlexAlign.Center)
        }
        if (this.loadingProps.isShowTransparentLoading) {
          Column() {
            Image($r('app.media.common_loading')).imgSize()
            Text('加载中')
          }.stateViewAligin().justifyContent(FlexAlign.Center)
        }
        if (this.loadingProps.isShowNoData) {
          Column() {
            Image($r('app.media.common_empty_content')).imgSize()
            Text('暂无数据')
          }.stateViewAligin().justifyContent(FlexAlign.Center)
        }

        if (this.loadingProps.isShowNetErr) {
          Column() {
            Image($r('app.media.timeout')).imgSize()
            Text('网络错误')
          }.stateViewAligin().justifyContent(FlexAlign.Center)
        }
      }
    }.width('100%').height('100%').justifyContent(FlexAlign.Start)
  }
}