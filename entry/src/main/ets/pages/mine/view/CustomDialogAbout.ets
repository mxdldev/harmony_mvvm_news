@CustomDialog
export struct CustomDialogAbout {
  controller: CustomDialogController = new CustomDialogController({
    builder: CustomDialogAbout({}),
  })

  build() {
    Column() {
      Text($r('app.string.project_desc'))
        .fontSize(20)
        .lineHeight(25)
        .margin({ top: 10, bottom: 10 }).padding(15)
    }
  }
}