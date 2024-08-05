class RoomTermsModel {
  String? message;
  List<Terms>? terms;

  RoomTermsModel({this.message, this.terms});

  RoomTermsModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    if (json['terms'] != null) {
      terms = <Terms>[];
      json['terms'].forEach((v) {
        terms!.add(new Terms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    if (this.terms != null) {
      data['terms'] = this.terms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Terms {
  String? term;

  Terms({this.term});

  Terms.fromJson(Map<String, dynamic> json) {
    term = json['Term'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Term'] = this.term;
    return data;
  }
}