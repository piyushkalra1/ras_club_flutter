 class Menu {
  Menu({
      this.id, 
      this.menuName, 
      this.menuItems, 
      this.rate, 
      this.gst,});

  Menu.fromJson(dynamic json) {
    id = json['Id'];
    menuName = json['MenuName'];
    menuItems = json['MenuItems'];
    rate = json['Rate'];
    gst = json['GST'];
  }
  String ?id;
  String ?menuName;
  String ?menuItems;
  String ?rate;
  String ?gst;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['MenuName'] = menuName;
    map['MenuItems'] = menuItems;
    map['Rate'] = rate;
    map['GST'] = gst;
    return map;
  }

}