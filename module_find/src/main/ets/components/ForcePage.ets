import { FocusModel, FocusModelItemList, FocusModelItemListDataItemList } from 'lib_api/src/main/ets/http/entity/FocusModel';
import { RefreshFooter } from 'lib_common/src/main/ets/mvvm/view/RefreshFooter';

@Component
export struct ForcePage {
  @Prop dataList: FocusModelItemList[] = []

  onLoadMore: () => void = () => {
  }

  build() {
    Column() {
      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.dataList, (item: FocusModelItemList, index: number) => {
          ListItem() {
            Column() {
              Row() {
                Image(item.data?.header.icon).width('50vp').height('50vp').border({ radius: '25vp' })
                Column() {
                  Text(item.data?.header.title).fontColor('#333333').fontSize('20fp')
                  Text(item.data?.header.description)
                    .fontColor('#999999')
                    .fontSize('13fp')
                    .maxLines(1)
                    .margin({ top: '5vp' })
                }.alignItems(HorizontalAlign.Start).margin({ left: '5vp' })
              }.width('100%').height('60vp').padding({ left: '5vp', right: '5vp' })

              List() {
                ForEach(item.data.itemList, (item: FocusModelItemListDataItemList, index: number) => {
                  ListItem() {
                    Stack() {
                      Image(item.data?.cover?.detail)
                        .width('100%')
                        .height('100%')
                        .border({ radius: '10vp' })
                      Text(item.data?.category)
                        .fontSize('12fp')
                        .fontColor('#fff')
                        .width('45vp')
                        .height('20vp')
                        .position({ x: 0, y: 0 })
                        .margin(10)
                    }.width('220vp').height('130vp').margin({ left: '10vp' })
                  }
                })
              }.listDirection(Axis.Horizontal)
            }
          }
        })
        if (this.dataList.length > 0) {
          ListItem() {
            RefreshFooter({ showFooter: true })
          }
        }
      }.listDirection(Axis.Vertical).onReachEnd(() => {
        console.info("MYTAG", "onReachEnd start...")
        if (this.dataList.length > 0) {
          this.onLoadMore()
        }
      }

      )
    }
  }
}