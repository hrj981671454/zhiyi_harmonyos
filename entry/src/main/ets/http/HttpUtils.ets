import http from '@ohos.net.http';
import { NetworkEnvironment } from './NetworkEnvironment'
import HttpClient from './HttpClient'
import { RequestCallback } from './RequestCallback'

export default class HttpUtils {

  // 接口环境
  public static readonly networkEnvironment: string = NetworkEnvironment.RELEASE;

  public static getAppUrl(): string {
    if (HttpUtils.networkEnvironment == NetworkEnvironment.RELEASE) {
      return "https://superapp.51eanj.com/eaju_app_service/";
    } else if (HttpUtils.networkEnvironment == NetworkEnvironment.TEST) {
      return "https://tsuperapp.51eanj.com/eaju_app_service/";
    } else if (HttpUtils.networkEnvironment == NetworkEnvironment.DEV) {
      return "http://172.20.32.161:8080/eaju_app_service/";
    }
    return "https://superapp.51eanj.com/eaju_app_service/";
  }

  public static getOpenUrl(): string {
    if (HttpUtils.networkEnvironment == NetworkEnvironment.RELEASE) {
      return "https://wx.51eanj.com/eaju-open-api/";
    } else if (HttpUtils.networkEnvironment == NetworkEnvironment.TEST) {
      return "https://twx.51eanj.com/eaju-open-api/";
    } else if (HttpUtils.networkEnvironment == NetworkEnvironment.DEV) {
      return "http://172.20.32.161:8080/eaju-open-api/";
    }
    return "https://wx.51eanj.com/eaju-open-api/";
  }

  public static getTrackUrl(): string {
    if (HttpUtils.networkEnvironment == NetworkEnvironment.RELEASE) {
      return "https://track.51eanj.com/eaju-track-api/";
    } else if (HttpUtils.networkEnvironment == NetworkEnvironment.TEST) {
      return "https://t_track.51eanj.com/eaju-track-api/";
    } else if (HttpUtils.networkEnvironment == NetworkEnvironment.DEV) {
      return "http://172.20.32.161:8080/eaju-track-api/";
    }
    return "https://track.51eanj.com/eaju-track-api/";
  }

  public static getImsUrl(): string {
    if (HttpUtils.networkEnvironment == NetworkEnvironment.RELEASE) {
      return "https://ims.51eanj.com/";
    } else if (HttpUtils.networkEnvironment == NetworkEnvironment.TEST) {
      return "https://timsweb.51eanj.com/";
    }
    return "https://ims.51eanj.com/";
  }

  public static getHtmlUrl(): string {
    if (HttpUtils.networkEnvironment == NetworkEnvironment.RELEASE) {
      return "https://wx.51eanj.com/superGuide/release/";
    } else if (HttpUtils.networkEnvironment == NetworkEnvironment.TEST) {
      return "https://wx.51eanj.com/superGuide/test/";
    }
    return "https://wx.51eanj.com/superGuide/release/JG/";
  }

  public static getUniUrl(): string {
    if (HttpUtils.networkEnvironment == NetworkEnvironment.RELEASE) {
      return "https://wx.51eanj.com/superGuide/release/uh5/#/";
    } else if (HttpUtils.networkEnvironment == NetworkEnvironment.TEST) {
      return "https://wx.51eanj.com/superGuide/test/uh5/#/";
    }
    return "https://wx.51eanj.com/superGuide/release/uh5/#/";
  }


  public static get(url: string, successCallback: Function, errorCallback: Function) {
    HttpClient
      .createHttpRequest()
      .request(url, HttpClient.getAppHttpOptions(http.RequestMethod.GET, null))
      .then(data => {
        successCallback(data.result);
      })
      .catch(error => {
        errorCallback(error)
      });
  }

  public static post(url: string, data: any, successCallback: Function, errorCallback: Function) {
    HttpClient
      .createHttpRequest()
      .request(url, HttpClient.getAppHttpOptions(http.RequestMethod.POST, data))
      .then(data => {
        let json = JSON.parse(data.result.toString())
        if ("returnCode" in json) {
          successCallback(json.returnCode, json.data, json.info)
          return;
        }
        if ("errCode" in json && "resultData" in json) {
          successCallback(json.errCode, json.data, json.retMessage)
          return;
        }
        successCallback(json)
      })
      .catch(error => {
        errorCallback(error)
      });
  }

  public static postJson(url: string, data: any, successCallback: Function, errorCallback: Function) {
    HttpClient
      .createHttpRequest()
      .request(url, HttpClient.getHttpOptions(http.RequestMethod.POST, data))
      .then(data => {
        successCallback(JSON.parse(data.result.toString()));
      })
      .catch(error => {
        errorCallback(error)
      });
  }
}
