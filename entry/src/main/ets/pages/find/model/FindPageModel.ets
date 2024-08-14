import { ApiService } from '../../../http/ApiService';
import { CategoryModelChild } from '../../../http/entity/CategoryModel';
import { FocusModel } from '../../../http/entity/FocusModel';
import { TopicModel } from '../../../http/entity/TopicModel';
import { HttpRequestCallback } from '../../../http/HttpRequest';

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