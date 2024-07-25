import router from '@ohos.router';
@Entry
@Component
struct SplashPage {
  aboutToAppear(){
    setTimeout(()=>{
       router.replaceUrl({url:'pages/MainPage'})
    },1000 * 2)
  }
  build() {
    Column() {
      Image($r("app.media.landing_image")).width("100%").height("100%")
    }.width("100%").height("100%")
  }
}