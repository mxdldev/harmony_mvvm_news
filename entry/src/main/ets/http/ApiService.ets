import { FocusModel } from '../model/FocusModel';
import { HomeModel } from './entity/HomeModel';
import { HttpRequest, HttpRequestCallback } from './HttpRequest';

class ApiService {
  private static instance: ApiService | null = null;
  private httpRequest: HttpRequest;

  private constructor() {
    this.httpRequest = HttpRequest.getInstance()
  }

  public static getInstance(): ApiService {
    if (!ApiService.instance) {
      ApiService.instance = new ApiService();
    }
    return ApiService.instance;
  }

  /**
   * 获取首页列表
   * @param callback
   */
  public getHomeList(callback: HttpRequestCallback<HomeModel>): void {
    this.httpRequest.get<HomeModel>("api/v2/feed", callback);
  }

  /**
   * 获取首页列表
   * @param callback
   */
  public getHomeDetail(id: number, callback: HttpRequestCallback<HomeModel>): void {
    this.httpRequest.get<HomeModel>("api/v4/video/related?id=" + id, callback);
  }

  /**
   * 获取发现关注列表
   * @param callback
   */
  public getFocusList(callback: HttpRequestCallback<FocusModel>): void {
    this.httpRequest.get<FocusModel>("api/v4/tabs/follow", callback);
  }
}

export { ApiService };