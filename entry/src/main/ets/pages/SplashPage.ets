import router from '@ohos.router';
import { HomeDetailPage } from 'module_home/src/main/ets/components/HomeDetailPage';
import { MainPage } from './MainPage';

@Entry
@Component
struct SplashPage {
  aboutToAppear() {
    setTimeout(() => {
      router.replaceUrl({ url: 'pages/MainPage' })
    }, 1000 * 2)
  }

  build() {

    Column() {
      Image($r("app.media.landing_image")).width("100%").height("100%").objectFit(ImageFit.Cover)
    }.width("100%").height("100%")
  }
}