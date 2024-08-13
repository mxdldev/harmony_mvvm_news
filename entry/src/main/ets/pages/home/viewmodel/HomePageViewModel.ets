import { HomeModel, HomeModelIssueListItemList } from '../../../http/entity/HomeModel';
import { BaseViewModel } from '../../../mvvm/viewmodel/BaseViewModel';
import { HttpRequestCallback } from '../../../http/HttpRequest';
import { BusinessError } from '@kit.BasicServicesKit';
import { HomePageModel } from '../model/HomePageModel';

export class HomePageViewModel extends BaseViewModel {
  model = new HomePageModel()
  dataList: HomeModelIssueListItemList[] = []

  getHomeList(isReresh: boolean, isFirst: boolean) {
    const currThis = this

    class HomeModelCallback implements HttpRequestCallback<HomeModel> {
      onStart(): void {
        console.log('Request started.');
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = true
        }
        currThis.isRefreshing = true
      }

      onComplete(): void {
        console.log('Request completed.');
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = false
        }
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }

      onSuccess(response: HomeModel): void {
        console.log('Request succeeded with response:', response);
        let items = response.issueList[0].itemList
        let list = items.filter((item) => item.type == "video")
        if (isReresh) {
          currThis.dataList = list
        } else {
          currThis.dataList = [...currThis.dataList, ...list]
        }
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }
    }

    this.model.getHomeList(new HomeModelCallback());
  }
}