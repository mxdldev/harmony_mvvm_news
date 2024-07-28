import { ForcePage } from './ForcePage'

@Component
export struct FindPage {
  build() {
    Column() {
      Text('发现')
        .fontSize('22fp')
        .fontColor('#ffffff')
        .width('100%')
        .height('60vp')
        .textAlign(TextAlign.Center)
        .backgroundColor('#d81e06')

      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          ForcePage()
        }.tabBar(this.TabView('关注'))
        TabContent() {
          ForcePage()
        }.tabBar(this.TabView('分类'))
        TabContent() {
          ForcePage()
        }.tabBar(this.TabView('主题'))
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }

  @Builder
  TabView(title: string) {
    Text(title).width('100%').height('50vp').fontColor('#ffffff').backgroundColor('#d81e06')
  }
}