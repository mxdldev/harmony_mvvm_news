import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';

interface HttpRequestCallback<T> {
  onStart(): void;

  onComplete(): void;

  onSuccess(response: T): void;

  onFailure(error: BusinessError): void;
}

class HttpRequest {
  private static instance: HttpRequest | null = null;
  private baseUrl: string = "https://baobab.kaiyanapp.com/";

  private constructor() {
  }

  public static getInstance(): HttpRequest {
    if (!HttpRequest.instance) {
      HttpRequest.instance = new HttpRequest();
    }
    return HttpRequest.instance;
  }

  public get<T>(url: string, callback: HttpRequestCallback<T>): void {
    callback.onStart();
    const session = rcp.createSession();
    session.get(this.baseUrl + url)
      .then((response): Promise<T> => {
        return response.toJSON() as Promise<T>;
      })
      .then((data: T): void => {
        callback.onSuccess(data);
      })
      .catch((error: BusinessError): void => {
        callback.onFailure(error);
      })
      .finally((): void => {
        callback.onComplete();
        session.close();
      });
  }
}

export { HttpRequest, HttpRequestCallback };