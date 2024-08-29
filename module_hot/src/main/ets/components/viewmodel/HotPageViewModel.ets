import { HomeModel } from 'lib_api/src/main/ets/http/entity/HomeModel';
import { HttpRequestCallback } from 'lib_api/src/main/ets/http/HttpRequest';
import { BaseViewModel } from 'lib_common/src/main/ets/mvvm/viewmodel/BaseViewModel';
import hotViewModel, { HotTab } from '../entity/HotTabList';
import { BusinessError } from '@kit.BasicServicesKit';
import { HotPageModel } from '../model/HotPageModel';

export class HotPageViewModel extends BaseViewModel {
  model = new HotPageModel()
  hotTabTitle: HotTab[] = hotViewModel.hotTabTitle
  index: number = 0

  getHotRankList(hotTab: HotTab, isReresh: boolean, isFirst: boolean) {
    console.info("MYTAG", "getHotRankList start,isReresh:" + isReresh + ",isFirst:" + isFirst)
    const currThis = this

    class HotRankCallback implements HttpRequestCallback<HomeModel> {
      onStart(): void {
        console.log('Request started.');
        if (isFirst) {
          //这个页面isShowInitLoading状态不刷新不能关闭loading
          //currThis.loadingProps.isShowInitLoading = true
          currThis.isShowInitLoading = true
        }
        currThis.isRefreshing = isReresh
      }

      onComplete(): void {
        console.log('Request completed.');
        if (isFirst) {
          //currThis.loadingProps.isShowInitLoading = false
          currThis.isShowInitLoading = false
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
        if (isFirst) {
          //currThis.loadingProps.isShowInitLoading = false
          currThis.isShowInitLoading = false
        }
      }
    }

    this.model.getRankList(hotTab.rankType, new HotRankCallback())
  }
}