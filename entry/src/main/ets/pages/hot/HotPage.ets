import { RankPage } from './RankPage'
import hotViewModel, { HotTab } from '../../viewmodel/HotViewModel';
import { LoadingProps } from '../../view/LoadingProps';
import { CommonRootPage } from '../../view/CommonRootPage';

@Component
export struct HotPage {
  @State loadingProps: LoadingProps = {
    isShowInitLoading: false,
    isShowTransparentLoading: false,
    isShowNoData: false,
    isShowNetErr: false,
  }
  @State @Watch('onRefreshStart') isRefreshing: boolean = false

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
            RankPage({ rankType: hotTab.rankType, loadingProps: this.loadingProps })
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

  onRefreshStart(changedPropertyName: string) {
  }
}