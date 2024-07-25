import axios, { AxiosResponse } from '@ohos/axios';
import { HomeModel } from './entity/HomeModel'

class ApiService {
  baseUrl: string;

  constructor() {
    this.baseUrl = 'https://baobab.kaiyanapp.com/';
  }

  async getHomeList(date: string): Promise<HomeModel | null> {
    try {
      const response: AxiosResponse<HomeModel> =
        await axios.get<HomeModel, AxiosResponse<HomeModel>, null>(this.baseUrl + "api/v2/feed", {
          params: {
            date // 使用正确的参数名称
          }
        });
      console.log(JSON.stringify(response));
      if (response.status === 200) {
        return response.data;
      } else {
        console.log('请求失败', response);
        throw new Error('请求失败');
      }
    } catch (error) {
      console.error('请求异常', JSON.stringify(error));
      return null; // 处理错误时返回 null
    }
  }
}

const apiService = new ApiService();

export default apiService;
