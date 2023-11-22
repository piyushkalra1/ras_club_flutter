class ItemListModel {
  ItemListModel({
      this.id, 
      this.name,
    this.imageurl,
     });

  ItemListModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    imageurl = json['image'];
  }
  int ?id;
  String ?name;
  int count = 0;
  String ?imageurl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['count'] = count;
    map['imageurl']=imageurl;
    return map;
  }

}