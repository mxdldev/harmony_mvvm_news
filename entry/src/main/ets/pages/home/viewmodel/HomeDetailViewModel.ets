import { HomeModel, HomeModelIssueListItemList } from '../../../http/entity/HomeModel'
import { HttpRequestCallback } from '../../../http/HttpRequest'
import { PageState } from '../../../mvvm/view/CommonRootPage'
import { BusinessError } from '@kit.BasicServicesKit'
import { ApiService } from '../../../http/ApiService'
import { BaseViewModel } from '../../../mvvm/viewmodel/BaseViewModel'
import { HomeDetailModel } from '../model/HomeDetailModel'

export class HomeDetailViewModel extends BaseViewModel {
  model = new HomeDetailModel()
  dataId: number = 0
  playUrl: string = ''
  dataList: HomeModelIssueListItemList[] = []
  controller: VideoController | undefined;
  previewUris: Resource = $r('app.media.landing_image');

  getHomeDetail(isFirst: boolean) {
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
      }

      onSuccess(response: HomeModel): void {
        console.log('Request succeeded with response:', response);
        currThis.dataList = response.itemList
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
      }
    }

    this.model.getHomeDetail(this.dataId, new HomeModelCallback());
  }
}