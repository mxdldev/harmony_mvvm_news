import { HomeModel, HomeModelIssueListItemList } from '../../http/entity/HomeModel'
import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';
import { CommonRootPage } from '../../view/CommonRootPage';
import { LoadingProps } from '../../view/LoadingProps';
import { HttpRequestCallback } from '../../http/HttpRequest';
import { ApiService } from '../../http/ApiService';
import { RefreshFooter } from '../../view/RefreshFooter';

@Component
export struct HomePage {
  @State loadingProps: LoadingProps = {
    isShowInitLoading: false,
    isShowTransparentLoading: false,
    isShowNoData: false,
    isShowNetErr: false,
  }
  @State @Watch('onRefreshStart') isRefreshing: boolean = false
  @State dataList: HomeModelIssueListItemList[] = []
  @State isLoadMore: boolean = false

  onRefreshStart() {
    this.getHomeList(true, false)
  }

  aboutToAppear() {
    this.getHomeList(true, true)
  }

  getHomeList(isReresh: boolean, isFirst: boolean) {
    const currThis = this

    class HomeModelCallback implements HttpRequestCallback<HomeModel> {
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
        let items = response.issueList[0].itemList
        let list = items.filter((item) => item.type == "video")
        if (isReresh) {
          currThis.dataList = list
        } else {
          currThis.dataList = [...currThis.dataList, ...list]
        }
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }
    }

    ApiService.getInstance().getHomeList(new HomeModelCallback());
  }

  build() {
    CommonRootPage({
      isShowBackBtn: false,
      title: "首页",
      loadingProps: this.loadingProps,
      isRefreshing: this.isRefreshing
    }) {
      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.dataList, (item: HomeModelIssueListItemList, index: number) => {
          ListItem() {
            Column() {
              Stack() {
                Image(item.data?.cover?.detail)
                  .width('100%')
                  .height('210vp')
                  .border({ radius: '10vp' })
                Text(item.data?.category)
                  .fontSize('12fp')
                  .fontColor('#fff')
                  .width('45vp')
                  .height('20vp')
                  .position({ x: 0, y: 0 })
                  .margin(10)
              }.width('100%').height('210vp')

              Row() {
                Image(item.data?.author.icon).width('50vp').height('50vp').border({ radius: '25vp' })
                Column() {
                  Text(item.data?.author.name).fontColor('#333333').fontSize('20fp')
                  Text(item.data?.author.name).fontColor('#999999').fontSize('13fp').margin({ top: '5vp' })
                }.alignItems(HorizontalAlign.Start).margin({ left: '5vp' })
              }.width('100%').height('60vp').padding({ left: '5vp', right: '5vp' })
            }.width('100%').onClick(() => {
              console.info("MYTAG", "item click start...")
              router.pushUrl({
                url: 'pages/home/HomeDetailPage',
                params: { 'id': item.data?.id, 'playUrl': item.data?.playUrl }
              }, router.RouterMode.Standard, (error) => {

              })
            })
          }
        })
        if (this.dataList.length > 0) {
          ListItem() {
            RefreshFooter({ showFooter: this.isLoadMore })
          }
        }
      }.onReachEnd(() => {
        console.info("MYTAG", "onReachEnd start...")
        this.isLoadMore = true
        this.getHomeList(false, false)
      })
    }
  }
}

