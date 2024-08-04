import { CommonRootPage } from '../../view/CommonRootPage'
import { CommonTitleBar } from '../../view/CommonTitleBar'
import { LoadingProps } from '../../view/LoadingProps'
import { Category } from './CategoryPage'
import { ForcePage } from './ForcePage'
import { TopicPage } from './TopicPage'

@Component
export struct FindPage {
  @State loadingProps: LoadingProps = {
    isShowInitLoading: false,
    isShowTransparentLoading: false,
    isShowNoData: false,
    isShowNetErr: false,
  }

  build() {
    CommonRootPage({
      isShowBackBtn: false,
      title: "发现",
      loadingProps:this.loadingProps
    }) {
      Tabs({ index: 0, barPosition: BarPosition.Start }) {
        TabContent() {
          ForcePage({loadingProps:this.loadingProps})
        }.tabBar(this.TabView('关注'))

        TabContent() {
          Category({loadingProps:this.loadingProps})
        }.tabBar(this.TabView('分类'))

        TabContent() {
          TopicPage({loadingProps:this.loadingProps})
        }.tabBar(this.TabView('主题'))
      }.width('100%').height('100%')
    }
  }

  @Builder
  TabView(title: string) {
    Text(title)
      .width('100%')
      .height('50vp')
      .fontColor('#ffffff')
      .textAlign(TextAlign.Center)
      .backgroundColor('#d81e06')
  }
}