import { Category } from './CategoryPage'
import { ForcePage } from './ForcePage'
import { TopicPage } from './TopicPage'

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

      Tabs({index:0, barPosition: BarPosition.Start }) {
        TabContent() {
          ForcePage()
        }.tabBar(this.TabView('关注'))
        TabContent() {
          Category()
        }.tabBar(this.TabView('分类'))
        TabContent() {
          TopicPage()
        }.tabBar(this.TabView('主题'))
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }

  @Builder
  TabView(title: string) {
    Text(title).width('100%').height('50vp').fontColor('#ffffff').textAlign(TextAlign.Center).backgroundColor('#d81e06')
  }
}