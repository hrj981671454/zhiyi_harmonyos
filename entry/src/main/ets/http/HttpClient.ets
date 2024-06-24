import http from '@ohos.net.http';

export default class HttpClient {
  private static httpRequest: http.HttpRequest;

  public static createHttpRequest(): http.HttpRequest {
    this.httpRequest = http.createHttp();
    return this.httpRequest;
  }

  public static getHttpOptions(method: http.RequestMethod, param: any): http.HttpRequestOptions {
    let opt: http.HttpRequestOptions = {}
    opt.method = method;
    opt.header = {
      'Content-Type': 'application/json;charset=UTF-8',
      'User-Agent': 'HarmonyOS'
    }
    opt.expectDataType = http.HttpDataType.STRING;
    opt.usingCache = true;
    opt.readTimeout = 10000;
    opt.connectTimeout = 10000;
    if (param) {
      opt.extraData = param;
    }
    return opt;
  }

  public static getAppHttpOptions(method: http.RequestMethod, param: any): http.HttpRequestOptions {
    let opt: http.HttpRequestOptions = {}
    opt.method = method;
    opt.header = {
      'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
      'User-Agent': 'HarmonyOS'
    }
    opt.expectDataType = http.HttpDataType.STRING;
    opt.usingCache = true;
    opt.readTimeout = 10000;
    opt.connectTimeout = 10000;
    if (param) {
      opt.extraData = this.objectToQueryString(param);
    }
    return opt;
  }

  private  static objectToQueryString(params: Record<string, string>): string {
    let result = '';
    for (const key in params) {
      const value = params[key];
      result += `${key}=${encodeURIComponent(value)}&`;
    }
    return result.slice(0, -1);
  }
}