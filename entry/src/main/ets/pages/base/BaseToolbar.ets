import router from '@ohos.router'
import prompt from '@ohos.promptAction'
import { STATUS_BAR_HEIGHT } from './StatusBarManager'

@Preview
@Component
export default struct BaseToolbar {
  private title: string = "登录"
  private showBack: boolean = true
  private showScanCode: boolean = true
  @StorageLink(STATUS_BAR_HEIGHT) statusBarHeight: number = 0

  build() {
    Column() {
      // 在界面顶部放置一个与状态栏同高度的组件，用于占位，可避免界面内容与状态栏内容重叠
      Row().height(px2vp(this.statusBarHeight))

      Stack() {
        Text(this.title)
          .fontColor(Color.White)
          .fontSize(19)
          .fontWeight(500)

        Row() {
          Image($r("app.media.icon_back"))
            .width(25)
            .height(25)
            .margin({ left: 20 })
            .visibility(this.showBack ? Visibility.Visible : Visibility.Hidden)
            .onClick(() => {
              // 关闭当前页面
              router.back()
            })
        }.height("100%")
        .width("100%")
        .justifyContent(FlexAlign.Start)

        Row() {
          Image($r('app.media.icon_scancode'))
            .width(25)
            .height(25)
            .margin({ right: 18 })
            .visibility(this.showScanCode ? Visibility.Visible : Visibility.Hidden)
            .onClick(() => {
              prompt.showToast({ message: "功能正在开发中...", duration: 2000 })
            })
        }.height("100%")
        .width("100%")
        .justifyContent(FlexAlign.End)
      }
      .width("100%")
      .height(53)
    }.backgroundColor($r("app.color.base_tool_bar"))
  }
}