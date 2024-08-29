import { ApiService } from 'lib_api/src/main/ets/http/ApiService'
import { FocusModel } from 'lib_api/src/main/ets/http/entity/FocusModel';
import { HomeModel } from 'lib_api/src/main/ets/http/entity/HomeModel'
import { HttpRequestCallback } from 'lib_api/src/main/ets/http/HttpRequest'

export class ForcePageModel {
  getFocusList(homeModelCallback: HttpRequestCallback<FocusModel>) {
    ApiService.getInstance().getFocusList(homeModelCallback);
  }
}