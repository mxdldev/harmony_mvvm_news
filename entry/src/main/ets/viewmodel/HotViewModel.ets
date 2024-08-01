export interface HotTab {
  index: number;
  title: string;
  rankType: string;
}

export class HotViewModel {
  hotTabTitle: HotTab[] = [
    {
      index: 0,
      title: "周排行",
      rankType: "weekly"
    },
    {
      index: 1,
      title: "月排行",
      rankType: "monthly"
    },
    {
      index: 2,
      title: "总排行",
      rankType: "historical"
    }
  ];
}

let hotViewModel = new HotViewModel();

export default hotViewModel;
