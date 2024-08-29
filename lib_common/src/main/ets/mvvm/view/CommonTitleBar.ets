import router from '@ohos.router';

@Component
export struct CommonTitleBar {
  @Consume('navPathStack') navPathStack: NavPathStack;
  @State isShowBackBtn:boolean = true
  @State title:string = ''
  build() {
    RelativeContainer() {
      if(this.isShowBackBtn){
        Image($r('app.media.ic_action_back'))
          .width('16vp')
          .height('16vp')
          .margin({ left: '20vp' })
          .alignRules({ center: { anchor: '__container__', align: VerticalAlign.Center } })
          .onClick(() => {
            //router.back()
            this.navPathStack.pop()
          })
      }
      Text(this.title)
        .fontColor('#ffffff')
        .fontSize('15fp')
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }.width('100%').height('50vp').backgroundColor('#d81e06')
  }
}
