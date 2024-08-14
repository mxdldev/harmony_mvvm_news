import { PageState } from '../view/CommonRootPage'
@Observed
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