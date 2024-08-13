import { CommonRootPage, PageState } from '../../mvvm/view/CommonRootPage'
import { Category } from './CategoryPage'
import { ForcePage } from './ForcePage'
import { TopicPage } from './TopicPage'

@Component
export struct FindPage {
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
      title: "发现",
      loadingProps: this.loadingProps,
      isRefreshing: this.isRefreshing
    }) {
      Tabs({ index: 0, barPosition: BarPosition.Start }) {
        TabContent() {
          ForcePage({ isRefreshing: this.isRefreshing, loadingProps: this.loadingProps })
        }.tabBar(this.TabView('关注'))

        TabContent() {
          Category({ isRefreshing: this.isRefreshing, loadingProps: this.loadingProps })
        }.tabBar(this.TabView('分类'))

        TabContent() {
          TopicPage({ isRefreshing: this.isRefreshing, loadingProps: this.loadingProps })
        }.tabBar(this.TabView('主题'))
      }.width('100%').height('100%')
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