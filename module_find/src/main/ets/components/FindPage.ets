import { CommonRootPage } from 'lib_common/src/main/ets/mvvm/view/CommonRootPage'
import { CategoryPage } from './CategoryPage'
import { ForcePage } from './ForcePage'
import { TopicPage } from './TopicPage'
import { FindPageViewModel } from './viewmodel/FindPageViewModel'

@Component
export struct FindPage {
  @State viewModel: FindPageViewModel = new FindPageViewModel()

  aboutToAppear(): void {
    this.viewModel.getFocusList(false, true)
  }

  build() {
    CommonRootPage({
      isShowBackBtn: false,
      title: "发现",
      loadingProps: this.viewModel.loadingProps,
      isRefreshing: this.viewModel.isRefreshing,
      onRefresh: () => {
        if (this.viewModel.index == 0) {
          this.viewModel.getFocusList(true, false)
        } else if (this.viewModel.index == 1) {
          this.viewModel.getCategoryList(true, false)
        } else if (this.viewModel.index == 2) {
          this.viewModel.getTopicList(true, false)
        }
      }
    }) {
      Tabs({ index: 0, barPosition: BarPosition.Start }) {
        TabContent() {
          ForcePage({
            dataList: this.viewModel.dataListFocusModelItemList, onLoadMore: () => {
              console.info("MYTAG", "onLoadMore start, ForcePage")
              this.viewModel.getFocusList(false, false)
            }
          })
        }.tabBar(this.TabView('关注'))

        TabContent() {
          CategoryPage({
            dataList: this.viewModel.dataListCategoryModelChild, onLoadMore: () => {
              console.info("MYTAG", "onLoadMore start, Category")
              this.viewModel.getCategoryList(false, false)
            }
          })
        }.tabBar(this.TabView('分类'))

        TabContent() {
          TopicPage({
            dataList: this.viewModel.dataListTopicModelItemList, onLoadMore: () => {
              console.info("MYTAG", "onLoadMore start, TopicPage")
              this.viewModel.getTopicList(false, false)
            }
          })
        }.tabBar(this.TabView('主题'))
      }.onChange((index) => {
        this.viewModel.index = index
        console.info("MYTAG", "index:" + index)
        if (index == 1 && this.viewModel.dataListCategoryModelChild.length == 0) {
          this.viewModel.getCategoryList(false, true)
        } else if (index == 2 && this.viewModel.dataListTopicModelItemList.length == 0) {
          this.viewModel.getTopicList(false, true)
        }
      }).width('100%').height('100%')
    }
  }

  @Builder
  TabView(title: string) {
    Text(title)
      .width('100%')
      .height('50vp')
      .fontColor('#ffffff')
      .textAlign(TextAlign.Center)
      .backgroundColor('#d81e06')
  }
}