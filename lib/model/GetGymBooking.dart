class GetGymBookingModel {
  String? message;
  List<Bookings>? bookings;

  GetGymBookingModel({this.message, this.bookings});

  GetGymBookingModel.fromJson(Map<String, dynamic> json) {
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
  String? duration;
  String? pTType;
  String? pTDuration;
  String? orderId;
  String? gST;
  String? amount;
  String? grandTotal;
  String? createdAt;

  Bookings(
      {this.id,
        this.duration,
        this.pTType,
        this.pTDuration,
        this.orderId,
        this.gST,
        this.amount,
        this.grandTotal,
        this.createdAt});

  Bookings.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    duration = json['Duration'];
    pTType = json['PTType'];
    pTDuration = json['PTDuration'];
    orderId = json['OrderId'];
    gST = json['GST'];
    amount = json['Amount'];
    grandTotal = json['GrandTotal'];
    createdAt = json['CreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Duration'] = this.duration;
    data['PTType'] = this.pTType;
    data['PTDuration'] = this.pTDuration;
    data['OrderId'] = this.orderId;
    data['GST'] = this.gST;
    data['Amount'] = this.amount;
    data['GrandTotal'] = this.grandTotal;
    data['CreatedAt'] = this.createdAt;
    return data;
  }
}