import router from '@ohos.router'
import BaseToolbar from '../base/BaseToolbar'

@Entry
@Component
struct Login {
  build() {
    Column() {
      BaseToolbar({ title: "登录", showBack: false, showScanCode: false })
      TextInput().width(250).height(50).margin({ top: 20 })
    }
  }
}