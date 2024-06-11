

class GetGameBookingModel {
  String? message;
  List<Bookings>? bookings;

  GetGameBookingModel({this.message, this.bookings});

  GetGameBookingModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(new Bookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bookings {
  String? id;
  String? game;
  String? type;
  String? month;
  String? orderId;
  String? timeSlot;
  String? gST;
  String? amount;
  String? grandTotal;
  String? createdAt;

  Bookings(
      {this.id,
        this.game,
        this.type,
        this.month,
        this.orderId,
        this.timeSlot,
        this.gST,
        this.amount,
        this.grandTotal,
        this.createdAt});

  Bookings.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    game = json['Game'];
    type = json['Type'];
    month = json['Month'];
    orderId = json['OrderId'];
    timeSlot = json['TimeSlot'];
    gST = json['GST'];
    amount = json['Amount'];
    grandTotal = json['GrandTotal'];
    createdAt = json['CreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Game'] = this.game;
    data['Type'] = this.type;
    data['Month'] = this.month;
    data['OrderId'] = this.orderId;
    data['TimeSlot'] = this.timeSlot;
    data['GST'] = this.gST;
    data['Amount'] = this.amount;
    data['GrandTotal'] = this.grandTotal;
    data['CreatedAt'] = this.createdAt;
    return data;
  }
}