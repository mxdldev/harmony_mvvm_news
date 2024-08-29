import { HomeModelIssueListItemList } from 'lib_api/src/main/ets/http/entity/HomeModel';

@Observed
export class HotTab {
  index: number = 0;
  title: string = "";
  rankType: string = "";
  dataList: HomeModelIssueListItemList[] = []
}

@Observed
export class HotTabList {
  hotTabTitle: HotTab[] = [
    {
      index: 0,
      title: "周排行",
      rankType: "weekly",
      dataList: []
    },
    {
      index: 1,
      title: "月排行",
      rankType: "monthly",
      dataList: []
    },
    {
      index: 2,
      title: "总排行",
      rankType: "historical",
      dataList: []
    }
  ];
}

let hotViewModel = new HotTabList();

export default hotViewModel;
