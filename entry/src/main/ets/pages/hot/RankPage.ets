import { BusinessError } from '@kit.BasicServicesKit';
import { HomeModel, HomeModelIssueListItemList } from '../../http/entity/HomeModel';
import hotViewModel from './entity/HotTabList';
import { HttpRequestCallback } from '../../http/HttpRequest';
import { ApiService } from '../../http/ApiService';
import { RefreshFooter } from '../../mvvm/view/RefreshFooter';
import { PageState } from '../../mvvm/view/CommonRootPage';

@Component
export struct RankPage {
  @Link loadingProps: PageState
  private rankType = hotViewModel.hotTabTitle[0].rankType
  @State dataList: HomeModelIssueListItemList[] = [];
  @Link @Watch('onRefreshStart') isRefreshing: boolean
  @State isLoadMore: boolean = false

  onRefreshStart(changedPropertyName: string) {
    if (this.isRefreshing) {
      this.getHotRankList(true, false)
    }
  }

  getHotRankList(isReresh: boolean, isFirst: boolean) {
    const currThis = this

    class HotRankCallback implements HttpRequestCallback<HomeModel> {
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

      onSuccess(response: HomeModel): void {
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

    ApiService.getInstance().getHotRankList(this.rankType, new HotRankCallback());
  }

  aboutToAppear(): void {
    this.getHotRankList(true, false)
  }

  build() {
    List() {
      ForEach(this.dataList, (item: HomeModelIssueListItemList, index) => {
        ListItem() {
          Column() {
            Stack() {
              Image(item.data?.cover.detail).width('100%').height('100%').border({ radius: '10vp' })
              Text(item.data?.category).fontColor('#ffffff').align(Alignment.Top)
            }.width('100%').height('180fp').alignContent(Alignment.Start)

            Row() {
              Image(item.data?.author.icon)
                .width('50vp')
                .height('50vp')
                .border({ radius: '25vp' })
              Column() {
                Text(item.data?.title).width('100%').fontSize('20vp').fontColor('#333333').margin({ right: '10vp' })
                Text(item.data?.title).fontSize('13vp').fontColor('#999999').margin({ top: '3vp' })
              }.width('100%').margin({ left: '5vp' }).alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .height('50vp')
            .margin({ top: '5vp' })
          }
          .margin({
            left: '10vp',
            right: '10vp',
            top: '5vp',
            bottom: '15vp'
          })
        }
      })
      if (this.dataList.length > 0) {
        ListItem() {
          RefreshFooter({ showFooter: this.isLoadMore })
        }
      }
    }.listDirection(Axis.Vertical).onReachEnd(() => {
      console.info("MYTAG", "onReachEnd start...")
      this.isLoadMore = true
      this.getHotRankList(false, false)
    })
  }
}