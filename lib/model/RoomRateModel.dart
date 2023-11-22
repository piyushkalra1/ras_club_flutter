class RoomRateModel {
  RoomRateModel({
      this.message, 
      this.rateKingSizeRoom, 
      this.gstKingSizeRoom, 
      this.rateTwinBeddedRoom, 
      this.gstTwinBeddedRoom, 
      this.rateLuxurySuite, 
      this.gstLuxurySuite,});

  RoomRateModel.fromJson(dynamic json) {
    message = json['Message'];
    rateKingSizeRoom = json['rateKingSizeRoom'];
    gstKingSizeRoom = json['gstKingSizeRoom'];
    rateTwinBeddedRoom = json['rateTwinBeddedRoom'];
    gstTwinBeddedRoom = json['gstTwinBeddedRoom'];
    rateLuxurySuite = json['rateLuxurySuite'];
    gstLuxurySuite = json['gstLuxurySuite'];
  }
  String ?message;
  String ?rateKingSizeRoom;
  String ?gstKingSizeRoom;
  String ?rateTwinBeddedRoom;
  String ?gstTwinBeddedRoom;
  String ?rateLuxurySuite;
  String ?gstLuxurySuite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    map['rateKingSizeRoom'] = rateKingSizeRoom;
    map['gstKingSizeRoom'] = gstKingSizeRoom;
    map['rateTwinBeddedRoom'] = rateTwinBeddedRoom;
    map['gstTwinBeddedRoom'] = gstTwinBeddedRoom;
    map['rateLuxurySuite'] = rateLuxurySuite;
    map['gstLuxurySuite'] = gstLuxurySuite;
    return map;
  }

}