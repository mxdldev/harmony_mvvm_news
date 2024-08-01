import { router } from '@kit.ArkUI';

@Component
export struct HomeDetailPage {
  @State dataId: number = 0
  @State playUrl: string = ''

  aboutToAppear(): void {
    const params = router.getParams() as Record<string, string>; // 获取传递过来的参数对象
    this.dataId = params.id as number;
    this.playUrl = params.playUrl as string;
  }

  build() {
  }
}