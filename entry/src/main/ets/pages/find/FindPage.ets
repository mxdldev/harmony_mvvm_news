@Component
export struct FindPage {
  build() {
    Column() {

      Row() { // 使用 Row 布局使文本水平居中
        Text('发现')
          .fontSize('22fp')
          .fontColor('#ffffff')
          .width('100%')
          .height('40vp')
          .align(Alignment.Center) // 文本垂直居中
      }
      .width('100%')
      .height('40vp')
      .backgroundColor('#d81e06')

      Tabs({ barPosition: BarPosition.Start }) {
        TabContent().tabBar(this.TabView('关注'))
        TabContent().tabBar(this.TabView('分类'))
        TabContent().tabBar(this.TabView('主题'))
      }.width('100%').height('50vp').backgroundColor('#d81e06')
    }.width('100%').height('100%')
  }

  @Builder
  TabView(title: string) {
    Text(title).fontColor('#ffffff')
  }
}