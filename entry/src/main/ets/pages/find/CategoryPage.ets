import { BusinessError } from '@kit.BasicServicesKit';
import { CategoryModelChild } from '../../http/entity/CategoryModel';
import { HttpRequestCallback } from '../../http/HttpRequest';
import { ApiService } from '../../http/ApiService';
import { RefreshFooter } from '../../view/RefreshFooter';
import { PageState } from '../../view/CommonRootPage';

@Component
export struct Category {
  @Link loadingProps: PageState
  @State dataList: CategoryModelChild[] = []
  @Link @Watch('onRefreshStart') isRefreshing: boolean
  @State isLoadMore: boolean = false

  onRefreshStart(changedPropertyName: string) {
    if (this.isRefreshing) {
      this.getCategoryList(true, false)
    }
  }

  getCategoryList(isReresh: boolean, isFirst: boolean) {
    const currThis = this

    class CategoryModelChildCallback implements HttpRequestCallback<CategoryModelChild[]> {
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

      onSuccess(response: CategoryModelChild[]): void {
        console.log('Request succeeded with response:', response);

        if (isReresh) {
          currThis.dataList = response
        } else {
          currThis.dataList = [...currThis.dataList, ...response]
        }
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }
    }

    ApiService.getInstance().getCategoryList(new CategoryModelChildCallback());
  }

  aboutToAppear(): void {
    this.getCategoryList(true, true)
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
                Image(item.headerImage).width('50vp').height('50vp').border({ radius: '25vp' })
                Column() {
                  Text(item.name).fontColor('#333333').fontSize('20fp')
                  Text(item.description).fontColor('#999999').fontSize('13fp').margin({ top: '5vp' })
                }.alignItems(HorizontalAlign.Start).margin({ left: '5vp' })
              }.width('100%').height('60vp').padding({ left: '5vp', right: '5vp' })
            }.width('100%')
          }
        })
        if (this.dataList.length > 0) {
          ListItem() {
            RefreshFooter({ showFooter: this.isLoadMore })
          }
        }
      }.listDirection(Axis.Vertical).onReachEnd(() => {
        console.info("MYTAG", "onReachEnd start...")
        this.isLoadMore = true
        this.getCategoryList(false, false)
      })
    }
  }
}