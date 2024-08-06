import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { TopicModel, TopicModelItemList } from '../../model/TopicModel'
import ImageRegexUtils from '../../util/ImageRegexUtils';
import { LoadingProps } from '../../view/LoadingProps';
import { HttpRequestCallback } from '../../http/HttpRequest';
import { ApiService } from '../../http/ApiService';
import { RefreshFooter } from '../../view/RefreshFooter';

@Component
export struct TopicPage {
  @Link loadingProps: LoadingProps
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
              Image(ImageRegexUtils(item.data?.image))
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