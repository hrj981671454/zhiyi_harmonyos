import router from '@ohos.router'
import HttpUtils from '../http/HttpUtils'
import action from '@ohos.promptAction'

@Entry
@Component
struct Index {
  checkVersion(): void {
    let params = {
      "phone": "13341538592",
      "version": 3.91,
      "channel": "appStore",
      "brand": "HUAWEI",
      "os": "HarmonyOS"
    }
    HttpUtils.post(HttpUtils.getAppUrl() + "super/updateVersion", params, (code, data, info) => {
      if (code == 200) {
        if (data.flag == 0) {
          setTimeout(() => {
            router.replaceUrl({ url: "pages/login/Login" })
          }, 1000)
        } else {
          action.showToast({ message: data.notice })
        }
      }
    }, (error) => {
      action.showToast({ message: error })
    })
  }

  onPageShow() {
    this.checkVersion();
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Image($r("app.media.icon_splash"))
        .width("100%")
        .height("100%")
      Button("检测更新")
        .width(100)
        .height(50)
        .alignSelf(ItemAlign.Center)
        .margin({ bottom: 50 })
        .visibility(Visibility.Hidden)
        .onClick(() => {
          router.pushUrl({ url: "/pages/login/Login" }, router.RouterMode.Single, (err) => {
            action.showToast({ message: err.toString() })
          })
        })
    }.width("100%")
  }
}