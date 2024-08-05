import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { FocusModel, FocusModelItemList, FocusModelItemListDataItemList } from '../../model/FocusModel';
import { LoadingProps } from '../../view/LoadingProps';
import { HttpRequestCallback } from '../../http/HttpRequest';
import { ApiService } from '../../http/ApiService';
import { RefreshFooter } from '../../view/RefreshFooter';

@Component
export struct ForcePage {
  @Link loadingProps: LoadingProps
  @State dataList: FocusModelItemList[] = []
  @Link @Watch('onRefreshStart') isRefreshing: boolean
  @State isLoadMore: boolean = false

  onRefreshStart(changedPropertyName: string) {
    if (this.isRefreshing) {
      this.getFocusList(true, false)
    }
  }

  aboutToAppear(): void {
    this.getFocusList(true, true)
  }

  getFocusList(isReresh: boolean, isFirst: boolean) {
    const currThis = this

    class FocusModelCallback implements HttpRequestCallback<FocusModel> {
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
        currThis.isLoadMore = false
      }

      onSuccess(response: FocusModel): void {
        console.log('Request succeeded with response:', response);

        if (isReresh) {
          currThis.dataList = response.itemList
        } else {
          currThis.dataList = [...currThis.dataList, ...response.itemList]
        }
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }
    }

    ApiService.getInstance().getFocusList(new FocusModelCallback());
  }

  build() {
    Column() {
      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.dataList, (item: FocusModelItemList, index: number) => {
          ListItem() {
            Column() {
              Row() {
                Image(item.data?.header.icon).width('50vp').height('50vp').border({ radius: '25vp' })
                Column() {
                  Text(item.data?.header.title).fontColor('#333333').fontSize('20fp')
                  Text(item.data?.header.description)
                    .fontColor('#999999')
                    .fontSize('13fp')
                    .maxLines(1)
                    .margin({ top: '5vp' })
                }.alignItems(HorizontalAlign.Start).margin({ left: '5vp' })
              }.width('100%').height('60vp').padding({ left: '5vp', right: '5vp' })

              List() {
                ForEach(item.data.itemList, (item: FocusModelItemListDataItemList, index: number) => {
                  ListItem() {
                    Stack() {
                      Image(item.data?.cover?.detail)
                        .width('100%')
                        .height('100%')
                        .border({ radius: '10vp' })
                      Text(item.data?.category)
                        .fontSize('12fp')
                        .fontColor('#fff')
                        .width('45vp')
                        .height('20vp')
                        .position({ x: 0, y: 0 })
                        .margin(10)
                    }.width('220vp').height('130vp').margin({ left: '10vp' })
                  }
                })
              }.listDirection(Axis.Horizontal)
            }
          }
        })
        ListItem() {
          RefreshFooter({ showFooter: this.isLoadMore })
        }
      }.listDirection(Axis.Vertical).onReachEnd(() => {
        console.info("MYTAG", "onReachEnd start...")
        this.isLoadMore = true
        this.getFocusList(false, false)
      })
    }
  }
}