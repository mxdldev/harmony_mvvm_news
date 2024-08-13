import { ApiService } from '../../../http/ApiService'
import { HomeModel } from '../../../http/entity/HomeModel'
import { HttpRequestCallback } from '../../../http/HttpRequest'

export class HomeDetailModel {
  getHomeDetail(id: number, homeModelCallback: HttpRequestCallback<HomeModel>) {
    ApiService.getInstance().getHomeDetail(id, homeModelCallback);
  }
}