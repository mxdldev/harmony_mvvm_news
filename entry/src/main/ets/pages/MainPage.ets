import { TabItem } from '../model/TabItem'
import { HomePage } from './home/HomePage'

@Entry
@Component
struct MainPage {
  @State selectIndex: number = 0

  build() {
    Column() {
      Tabs({ index: this.selectIndex, barPosition: BarPosition.End }) {
        TabContent() {
          HomePage()
        }.tabBar(this.TabBottom({
          index: 0,
          title: "首页",
          imageActivated: $r('app.media.icon_sel_home'),
          imageOriginal: $r('app.media.icon_unsel_home')
        }, 0)).width("100%").height("100%")

        TabContent().tabBar(this.TabBottom({
          index: 1,
          title: "发现",
          imageActivated: $r('app.media.icon_sel_find'),
          imageOriginal: $r('app.media.icon_unsel_find')
        }, 1)).width("100%").height("100%")
        TabContent().tabBar(this.TabBottom({
          index: 2,
          title: "热门",
          imageActivated: $r('app.media.icon_sel_hot'),
          imageOriginal: $r('app.media.icon_unsel_hot')
        }, 2)).width("100%").height("100%")
        TabContent().tabBar(this.TabBottom({
          index: 3,
          title: "我的",
          imageActivated: $r('app.media.icon_sel_mine'),
          imageOriginal: $r('app.media.icon_unsel_mine')
        }, 3)).width("100%").height("100%")
      }
      .barWidth("100%")
      .barWidth("100%")
      .barHeight("56vp")
      .barPosition(BarPosition.End)
      .barMode(BarMode.Fixed)
      .onChange((index) => {
        this.selectIndex = index
      })
    }
  }

  @Builder
  TabBottom(tabItem: TabItem, selectIndex: number) {
    Column() {
      Image(this.selectIndex == selectIndex ? tabItem.imageActivated : tabItem.imageOriginal)
        .width('21vp')
        .height('21vp')
        .margin({ top: '5vp', bottom: '6vp' })
      Text(tabItem.title)
        .width('100%')
        .height('14vp')
        .fontColor(this.selectIndex == selectIndex ? '#f00' : '#000')
        .fontSize('10fp')
        .textAlign(TextAlign.Center)
    }.width('100%').height('100%').justifyContent(FlexAlign.Center).backgroundColor('#f5f5f5')
  }
}