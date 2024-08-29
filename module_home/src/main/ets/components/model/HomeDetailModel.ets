import { ApiService } from 'lib_api/src/main/ets/http/ApiService'
import { HomeModel } from 'lib_api/src/main/ets/http/entity/HomeModel'
import { HttpRequestCallback } from 'lib_api/src/main/ets/http/HttpRequest'

export class HomeDetailModel {
  getHomeDetail(id: number, homeModelCallback: HttpRequestCallback<HomeModel>) {
    ApiService.getInstance().getHomeDetail(id, homeModelCallback);
  }
}