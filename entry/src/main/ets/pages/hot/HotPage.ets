import { RankPage } from './RankPage'
import hotViewModel, { HotTab } from './entity/HotTabList';
import { CommonRootPage, PageState } from '../../mvvm/view/CommonRootPage';

@Component
export struct HotPage {
  @State loadingProps: PageState = {
    isShowInitLoading: false,
    isShowTransparentLoading: false,
    isShowNoData: false,
    isShowNetErr: false,
  }
  @State isRefreshing: boolean = false

  build() {
    CommonRootPage({
      isShowBackBtn: false,
      title: "热门",
      loadingProps: this.loadingProps,
      isRefreshing: this.isRefreshing
    }) {
      Tabs() {
        ForEach(hotViewModel.hotTabTitle, (hotTab: HotTab, index) => {
          TabContent() {
            RankPage({ isRefreshing: this.isRefreshing, rankType: hotTab.rankType, loadingProps: this.loadingProps })
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
      .backgroundColor('#d81e06')
  }
}