import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';
import { DetailPageParams } from '../../model/DetailPageParams';
import { HomeModel, HomeModelIssueListItemList } from '../../model/HomeModel';

@Entry
@Component
export struct HomeDetailPage {
  @State dataId: number = 0
  @State playUrl: string = ''
  @State dataList: HomeModelIssueListItemList[] = []
  private controller: VideoController | undefined;
  private previewUris: Resource = $r('app.media.landing_image');

  aboutToAppear(): void {
    const params: DetailPageParams = router.getParams() as DetailPageParams;
    this.dataId = params.id;
    this.playUrl = params.playUrl
    console.info("MYTAG", 'dataId:' + this.dataId + ";playUrl:" + this.playUrl)

    const session = rcp.createSession();
    session.get("https://baobab.kaiyanapp.com/api/v4/video/related?id=" + this.dataId).then((response) => {
      console.info(`Response succeeded: '${JSON.stringify(response)}`);
      let data: HomeModel = JSON.parse(response.toString()!!);
      this.dataList = data.itemList
      session.close();
    }).catch((err: BusinessError) => {
      console.error(`Response err: Code is ${err.code}, message is ${JSON.stringify(err)}`);
      session.close();
    });


  }

  build() {
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
    }
  }
}