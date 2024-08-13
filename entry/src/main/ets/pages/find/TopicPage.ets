import { BusinessError } from '@kit.BasicServicesKit';
import { TopicModel, TopicModelItemList } from '../../http/entity/TopicModel'
import { HttpRequestCallback } from '../../http/HttpRequest';
import { ApiService } from '../../http/ApiService';
import { RefreshFooter } from '../../mvvm/view/RefreshFooter';
import { PageState } from '../../mvvm/view/CommonRootPage';

@Component
export struct TopicPage {
  @Link loadingProps: PageState
  @State dataList: TopicModelItemList[] = []
  @Link @Watch('onRefreshStart') isRefreshing: boolean
  @State isLoadMore: boolean = false

  onRefreshStart(changedPropertyName: string) {
    if (this.isRefreshing) {
      this.getTopicList(true, false)
    }
  }

  getTopicList(isReresh: boolean, isFirst: boolean) {
    const currThis = this

    class TopicModelCallback implements HttpRequestCallback<TopicModel> {
      onStart(): void {
        console.log('Request started.');
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = true
        }
      }

      onComplete(): void {
        console.log('Request completed.');
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = false
        }
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }

      onSuccess(response: TopicModel): void {
        console.log('Request succeeded with response:', response);

        if (isReresh) {
          currThis.dataList = response.itemList
        } else {
          currThis.dataList = [...currThis.dataList, ...response.itemList]
        }
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }
    }

    ApiService.getInstance().getTopicList(new TopicModelCallback());
  }

  aboutToAppear(): void {
    this.getTopicList(true, false)
  }

  build() {
    Column() {
      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.dataList, (item: TopicModelItemList, index: number) => {
          ListItem() {
            Stack() {
              Image(transformImageUrl(item.data?.image))
                .width('100%')
                .height('210vp')
                .border({ radius: '10vp' })
            }.width('100%').height('210vp')

          }.width('100%')
        })
        if (this.dataList.length > 0) {
          ListItem() {
            RefreshFooter({ showFooter: this.isLoadMore })
          }
        }
      }.listDirection(Axis.Vertical).onReachEnd(() => {
        console.info("MYTAG", "onReachEnd start...")
        this.isLoadMore = true
        this.getTopicList(false, false)
      })
    }
  }
}
const transformImageUrl = (imageUrl: string | undefined): string => {
  // 定义正则表达式和替换字符串
  const regex = /^(https?:\/\/)img\.(.*)$/;
  const replacement = "$1ali-img.$2";

  // 如果 imageUrl 为空或未定义，则返回空字符串
  if (imageUrl === undefined) return "";

  // 使用正则表达式替换符合条件的部分
  return imageUrl.replace(regex, replacement);
};

