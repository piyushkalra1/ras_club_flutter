class DashboardsModel {
  DashboardsModel({
       this.message,
       this.bookings,});

  DashboardsModel.fromJson(dynamic json) {
    message = json['Message'];
    if (json['bookings'] != null) {
      bookings  = [];
      json['bookings'].forEach((v) {
        bookings!.add((v));
      });
    }
  }
  String ?message;
  List<dynamic> ?bookings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    if (bookings != null) {
      map['bookings'] = bookings!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

