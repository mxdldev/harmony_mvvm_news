export type CategoryModel = CategoryModelChild[];

export interface CategoryModelChild {
  id: number;
  name: string;
  description: string;
  bgPicture: string;
  bgColor: string;
  headerImage: string;
  defaultAuthorId: number;
  tagId: number;
}