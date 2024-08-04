import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { TopicModel, TopicModelItemList } from '../../model/TopicModel'
import ImageRegexUtils from '../../util/ImageRegexUtils';
import { LoadingProps } from '../../view/LoadingProps';

@Component
export struct TopicPage {
  @Link loadingProps: LoadingProps
  @State dataList: TopicModelItemList[] = []

  aboutToAppear(): void {
    this.loadingProps.isShowInitLoading = true
    const session = rcp.createSession();
    session.get("https://baobab.kaiyanapp.com/api/v3/specialTopics").then((response) => {
      console.info(`Response succeeded: '${JSON.stringify(response)}`);
      let data: TopicModel = JSON.parse(response.toString()!!);
      this.dataList = data.itemList
      session.close();
      this.loadingProps.isShowInitLoading = false
      this.loadingProps.isShowNetErr = false
    }).catch((err: BusinessError) => {
      console.error(`Response err: Code is ${err.code}, message is ${JSON.stringify(err)}`);
      session.close();
      this.loadingProps.isShowInitLoading = false
      this.loadingProps.isShowNetErr = true
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