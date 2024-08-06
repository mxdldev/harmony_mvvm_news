import { router } from '@kit.ArkUI';
import { DetailPageParams } from '../../http/entity/DetailPageParams';
import { HomeModel, HomeModelIssueListItemList } from '../../http/entity/HomeModel';
import { CommonRootPage, PageState } from '../../view/CommonRootPage';
import { HttpRequestCallback } from '../../http/HttpRequest';
import { ApiService } from '../../http/ApiService';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
export struct HomeDetailPage {
  @State loadingProps: PageState = {
    isShowInitLoading: false,
    isShowTransparentLoading: false,
    isShowNoData: false,
    isShowNetErr: false,
  }
  @State dataId: number = 0
  @State playUrl: string = ''
  @State dataList: HomeModelIssueListItemList[] = []
  private controller: VideoController | undefined;
  private previewUris: Resource = $r('app.media.landing_image');
  @State @Watch('onRefreshStart') isRefreshing: boolean = false

  onRefreshStart(changedPropertyName: string) {
    this.getHomeDetail(this.dataId, false)
  }

  aboutToAppear(): void {
    const params: DetailPageParams = router.getParams() as DetailPageParams;
    this.dataId = params.id;
    this.playUrl = params.playUrl
    console.info("MYTAG", 'dataId:' + this.dataId + ";playUrl:" + this.playUrl)

    this.getHomeDetail(this.dataId, true)
  }

  getHomeDetail(id: number, isFirst: boolean) {
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
      }

      onSuccess(response: HomeModel): void {
        console.log('Request succeeded with response:', response);
        currThis.dataList = response.itemList
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
      }
    }

    ApiService.getInstance().getHomeDetail(this.dataId, new HomeModelCallback());
  }

  build() {
    Column() {
      CommonRootPage({
        isShowBackBtn: true,
        title: "视频详情",
        loadingProps: this.loadingProps,
        isRefreshing: this.isRefreshing
      }) {
        Column() {
          Video({ src: this.playUrl, previewUri: this.previewUris, controller: this.controller })
            .width('100%')
            .height('250vp')
            .autoPlay(true)
            .objectFit(ImageFit.Fill)
          List() {
            ForEach(this.dataList, (item: HomeModelIssueListItemList, index: number) => {
              ListItem() {
                Row() {
                  Image(item.data?.cover?.feed).width('100vp').height('100%').border({ radius: '5vp' })
                  Column() {
                    Text(item.data?.title)
                      .fontSize('20fp')
                      .fontColor('#333333')
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                    Text(item.data?.description)
                      .fontSize('13fp')
                      .fontColor('#999999')
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .margin({ top: '5vp' })
                  }.layoutWeight(1).height('100%').margin({ left: '10vp' }).alignItems(HorizontalAlign.Start)
                }.width('100%').height('70vp').margin('10vp').onClick(() => {
                  this.playUrl = item.data?.playUrl as string
                })
              }
            })
          }
        }.width('100%').height('100%').justifyContent(FlexAlign.Start)

      }
    }.width('100%').height('100%').justifyContent(FlexAlign.Start)

  }
}