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
    availablity = json['Availablity'];
    noOfRoomsAvailable = json['noOfRoomsAvailable'].toString();
    totalFair = json['totalFair'];
    totalGST = json['totalGST'];
    grandTotal = json['grandTotal'];
    totalNights = json['totalNights'];
    outsiderReserved = json['outsiderReserved'];
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