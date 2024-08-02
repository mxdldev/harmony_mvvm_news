import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { HomeModel, HomeModelIssueListItemList } from '../../model/HomeModel';
import hotViewModel from '../../viewmodel/HotViewModel';

@Component
export struct RankPage {
  private rankType = hotViewModel.hotTabTitle[0].rankType
  @State dataList: HomeModelIssueListItemList[] = [];

  aboutToAppear(): void {
    const session = rcp.createSession();
    session.get("https:baobab.kaiyanapp.com/api/v4/rankList/videos?strategy=" + this.rankType).then((response) => {
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
                Text(item.data?.title).width('100%').fontSize('20vp').fontColor('#333333').margin({right:'10vp'})
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
    }
  }
}