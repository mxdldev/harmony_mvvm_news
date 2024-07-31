@Component
export struct HotPage {
  build() {
    Column(){
      Tabs(){
        TabContent(){}.tabBar('周排行')
        TabContent(){}.tabBar('月排行')
        TabContent(){}.tabBar('年排行')
      }
    }
  }
}