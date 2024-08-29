import { RankPage } from './RankPage'
import { HotTab } from './entity/HotTabList';
import { CommonRootPage } from 'lib_common/src/main/ets/mvvm/view/CommonRootPage';
import { HotPageViewModel } from './viewmodel/HotPageViewModel';

@Component
export struct HotPage {
  @State viewModel: HotPageViewModel = new HotPageViewModel()

  aboutToAppear(): void {
    this.viewModel.getHotRankList(this.viewModel.hotTabTitle[0], false, true)
  }

  build() {
    CommonRootPage({
      isShowBackBtn: false,
      title: "热门",
      loadingProps: this.viewModel.loadingProps,
      isRefreshing: this.viewModel.isRefreshing,
      isShowInitLoading:this.viewModel.isShowInitLoading,
      onRefresh: () => {
        this.viewModel.getHotRankList(this.viewModel.hotTabTitle[this.viewModel.index], true, false)
      }
    }) {
      Tabs() {
        ForEach(this.viewModel.hotTabTitle, (hotTab: HotTab, index) => {
          TabContent() {
            RankPage({
              hotTab: hotTab, onLoadMore: (hotTab) => {
                this.viewModel.getHotRankList(hotTab, false, false)
              }
            })
          }.tabBar(this.tabItem(hotTab.title))
        })
      }.onChange((index) => {
        this.viewModel.index = index
        if (this.viewModel.hotTabTitle[index].dataList.length == 0) {
          this.viewModel.getHotRankList(this.viewModel.hotTabTitle[index], false, true)
        }
      })
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