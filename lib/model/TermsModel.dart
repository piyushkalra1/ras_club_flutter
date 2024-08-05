/// Term : "200ml water bottle extra (extra Rs.10 per plate)."

class TermsModel {
  TermsModel({
      String ?term,}){
    _term = term;
}

  TermsModel.fromJson(dynamic json) {
    _term = json['Term'];
  }
  String ?_term;
TermsModel copyWith({  String ?term,
}) => TermsModel(  term: term ?? _term,
);
  String? get term => _term;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Term'] = _term;
    return map;
  }

}