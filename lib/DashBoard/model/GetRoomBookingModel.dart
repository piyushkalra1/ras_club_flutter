import 'Bookings.dart';

class GetRoomBookingModel {
  GetRoomBookingModel({
      this.message, 
      this.bookings,});

  GetRoomBookingModel.fromJson(dynamic json) {
    message = json['Message'];
    if (json['bookings'] != null) {
      bookings = [];
      json['bookings'].forEach((v) {
        bookings!.add(Bookings.fromJson(v));
      });
    }
  }
  String? message;
  List<Bookings>? bookings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    if (bookings != null) {
      map['bookings'] = bookings!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}