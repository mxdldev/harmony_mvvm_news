import { HomeModel, HomeModelIssueListItemList } from '../../http/entity/HomeModel'
import apiService from '../../http/ApiService'
import { LogUtils } from '../../util/LogUtils';
import { AxiosResponse } from '@ohos/axios';
import http from '@ohos.net.http';

@Component
export struct HomePage {
  @State dataList: HomeModelIssueListItemList[] = []

  aboutToAppear() {
    apiService.getHomeList("").then(homeModel => {
      if (homeModel) {
        console.log('Home List:', homeModel);
        let items = homeModel.issueList[0].itemList
        let list = items.filter((item) => item.type == "video")

        this.dataList = list.slice(4)
        console.log('======================')
        console.log("data size:" + this.dataList.length)
      } else {
        console.log('Failed to fetch home list.');
      }
    }).catch((error: Error) => {
      console.error('Failed to fetch home list:', error);
    });
    console.log('*****************************************************************')
    let httpRequest = http.createHttp();
    httpRequest.request(
      "https://baobab.kaiyanapp.com/api/v2/feed",
      {
        method: http.RequestMethod.GET, // 可选，默认为http.RequestMethod.GET
      }, (err, data) => {
      if (!err) {
        console.info('Result1:' + JSON.stringify(data.result));
        console.info('code1:' + JSON.stringify(data.responseCode));
      } else {
        console.info('error1:' + JSON.stringify(err));
        httpRequest.off('headersReceive');
        httpRequest.destroy();
      }
    }
    );
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

