class ListItem {
  final String text;
  bool isSelected;
  final String url;

  ListItem(this.text, this.isSelected,this.url);
}

class FoodList{
  final String text;
  final ontap;
  final String url;
  FoodList({required this.ontap,required this.text ,required this.url});
}