import router from '@ohos.router'
import BaseToolbar from '../base/BaseToolbar'
import action from '@ohos.promptAction'

@Entry
@Component
struct Login {
  @State phone: string = "";
  @State password: string = "";

  login() {
    if (this.phone.length == 0) {
      action.showToast({ message: "请输入手机号" })
      return
    }
    if (this.password.length == 0) {
      action.showToast({ message: "请输入密码" })
      return
    }
    action.showToast({ message: "登录了" })
  }

  build() {
    Column() {
      BaseToolbar({ title: "登录", showBack: false, showScanCode: false })
      Image($r("app.media.icon_logo")).height(160).width(100).margin({ top: 20 })
      Row() {
        Image($r("app.icon_phone_login.icon_logo")).height(30).width(30)

        TextInput({ placeholder: "请输入手机号", text: this.phone })
          .style(TextInputStyle.Default)
          .type(InputType.Number)
          .backgroundColor(Color.White)
          .border({ width: 1, color: $r("app.color.colorGrey") })
          .width("100%")
          .height(60)
          .borderRadius(0)
          .onChange((value: string) => {
            this.phone = value;
          })
      }.margin({ top: 80 })

      TextInput({ placeholder: "请输入密码", text: this.password })
        .type(InputType.Password)
        .backgroundColor(Color.White)
        .width("100%")
        .height(60)
        .borderRadius(0)
        .border({ width: 0, color: $r("app.color.colorGrey") })
        .margin({ top: 0 })
        .onChange((value: string) => {
          this.password = value;
        })
      Divider().color($r("app.color.colorGrey")).height(1)
      Button('登录')
        .type(ButtonType.Capsule)
        .width("80%")
        .height(60)
        .fontSize(20)
        .backgroundColor($r("app.color.global_theme_colors"))
        .margin({ top: 30, left: 15, right: 15 })
        .onClick(this.login.bind(this))
    }
  }
}