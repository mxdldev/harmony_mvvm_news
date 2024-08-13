import { ApiService } from '../../../http/ApiService'
import { HomeModel } from '../../../http/entity/HomeModel'
import { HttpRequestCallback } from '../../../http/HttpRequest'

export class HomePageModel {
  getHomeList(homeModelCallback: HttpRequestCallback<HomeModel>) {
    ApiService.getInstance().getHomeList(homeModelCallback)
  }
}