import { CategoryModelChild } from 'lib_api/src/main/ets/http/entity/CategoryModel';
import { FocusModel, FocusModelItemList } from 'lib_api/src/main/ets/http/entity/FocusModel';
import { HttpRequestCallback } from 'lib_api/src/main/ets/http/HttpRequest';
import { BaseViewModel } from 'lib_common/src/main/ets/mvvm/viewmodel/BaseViewModel';
import { BusinessError } from '@kit.BasicServicesKit';
import { TopicModel, TopicModelItemList } from 'lib_api/src/main/ets/http/entity/TopicModel';
import { FindPageModel } from '../model/FindPageModel';

@Observed
export class FindPageViewModel extends BaseViewModel {
  model = new FindPageModel()
  dataListFocusModelItemList: FocusModelItemList[] = []
  dataListCategoryModelChild: CategoryModelChild[] = []
  dataListTopicModelItemList: TopicModelItemList[] = []
  index: number = 0
  getFocusList(isReresh: boolean, isFirst: boolean) {
    console.info("MYTAG","getFocusList start,isReresh:"+isReresh+",isFirst:"+isFirst)
    const currThis = this
    class FocusModelCallback implements HttpRequestCallback<FocusModel> {
      onStart(): void {
        console.log('Request started.');
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = true
        }
        currThis.isRefreshing = isReresh
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
          currThis.dataListFocusModelItemList = response.itemList
        } else {
          currThis.dataListFocusModelItemList = [...currThis.dataListFocusModelItemList, ...response.itemList]
        }
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }
    }

    this.model.getFocusList(new FocusModelCallback());
  }


  getCategoryList(isReresh: boolean, isFirst: boolean) {
    console.info("MYTAG","getCategoryList start,isReresh:"+isReresh+",isFirst:"+isFirst)
    const currThis = this
    class CategoryModelChildCallback implements HttpRequestCallback<CategoryModelChild[]> {
      onStart(): void {
        console.log('Request started.');
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = true
        }
        currThis.isRefreshing = isReresh
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
          currThis.dataListCategoryModelChild = response
        } else {
          currThis.dataListCategoryModelChild = [...currThis.dataListCategoryModelChild, ...response]
        }
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }
    }

    this.model.getCategoryList(new CategoryModelChildCallback());
  }

  getTopicList(isReresh: boolean, isFirst: boolean) {
    console.info("MYTAG","getTopicList start,isReresh:"+isReresh+",isFirst:"+isFirst)
    const currThis = this
    class TopicModelCallback implements HttpRequestCallback<TopicModel> {
      onStart(): void {
        console.log('Request started.');
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = true
        }
        currThis.isRefreshing = isReresh
      }

      onComplete(): void {
        console.log('Request completed.');
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = false
        }
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }

      onSuccess(response: TopicModel): void {
        console.log('Request succeeded with response:', response);

        if (isReresh) {
          currThis.dataListTopicModelItemList = response.itemList
        } else {
          currThis.dataListTopicModelItemList = [...currThis.dataListTopicModelItemList, ...response.itemList]
        }
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }
    }

    this.model.getTopicList(new TopicModelCallback());
  }
}