class GymModel {
  GymModel({
      this.message, 
      this.gymFees, 
      this.pTFees, 
      this.totalFees,});

  GymModel.fromJson(dynamic json) {
    message = json['Message'];
    gymFees = json['GymFees'];
    pTFees = json['PTFees'];
    totalFees = json['TotalFees'];
  }
  String ?message;
  String? gymFees;
  String ?pTFees;
  int ?totalFees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    map['GymFees'] = gymFees;
    map['PTFees'] = pTFees;
    map['TotalFees'] = totalFees;
    return map;
  }

}