import { PageState } from '../view/CommonRootPage'
export class BaseViewModel{
  loadingProps: PageState = {
    isShowInitLoading: false,
    isShowTransparentLoading: false,
    isShowNoData: false,
    isShowNetErr: false,
  }
  isRefreshing: boolean = false
  isLoadMore: boolean = false
}