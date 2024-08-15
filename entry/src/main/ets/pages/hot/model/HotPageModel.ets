import { ApiService } from '../../../http/ApiService';
import { HomeModel } from '../../../http/entity/HomeModel';
import { HttpRequestCallback } from '../../../http/HttpRequest';

export class HotPageModel {
  getRankList(rankType: string, callback: HttpRequestCallback<HomeModel>) {
    ApiService.getInstance().getHotRankList(rankType, callback);
  }
}