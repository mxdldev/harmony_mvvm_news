import { ApiService } from '../../../http/ApiService';
import { HomeModel } from '../../../http/entity/HomeModel';
import { HttpRequestCallback } from '../../../http/HttpRequest';
import { BaseViewModel } from '../../../mvvm/viewmodel/BaseViewModel';
import hotViewModel, { HotTab } from '../entity/HotTabList';
import { BusinessError } from '@kit.BasicServicesKit';
import { HotPageModel } from '../model/HotPageModel';

export class HotPageViewModel extends BaseViewModel {
  model = new HotPageModel()
  hotTabTitle: HotTab[] = hotViewModel.hotTabTitle
  getHotRankList(hotTab: HotTab, isReresh: boolean, isFirst: boolean) {
    const currThis = this

    class HotRankCallback implements HttpRequestCallback<HomeModel> {
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

        if (isReresh) {
          hotTab.dataList = response.itemList
        } else {
          hotTab.dataList = [...hotTab.dataList, ...response.itemList]
        }
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }
    }

    this.model.getRankList(hotTab.rankType, new HotRankCallback())
  }
}