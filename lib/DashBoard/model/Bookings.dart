class Bookings {
  Bookings({
      this.id, 
      this.roomType, 
      this.checkin, 
      this.checkout, 
      this.gst,
    this.totalroom,
      this.totalFair, 
      this.grandTotal, 
      this.createdAt, 
      this.orderId, 
      this.bookingFor, 
      this.extraBed, 
      this.status,});

  Bookings.fromJson(dynamic json) {
    id = json['Id'];
    totalroom = json['TotalRooms'];
    roomType = json['RoomType'];
    checkin = json['Checkin'];
    checkout = json['Checkout'];
    gst = json['GST'];
    totalFair = json['TotalFair'];
    grandTotal = json['GrandTotal'];
    createdAt = json['CreatedAt'];
    orderId = json['OrderId'];
    bookingFor = json['BookingFor'];
    extraBed = json['ExtraBed'];
    status = json['Status'];
  }
  String ?id;
  String ?roomType;
  String ?checkin;
  String ?checkout;
  String ?gst;
  String ?totalFair;
  String ?grandTotal;
  String ?createdAt;
  String ?orderId;
  String ?bookingFor;
  String ?extraBed;
  String ?status;
  String ? totalroom;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map ['TotalRooms'] =totalroom;

    map['RoomType'] = roomType;
    map['Checkin'] = checkin;
    map['Checkout'] = checkout;
    map['GST'] = gst;
    map['TotalFair'] = totalFair;
    map['GrandTotal'] = grandTotal;
    map['CreatedAt'] = createdAt;
    map['OrderId'] = orderId;
    map['BookingFor'] = bookingFor;
    map['ExtraBed'] = extraBed;
    map['Status'] = status;
    return map;
  }

}