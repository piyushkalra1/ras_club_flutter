class LiveCounters {
  LiveCounters({
      this.id, 
      this.itemName, 
      this.rate, 
      this.gst,});

  LiveCounters.fromJson(dynamic json) {
    id = json['Id'];
    itemName = json['ItemName'];
    rate = json['Rate'];
    gst = json['GST'];
  }
  String ?id;
  String ?itemName;
  String ?rate;
  String ?gst;
  bool isselected =false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['ItemName'] = itemName;
    map['Rate'] = rate;
    map['GST'] = gst;
    return map;
  }

}