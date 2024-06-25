@Preview
@Component
export default struct Loading {
  private show: boolean = false;

  build() {
    Stack() {
      Shape() {
        Rect().width('100%').height('100%').fill(Color.Transparent)
        Progress({ value: 40, total: 150, type: ProgressType.Ring }).width(100).height(100)
          .color(Color.Black) // 进度条前景色为灰色
          .style({ strokeWidth: 15 }) // 设置strokeWidth进度条宽度为15.0vp
      }.align(Alignment.Center)
    }.width("100%")
    .height("100%")
    .backgroundColor(Color.Transparent)
    .visibility(this.show ? Visibility.Visible : Visibility.Hidden)
  }
}