import router from '@ohos.router'
import BaseToolbar from '../base/BaseToolbar'
import action from '@ohos.promptAction'
import HttpUtils from '../../http/HttpUtils';
import MD5Utils from '../../utils/MD5Utils';

@Entry
@Component
struct Login {
  @State phone: string = "";
  @State password: string = "";

  async login() {
    if (this.phone.length == 0) {
      action.showToast({ message: "请输入手机号" })
      return
    }
    if (this.password.length == 0) {
      action.showToast({ message: "请输入密码" })
      return
    }
    let password = await MD5Utils.getMD5(this.password)
    password = password.substring(8, 24)
    let params = {
      "method": "appUserLogin",
      "data": JSON.stringify({
        "phone": this.phone,
        "password": password
      })
    }
    HttpUtils.post(HttpUtils.getAppUrl() + "eajudms/DmsInterface", params, (code, data, info) => {
      action.showToast({ message: info })
    }, (error) => {
      action.showToast({ message: error.toString() })
    })
  }

  build() {
    Column() {
      BaseToolbar({ title: "登录", showBack: false, showScanCode: false })
      Image($r("app.media.icon_logo")).height(160).width(100).margin({ top: 20 })
      Row() {
        Image($r("app.media.icon_phone_login")).height(30).width(30).margin({ left: 10 })

        TextInput({ placeholder: "请输入手机号", text: this.phone })
          .style(TextInputStyle.Default)
          .type(InputType.Number)
          .backgroundColor(Color.White)
          .width("81.5%")
          .height(60)
          .showPasswordIcon(true)
          .borderRadius(0)
          .onChange((value: string) => {
            this.phone = value;
          })
        Image($r("app.media.icon_delete"))
          .height(25)
          .width(25)
          .margin({ left: 0, right: 0 })
          .visibility(this.phone.length > 0 ? Visibility.Visible : Visibility.Hidden)
          .onClick(() => {
            this.phone = '';
          })

      }.margin({ top: 70 })
      .border({ width: 1, color: $r("app.color.colorGrey") })
      .width("100%")
      .height(60)

      Row() {
        Image($r("app.media.icon_passwod_login")).height(30).width(30).margin({ left: 10 })
        TextInput({ placeholder: "请输入密码", text: this.password })
          .type(InputType.Password)
          .backgroundColor(Color.White)
          .width("90%")
          .height(60)
          .borderRadius(0)
          .showPasswordIcon(this.password.length > 0 ? true : false)
          .border({ width: 0, color: $r("app.color.colorGrey") })
          .margin({ top: 0 })
          .onChange((value: string) => {
            this.password = value;
          })
      }.border({ width: 0, color: $r("app.color.colorGrey") })
      .width("100%")
      .height(60)

      Divider().color($r("app.color.colorGrey")).height(1)


      Row() {
        Text("验证码登录")
          .width("45%")
          .height(20)
          .alignSelf(ItemAlign.Start)
          .fontColor($r("app.color.global_theme_colors"))
          .fontSize(18)
          .margin({ top: 15, left: 10 })
        Text("忘记密码")
          .width("50%")
          .fontSize(18)
          .fontColor($r("app.color.global_theme_colors"))
          .margin({ top: 15, right: 10 })
          .textAlign(TextAlign.End)
      }.width("100%")

      Button('登录')
        .type(ButtonType.Normal)
        .width("95%")
        .height(60)
        .fontSize(20)
        .borderRadius(10)
        .backgroundColor($r("app.color.global_theme_colors"))
        .margin({ top: 30, left: 15, right: 15 })
        .onClick(this.login.bind(this))

      Column() {
        Image($r("app.media.icon_registered"))
          .width(70)
          .height(70)
        Text("免费注册").margin({ top: 10 }).fontColor($r("app.color.global_theme_colors")).fontSize(16)
      }.margin({ top: 30 })

    }
  }
}