import { RankPage } from './RankPage'
import { HotTab } from './entity/HotTabList';
import { CommonRootPage } from '../../mvvm/view/CommonRootPage';
import { HotPageViewModel } from './viewmodel/HotPageViewModel';

@Component
export struct HotPage {
  @State viewModel: HotPageViewModel = new HotPageViewModel()

  build() {
    CommonRootPage({
      isShowBackBtn: false,
      title: "热门",
      loadingProps: this.viewModel.loadingProps,
      isRefreshing: this.viewModel.isRefreshing
    }) {
      Tabs() {
        ForEach(this.viewModel.hotTabTitle, (hotTab: HotTab, index) => {
          TabContent() {
            RankPage({
              hotTab: hotTab, onLoadMore: (hotTab, isRefresh, isFirst) => {
                this.viewModel.getHotRankList(hotTab, isRefresh, isFirst)
              }
            })
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