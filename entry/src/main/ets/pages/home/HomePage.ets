import { HomeModel, HomeModelIssueListItemList } from '../../http/entity/HomeModel'
import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';
import { CommonRootPage } from '../../view/CommonRootPage';
import { LoadingProps } from '../../view/LoadingProps';
import { HttpRequest, HttpRequestCallback } from '../../http/HttpRequest';
import { ApiService } from '../../http/ApiService';

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

  onRefreshStart() {
    console.info("MYTAG", 'isRefreshing:' + this.isRefreshing)
    const session = rcp.createSession();
    session.get("https://baobab.kaiyanapp.com/api/v2/feed").then((response) => {
      console.info(`Response succeeded: '${JSON.stringify(response)}`);
      let data: HomeModel = JSON.parse(response.toString()!!);
      let items = data.issueList[0].itemList
      let list = items.filter((item) => item.type == "video")
      this.dataList = [...this.dataList, ...list]
      session.close();
      this.isRefreshing = false
    }).catch((err: BusinessError) => {
      console.error(`Response err: Code is ${err.code}, message is ${JSON.stringify(err)}`);
      session.close();
      this.isRefreshing = false
    });
  }

  aboutToAppear() {
    const currThis = this
    class HomeModelCallback implements HttpRequestCallback<HomeModel> {
      onStart(): void {
        console.log('Request started.');
        currThis.loadingProps.isShowInitLoading = true
      }

      onComplete(): void {
        console.log('Request completed.');
        currThis.loadingProps.isShowInitLoading = false
      }

      onSuccess(response: HomeModel): void {
        console.log('Request succeeded with response:', response);
        let items = response.issueList[0].itemList
        let list = items.filter((item) => item.type == "video")
        currThis.dataList = list
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
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
      }.onReachEnd(() => {
        console.info("MYTAG", "onReachEnd start...")
      }).enabled(true)
    }

  }
}

