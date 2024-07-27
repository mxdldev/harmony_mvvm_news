import { HomeModel, HomeModelIssueListItemList } from '../../http/entity/HomeModel'
import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Component
export struct HomePage {
  @State dataList: HomeModelIssueListItemList[] = []

  aboutToAppear() {
    const session = rcp.createSession();
    session.get("https://baobab.kaiyanapp.com/api/v2/feed").then((response) => {
      console.info(`Response succeeded: '${JSON.stringify(response)}`);
      let data: HomeModel = JSON.parse(response.toString()!!);
      let items = data.issueList[0].itemList
      let list = items.filter((item) => item.type == "video")
      this.dataList = list.slice(4)
      session.close();
    }).catch((err: BusinessError) => {
      console.error(`Response err: Code is ${err.code}, message is ${JSON.stringify(err)}`);
      session.close();
    });
  }

  build() {
    Column() {
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
                Image(item.data?.author.icon).width('50vp').height('50vp').border({radius:'25vp'})
                Column() {
                  Text(item.data?.author.name).fontColor('#333333').fontSize('20fp')
                  Text(item.data?.author.name).fontColor('#999999').fontSize('13fp').margin({top:'5vp'})
                }.alignItems(HorizontalAlign.Start).margin({left:'5vp'})
              }.width('100%').height('60vp').padding({left:'5vp',right:'5vp'})
            }.width('100%')
          }
        })
      }
    }

  }
}

