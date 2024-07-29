import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { TopicModel, TopicModelItemList } from '../../model/TopicModel'
import ImageRegexUtils from '../../util/ImageRegexUtils';

@Component
export struct TopicPage {
  @State dataList: TopicModelItemList[] = []

  aboutToAppear(): void {
    const session = rcp.createSession();
    session.get("https://baobab.kaiyanapp.com/api/v3/specialTopics").then((response) => {
      console.info(`Response succeeded: '${JSON.stringify(response)}`);
      let data: TopicModel = JSON.parse(response.toString()!!);
      this.dataList = data.itemList
      session.close();
    }).catch((err: BusinessError) => {
      console.error(`Response err: Code is ${err.code}, message is ${JSON.stringify(err)}`);
      session.close();
    });
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
      }
    }
  }
}