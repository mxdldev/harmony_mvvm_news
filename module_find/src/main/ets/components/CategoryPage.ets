import { CategoryModelChild } from 'lib_api/src/main/ets/http/entity/CategoryModel';
import { RefreshFooter } from 'lib_common/src/main/ets/mvvm/view/RefreshFooter';

@Component
export struct CategoryPage {
  @Prop dataList: CategoryModelChild[] = []
  onLoadMore: () => void = () => {
  }

  build() {
    Column() {
      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.dataList, (item: CategoryModelChild, index: number) => {
          ListItem() {
            Column() {
              Stack() {
                Image(item.bgPicture)
                  .width('100%')
                  .height('210vp')
                  .border({ radius: '10vp' })
                Text(item.name)
                  .fontSize('12fp')
                  .fontColor('#fff')
                  .width('45vp')
                  .height('20vp')
                  .position({ x: 0, y: 0 })
                  .margin(10)
              }.width('100%').height('210vp')

              Row() {
                Image(item.headerImage).width('50vp').height('50vp').border({ radius: '25vp' })
                Column() {
                  Text(item.name).fontColor('#333333').fontSize('20fp')
                  Text(item.description).fontColor('#999999').fontSize('13fp').margin({ top: '5vp' })
                }.alignItems(HorizontalAlign.Start).margin({ left: '5vp' })
              }.width('100%').height('60vp').padding({ left: '5vp', right: '5vp' })
            }.width('100%')
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
      })
    }
  }
}