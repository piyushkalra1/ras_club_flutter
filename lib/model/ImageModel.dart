class ImageModel {
  ImageModel({
      this.response,});

  ImageModel.fromJson(dynamic json) {
    response = json['response'];
  }
  String ?response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response'] = response;
    return map;
  }

}