import { TopicModelItemList } from 'lib_api/src/main/ets/http/entity/TopicModel'
import { RefreshFooter } from 'lib_common/src/main/ets/mvvm/view/RefreshFooter';

@Component
export struct TopicPage {
  @Prop dataList: TopicModelItemList[] = []
  onLoadMore: () => void = () => {
  }

  build() {
    Column() {
      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.dataList, (item: TopicModelItemList, index: number) => {
          ListItem() {
            Stack() {
              Image(transformImageUrl(item.data?.image))
                .width('100%')
                .height('210vp')
                .border({ radius: '10vp' })
            }.width('100%').height('210vp')

          }.width('100%')
        })
        if (this.dataList.length > 0) {
          ListItem() {
            RefreshFooter({ showFooter: true })
          }
        }
      }.listDirection(Axis.Vertical).onReachEnd(() => {
        console.info("MYTAG", "onReachEnd start...")
        if (this.dataList.length > 0) {
          this.onLoadMore()
        }
      })
    }
  }
}

const transformImageUrl = (imageUrl: string | undefined): string => {
  // 定义正则表达式和替换字符串
  const regex = /^(https?:\/\/)img\.(.*)$/;
  const replacement = "$1ali-img.$2";

  // 如果 imageUrl 为空或未定义，则返回空字符串
  if (imageUrl === undefined) {
    return "";
  }

  // 使用正则表达式替换符合条件的部分
  return imageUrl.replace(regex, replacement);
};

