import { HomeModelIssueListItemList } from '../../../http/entity/HomeModel';

export interface HotTab {
  index: number;
  title: string;
  rankType: string;
  dataList: HomeModelIssueListItemList[]
}

export class HotTabList {
  hotTabTitle: HotTab[] = [
    {
      index: 0,
      title: "周排行",
      rankType: "weekly",
      dataList:[]
    },
    {
      index: 1,
      title: "月排行",
      rankType: "monthly",
      dataList:[]
    },
    {
      index: 2,
      title: "总排行",
      rankType: "historical",
      dataList:[]
    }
  ];
}

let hotViewModel = new HotTabList();

export default hotViewModel;
