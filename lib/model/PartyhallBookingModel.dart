import 'package:ras_club_flutter/model/TermsModel.dart';

import 'Menu.dart';
import 'LiveCounters.dart';

class PartyhallBookingModel {
  PartyhallBookingModel({
      this.message, 
      this.availablity, 
      this.menu,
    this.term,
      this.liveCounters,});

  PartyhallBookingModel.fromJson(dynamic json) {
    message = json['Message'];
    availablity = json['Availablity'];
    if (json['Menu'] != null) {
      menu = [];
      json['Menu'].forEach((v) {
        menu!.add(Menu.fromJson(v));
      });
    }

    if (json['Terms'] !=  null ) {
      term = [];
      json['Terms'].forEach((v) {
        term!.add(TermsModel.fromJson(v));
      });
    }
    else
      term =[];
    if (json['LiveCounters'] != null) {
      liveCounters = [];
      json['LiveCounters'].forEach((v) {
        liveCounters!.add(LiveCounters.fromJson(v));
      });
    }
  }
  String ?message;
  String ?availablity;
  List<Menu>? menu;
  List<TermsModel> ?term;
  List<LiveCounters> ?liveCounters;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    map['Availablity'] = availablity;
    if (menu != null) {
      map['Menu'] = menu!.map((v) => v.toJson()).toList();
    }
    if (liveCounters != null) {
      map['LiveCounters'] = liveCounters!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}