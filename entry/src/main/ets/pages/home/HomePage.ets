import { router } from '@kit.ArkUI';
import { CommonRootPage, PageState } from '../../mvvm/view/CommonRootPage';
import { RefreshFooter } from '../../mvvm/view/RefreshFooter';
import { HomeModelIssueListItemList } from '../../http/entity/HomeModel';
import { HomePageViewModel } from './viewmodel/HomePageViewModel';

@Component
export struct HomePage {
  @State viewModel: HomePageViewModel = new HomePageViewModel()

  aboutToAppear() {
    this.viewModel.getHomeList(true, true)
  }

  build() {
    CommonRootPage({
      isShowBackBtn: false,
      title: "首页",
      loadingProps: this.viewModel.loadingProps,
      isRefreshing: this.viewModel.isRefreshing,
      onRefresh: () => {
        this.viewModel.getHomeList(true, false)
      }
    }) {
      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.viewModel.dataList, (item: HomeModelIssueListItemList, index: number) => {
          ListItem() {
            Column() {
              Stack() {
                Image(item.data?.cover?.detail)
                  .width('100%')
                  .height('210vp')
                  .border({ radius: '10vp' })
                Text(item.data?.category)
                  .fontSize('12fp')
                  .fontColor('#fff')
                  .width('45vp')
                  .height('20vp')
                  .position({ x: 0, y: 0 })
                  .margin(10)
              }.width('100%').height('210vp')

              Row() {
                Image(item.data?.author.icon).width('50vp').height('50vp').border({ radius: '25vp' })
                Column() {
                  Text(item.data?.author.name).fontColor('#333333').fontSize('20fp')
                  Text(item.data?.author.name).fontColor('#999999').fontSize('13fp').margin({ top: '5vp' })
                }.alignItems(HorizontalAlign.Start).margin({ left: '5vp' })
              }.width('100%').height('60vp').padding({ left: '5vp', right: '5vp' })
            }.width('100%').onClick(() => {
              console.info("MYTAG", "item click start...")
              router.pushUrl({
                url: 'pages/home/HomeDetailPage',
                params: { 'id': item.data?.id, 'playUrl': item.data?.playUrl }
              }, router.RouterMode.Standard, (error) => {

              })
            })
          }
        })
        if (this.viewModel.dataList.length > 0) {
          ListItem() {
            RefreshFooter({ showFooter: this.viewModel.isLoadMore })
          }
        }
      }.onReachEnd(() => {
        console.info("MYTAG", "onReachEnd start...")
        this.viewModel.isLoadMore = true
        this.viewModel.getHomeList(false, false)
      })
    }
  }
}

