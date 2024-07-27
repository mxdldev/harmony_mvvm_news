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
            Row() {
              Image(item.data?.cover?.detail)
                .width('100%')
                .height('210vp')
                .border({ radius: '10vp' })
              Text(item.data?.category).fontSize('12fp').fontColor('#ffffff').width('45vp').height('20vp')
            }.width('100%')
          }
        })
      }
    }

  }
}

