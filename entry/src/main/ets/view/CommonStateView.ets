@Component
export struct CommonStateView {
  build() {
    Stack() {
      Column() {
        Image($r('app.media.loading'))
        Text('加载中')
      }
      Column() {
        Image($r('app.media.common_loading'))
        Text('加载中')
      }
      Column() {
        Image($r('app.media.common_empty_content'))
        Text('暂无数据')
      }
      Column() {
        Image($r('app.media.timeout'))
        Text('网络错误')
      }
    }
  }
}