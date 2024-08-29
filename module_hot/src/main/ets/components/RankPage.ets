import { HomeModelIssueListItemList } from 'lib_api/src/main/ets/http/entity/HomeModel';
import { RefreshFooter } from 'lib_common/src/main/ets/mvvm/view/RefreshFooter';
import { HotTab } from './entity/HotTabList';

@Component
export struct RankPage {
  @ObjectLink hotTab: HotTab
  onLoadMore: (hotTab: HotTab) => void = (hotTab) => {
  }

  build() {
    List() {
      ForEach(this.hotTab.dataList, (item: HomeModelIssueListItemList, index) => {
        ListItem() {
          Column() {
            Stack() {
              Image(item.data?.cover.detail).width('100%').height('100%').border({ radius: '10vp' })
              Text(item.data?.category).fontColor('#ffffff').align(Alignment.Top)
            }.width('100%').height('180fp').alignContent(Alignment.Start)

            Row() {
              Image(item.data?.author.icon)
                .width('50vp')
                .height('50vp')
                .border({ radius: '25vp' })
              Column() {
                Text(item.data?.title).width('100%').fontSize('20vp').fontColor('#333333').margin({ right: '10vp' })
                Text(item.data?.title).fontSize('13vp').fontColor('#999999').margin({ top: '3vp' })
              }.width('100%').margin({ left: '5vp' }).alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .height('50vp')
            .margin({ top: '5vp' })
          }
          .margin({
            left: '10vp',
            right: '10vp',
            top: '5vp',
            bottom: '15vp'
          })
        }
      })
      if (this.hotTab.dataList.length > 0) {
        ListItem() {
          RefreshFooter({ showFooter: true })
        }
      }
    }.listDirection(Axis.Vertical).onReachEnd(() => {
      console.info("MYTAG", "onReachEnd start...")
      if (this.hotTab.dataList.length > 0) {
        this.onLoadMore(this.hotTab)
      }
    })
  }
}