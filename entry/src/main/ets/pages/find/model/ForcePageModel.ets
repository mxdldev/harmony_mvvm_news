import { ApiService } from '../../../http/ApiService'
import { FocusModel } from '../../../http/entity/FocusModel';
import { HomeModel } from '../../../http/entity/HomeModel'
import { HttpRequestCallback } from '../../../http/HttpRequest'

export class ForcePageModel {
  getFocusList(homeModelCallback: HttpRequestCallback<FocusModel>) {
    ApiService.getInstance().getFocusList(homeModelCallback);
  }
}