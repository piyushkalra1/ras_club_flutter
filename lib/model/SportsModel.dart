class SportsModel {
  SportsModel({
      this.message, 
      this.availablity, 
      this.feesMember, 
      this.feesNonMember,});

  SportsModel.fromJson(dynamic json) {
    message = json['Message'];
    availablity = json['Availablity'];
    feesMember = json['Fees_Member'];
    feesNonMember = json['Fees_Non_Member'];
  }
  String ?message;
  String ?availablity;
  String ?feesMember;
  String ?feesNonMember;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    map['Availablity'] = availablity;
    map['Fees_Member'] = feesMember;
    map['Fees_Non_Member'] = feesNonMember;
    return map;
  }

}