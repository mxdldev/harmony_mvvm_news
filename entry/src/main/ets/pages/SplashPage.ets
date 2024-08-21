import router from '@ohos.router';
import { HomeDetailPage } from './home/HomeDetailPage';
import { MainPage } from './MainPage';

@Entry
@Component
struct SplashPage {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()

  @Builder
  pageMap(name: string) {
    if (name === 'HomeDetailPage') {
      HomeDetailPage()
    } else if (name === 'MainPage') {
      MainPage()
    }
  }

  aboutToAppear() {
    setTimeout(() => {
      //router.replaceUrl({url:'pages/MainPage'})
      this.pageInfos.replacePath({ name: 'MainPage' },{launchMode:LaunchMode.STANDARD})
    }, 1000 * 2)
  }

  build() {
    Navigation(this.pageInfos) {
      Column() {
        Image($r("app.media.landing_image")).width("100%").height("100%").objectFit(ImageFit.ScaleDown)
      }.width("100%").height("100%")
    }.navDestination(this.pageMap).hideTitleBar(true).mode(NavigationMode.Stack)
  }
}