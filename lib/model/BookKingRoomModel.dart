class BookKingRoomModel {
  BookKingRoomModel({
      this.message, 
      this.availablity, 
      this.noOfRoomsAvailable, 
      this.totalFair, 
      this.totalGST, 
      this.grandTotal, 
      this.totalNights, 
      this.outsiderReserved,});

  BookKingRoomModel.fromJson(dynamic json) {
    message = json['Message'];
    print("1");
    availablity = json['Availablity'];
    print("2");
    noOfRoomsAvailable = json['noOfRoomsAvailable'].toString();
    print("3");

    totalFair = json['totalFair'];
    print("4");

    totalGST = json['totalGST'];
    print("5");

    grandTotal = json['grandTotal'];
    print("6");

    totalNights = json['totalNights'];
    print("7");

    outsiderReserved = json['outsiderReserved'];
    print("8");

  }
  String ?message;
  String ?availablity;
  String ?noOfRoomsAvailable;
  int? totalFair;
  int ?totalGST;
  int ?grandTotal;
  String ?totalNights;
  int ?outsiderReserved;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    map['Availablity'] = availablity;
    map['noOfRoomsAvailable'] = noOfRoomsAvailable;
    map['totalFair'] = totalFair;
    map['totalGST'] = totalGST;
    map['grandTotal'] = grandTotal;
    map['totalNights'] = totalNights;
    map['outsiderReserved'] = outsiderReserved;
    return map;
  }

}