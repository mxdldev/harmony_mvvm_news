import { CustomDialogAbout } from './view/CustomDialogAbout'

@Component
export struct MinePage {
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogAbout(),
  })

  build() {
    Column() {
      Column() {
        Image($r('app.media.default_avatar')).width('70vp').height('70vp').border({ radius: '35vp' })
        Text('Harmony-example').fontColor('#ffffff').fontSize('15sp').margin({ top: '5vp' })
      }.width('100%').height('250vp').backgroundImage($r('app.media.back_mine')).justifyContent(FlexAlign.Center)

      Stack({ alignContent: Alignment.Bottom }) {
        Row() {
          Image($r('app.media.icon_focus')).width('25vp').height('25vp')
          Text('关注').fontSize('15fp').fontColor('#333333').margin({ left: '10vp' })
        }.width('100%').height('50vp')

        Divider().width('100%').color('#f5f5f5')
      }.width('100%').height('50vp').margin({ left: '10vp' })

      Stack({ alignContent: Alignment.Bottom }) {
        Row() {
          Image($r('app.media.icon_topic')).width('25vp').height('25vp')
          Text('主题').fontSize('15fp').fontColor('#333333').margin({ left: '10vp' })
        }.width('100%').height('50vp')

        Divider().width('100%').color('#f5f5f5')
      }.width('100%').height('50vp').margin({ left: '10vp' })

      Stack({ alignContent: Alignment.Bottom }) {
        Row() {
          Image($r('app.media.icon_focus')).width('25vp').height('25vp')
          Text('热门').fontSize('15fp').fontColor('#333333').margin({ left: '10vp' })
        }.width('100%').height('50vp')

        Divider().width('100%').color('#f5f5f5')
      }.width('100%').height('50vp').margin({ left: '10vp' })

      Stack({ alignContent: Alignment.Bottom }) {
        Row() {
          Image($r('app.media.icon_about')).width('25vp').height('25vp')
          Text('关于').fontSize('15fp').fontColor('#333333').margin({ left: '10vp' })
        }.width('100%').height('50vp').onClick(() => {
          this.dialogController.open()
        })

        Divider().width('100%').color('#f5f5f5')
      }.width('100%').height('50vp').margin({ left: '10vp' })
    }.width('100%').height('100%')
  }
}