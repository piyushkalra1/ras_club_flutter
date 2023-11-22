class Hallbookings {
  Hallbookings({
      this.id, 
      this.hallType, 
      this.fdate, 
      this.ftime, 
      this.orderId, 
      this.totalPlates, 
      this.menu, 
      this.extraItems, 
      this.ratePerPlate, 
      this.gst, 
      this.totalAmount, 
      this.grandTotal, 
      this.advancePaid, 
      this.bookFor, 
      this.functionType, 
      this.hostName, 
      this.hostMobile, 
      this.createdAt, 
      this.status,});

  Hallbookings.fromJson(dynamic json) {
    id = json['Id'];
    hallType = json['HallType'];
    fdate = json['Fdate'];
    ftime = json['Ftime'];
    orderId = json['OrderId'];
    totalPlates = json['TotalPlates'];
    menu = json['Menu'];
    extraItems = json['ExtraItems'];
    ratePerPlate = json['RatePerPlate'];
    gst = json['GST'];
    totalAmount = json['TotalAmount'];
    grandTotal = json['GrandTotal'];
    advancePaid = json['AdvancePaid'];
    bookFor = json['BookFor'];
    functionType = json['FunctionType'];
    hostName = json['HostName'];
    hostMobile = json['HostMobile'];
    createdAt = json['CreatedAt'];
    status = json['Status'];
  }
  String? id;
  String ?hallType;
  String ?fdate;
  String ?ftime;
  String ?orderId;
  String ?totalPlates;
  String ?menu;
  String ?extraItems;
  String ?ratePerPlate;
  String ?gst;
  String ?totalAmount;
  String ?grandTotal;
  String ?advancePaid;
  String ?bookFor;
  String ?functionType;
  String ?hostName;
  String ?hostMobile;
  String ?createdAt;
  String ?status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['HallType'] = hallType;
    map['Fdate'] = fdate;
    map['Ftime'] = ftime;
    map['OrderId'] = orderId;
    map['TotalPlates'] = totalPlates;
    map['Menu'] = menu;
    map['ExtraItems'] = extraItems;
    map['RatePerPlate'] = ratePerPlate;
    map['GST'] = gst;
    map['TotalAmount'] = totalAmount;
    map['GrandTotal'] = grandTotal;
    map['AdvancePaid'] = advancePaid;
    map['BookFor'] = bookFor;
    map['FunctionType'] = functionType;
    map['HostName'] = hostName;
    map['HostMobile'] = hostMobile;
    map['CreatedAt'] = createdAt;
    map['Status'] = status;
    return map;
  }

}