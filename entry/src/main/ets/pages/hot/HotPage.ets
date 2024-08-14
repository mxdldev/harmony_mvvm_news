import { RankPage } from './RankPage'
import hotViewModel, { HotTab } from './entity/HotTabList';
import { CommonRootPage, PageState } from '../../mvvm/view/CommonRootPage';
import { HomePageModel } from '../home/model/HomePageModel';
import { HomePageViewModel } from '../home/viewmodel/HomePageViewModel';

@Component
export struct HotPage {
  viewModel = new HomePageViewModel()

  @State hotTabTitle:HotTab[] = hotViewModel.hotTabTitle
  build() {
    CommonRootPage({
      isShowBackBtn: false,
      title: "热门",
      loadingProps: this.viewModel.loadingProps,
      isRefreshing: this.viewModel.isRefreshing
    }) {
      Tabs() {
        ForEach(this.hotTabTitle, (hotTab: HotTab, index) => {
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