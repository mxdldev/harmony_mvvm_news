import { ApiService } from 'lib_news_api/src/main/ets/http/ApiService'
import { HomeModel } from 'lib_news_api/src/main/ets/http/entity/HomeModel'
import { HttpRequestCallback } from 'lib_news_api/src/main/ets/http/HttpRequest'

export class HomePageModel {
  getHomeList(homeModelCallback: HttpRequestCallback<HomeModel>) {
    ApiService.getInstance().getHomeList(homeModelCallback)
  }
}