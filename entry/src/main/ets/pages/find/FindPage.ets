import { CommonRootPage } from '../../mvvm/view/CommonRootPage'
import { Category } from './CategoryPage'
import { ForcePage } from './ForcePage'
import { TopicPage } from './TopicPage'
import { FindPageViewModel } from './viewmodel/FindPageViewModel'

@Component
export struct FindPage {
  @State viewModel: FindPageViewModel = new FindPageViewModel()
  index: number = 0

  build() {
    CommonRootPage({
      isShowBackBtn: false,
      title: "发现",
      loadingProps: this.viewModel.loadingProps,
      isRefreshing: this.viewModel.isRefreshing,
      onRefresh: () => {
        if(this.index == 0){
          this.viewModel.getFocusList(true,false)
        }else if(this.index == 1){
          this.viewModel.getCategoryList(true,false)
        }else if(this.index == 2){
          this.viewModel.getTopicList(true,false)
        }
      }
    }) {
      Tabs({ index: 0, barPosition: BarPosition.Start }) {
        TabContent() {
          ForcePage({
            dataList: this.viewModel.dataListFocusModelItemList, onLoadMore: (isReresh, isFirst) => {
              console.info("MYTAG1", "isReresh:" + isReresh + ";isFirst:" + isFirst)
              this.viewModel.getFocusList(isReresh, isFirst)
            }
          })
        }.tabBar(this.TabView('关注'))

        TabContent() {
          Category({
            dataList: this.viewModel.dataListCategoryModelChild, onLoadMore: () => {
              this.viewModel.getCategoryList(false, false)
            }
          })
        }.tabBar(this.TabView('分类'))

        TabContent() {
          TopicPage({
            dataList: this.viewModel.dataListTopicModelItemList, onLoadMore: () => {
              this.viewModel.getTopicList(false, false)
            }
          })
        }.tabBar(this.TabView('主题'))
      }.onChange((index) => {
        this.index = index
        console.info("MYTAG","index:"+index)
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