import 'Menu.dart';
import 'LiveCounters.dart';

class HallBookingModal {
  HallBookingModal({
      this.message, 
      this.availablity, 
      this.menu, 
      this.liveCounters,});

  HallBookingModal.fromJson(dynamic json) {
    message = json['Message'];
    availablity = json['Availablity'];
    if (json['Menu'] != null) {
      menu = [];
      json['Menu'].forEach((v) {
        menu!.add(Menu.fromJson(v));
      });
    }
    if (json['LiveCounters'] != null) {
      liveCounters = [];
      json['LiveCounters'].forEach((v) {
        liveCounters!.add(LiveCounters.fromJson(v));
      });
    }
  }
  String ?message;
  String ?availablity;
  List<Menu> ?menu;
  List<LiveCounters>? liveCounters;

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