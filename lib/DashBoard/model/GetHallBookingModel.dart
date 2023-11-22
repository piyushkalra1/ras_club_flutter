import 'Hallbookings.dart';

class GetHallBookingModel {
  GetHallBookingModel({
       this.message,
       this.hallbookings,});

  GetHallBookingModel.fromJson(dynamic json) {
    message = json['Message'];
    if (json['bookings'] != null) {
      hallbookings = [];
      json['bookings'].forEach((v) {
        hallbookings!.add(Hallbookings.fromJson(v));
      });
    }
  }
  String? message;
  List<Hallbookings> ?hallbookings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    if (hallbookings != null) {
      map['bookings'] = hallbookings!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}