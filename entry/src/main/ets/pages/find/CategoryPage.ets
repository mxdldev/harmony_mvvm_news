import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { CategoryModelChild } from '../../model/CategoryModel';

@Component
export struct Category{
  @State dataList: CategoryModelChild[] = []
  aboutToAppear(): void {
    const session = rcp.createSession();
    session.get("https://baobab.kaiyanapp.com/api/v4/categories").then((response) => {
      console.info(`Response succeeded: '${JSON.stringify(response)}`);
      this.dataList = JSON.parse(response.toString()!!);
      session.close();
    }).catch((err: BusinessError) => {
      console.error(`Response err: Code is ${err.code}, message is ${JSON.stringify(err)}`);
      session.close();
    });
  }
  build() {
    Column() {
      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.dataList, (item: CategoryModelChild, index: number) => {
          ListItem() {
            Column() {
              Stack() {
                Image(item.bgPicture)
                  .width('100%')
                  .height('210vp')
                  .border({ radius: '10vp' })
                Text(item.name)
                  .fontSize('12fp')
                  .fontColor('#fff')
                  .width('45vp')
                  .height('20vp')
                  .position({ x: 0, y: 0 })
                  .margin(10)
              }.width('100%').height('210vp')

              Row() {
                Image(item.headerImage).width('50vp').height('50vp').border({radius:'25vp'})
                Column() {
                  Text(item.name).fontColor('#333333').fontSize('20fp')
                  Text(item.description).fontColor('#999999').fontSize('13fp').margin({top:'5vp'})
                }.alignItems(HorizontalAlign.Start).margin({left:'5vp'})
              }.width('100%').height('60vp').padding({left:'5vp',right:'5vp'})
            }.width('100%')
          }
        })
      }
    }
  }
}