import { RankPage } from './RankPage'
import hotViewModel, { HotTab } from '../../viewmodel/HotViewModel';

@Component
export struct HotPage {
  build() {
    Column() {
      Text('热门')
        .width('100%')
        .height('50vp')
        .fontSize('14fp')
        .fontColor('#ffffff')
        .backgroundColor('#ff0000')
        .textAlign(TextAlign.Center)
      Tabs() {
        ForEach(hotViewModel.hotTabTitle, (hotTab: HotTab, index) => {
          TabContent() {
            RankPage({ rankType: hotTab.rankType })
          }.tabBar(this.tabItem(hotTab.title))
        })
      }
    }
  }

  @Builder
  tabItem(title: string) {
    Text(title)
      .width('100%')
      .height('50vp')
      .fontSize('14fp')
      .fontColor('#ffffff')
      .textAlign(TextAlign.Center)
      .backgroundColor('#ff0000')
  }
}