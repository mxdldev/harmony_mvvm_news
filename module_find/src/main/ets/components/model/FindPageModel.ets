import { ApiService } from 'lib_api/src/main/ets/http/ApiService';
import { CategoryModelChild } from 'lib_api/src/main/ets/http/entity/CategoryModel';
import { FocusModel } from 'lib_api/src/main/ets/http/entity/FocusModel';
import { TopicModel } from 'lib_api/src/main/ets/http/entity/TopicModel';
import { HttpRequestCallback } from 'lib_api/src/main/ets/http/HttpRequest';

export class  FindPageModel{
  getFocusList(homeModelCallback: HttpRequestCallback<FocusModel>) {
    ApiService.getInstance().getFocusList(homeModelCallback);
  }
  getCategoryList(homeModelCallback: HttpRequestCallback<CategoryModelChild[]>) {
    ApiService.getInstance().getCategoryList(homeModelCallback);
  }
  getTopicList(homeModelCallback: HttpRequestCallback<TopicModel>) {
    ApiService.getInstance().getTopicList(homeModelCallback);
  }
}