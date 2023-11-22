import 'package:flutter/material.dart';
import 'package:ras_club_flutter/section2/model/ItemListModel.dart';



class Counter with ChangeNotifier {
  List<ItemListModel> itemlists=[
    ItemListModel(id: 1,name: 'Dal Bhati',imageurl: 'https://images.pexels.com/photos/5409009/pexels-photo-5409009.jpeg?auto=compress&cs=tinysrgb&w=600'),
    ItemListModel(id: 2,name: 'Pratha',imageurl: 'https://images.pexels.com/photos/2295285/pexels-photo-2295285.jpeg?auto=compress&cs=tinysrgb&w=800'),
    ItemListModel(id: 3,name: 'Saag',imageurl: 'https://images.pexels.com/photos/2295285/pexels-photo-2295285.jpeg?auto=compress&cs=tinysrgb&w=800'),
    ItemListModel(id: 4,name: 'Kachori',imageurl: 'https://images.pexels.com/photos/2295285/pexels-photo-2295285.jpeg?auto=compress&cs=tinysrgb&w=800'),
    ItemListModel(id: 5,name: 'Dosa',imageurl: 'https://images.pexels.com/photos/2295285/pexels-photo-2295285.jpeg?auto=compress&cs=tinysrgb&w=800'),

  ];
  List<ItemListModel> allfood=[
    ItemListModel(id: 1,name: ' Noodles',imageurl: 'https://images.pexels.com/photos/5409009/pexels-photo-5409009.jpeg?auto=compress&cs=tinysrgb&w=600'),
    ItemListModel(id: 2,name: 'Burger',imageurl: 'https://images.pexels.com/photos/2295285/pexels-photo-2295285.jpeg?auto=compress&cs=tinysrgb&w=800'),
    ItemListModel(id: 3,name: 'Tandoor',imageurl: 'https://images.pexels.com/photos/2295285/pexels-photo-2295285.jpeg?auto=compress&cs=tinysrgb&w=800'),
    ItemListModel(id: 4,name: 'Idly',imageurl: 'https://images.pexels.com/photos/2295285/pexels-photo-2295285.jpeg?auto=compress&cs=tinysrgb&w=800'),
    ItemListModel(id: 5,name: 'Shai Paneer',imageurl: 'https://images.pexels.com/photos/2295285/pexels-photo-2295285.jpeg?auto=compress&cs=tinysrgb&w=800'),



  ];

  void incrementall(int index){
    allfood[index].count++;
    notifyListeners();
  }
  void decrementall(int index) {
    allfood[index].count-- ;
    notifyListeners();
  }



  void increment(int index) {

    itemlists[index].count++;
    notifyListeners();
  }

  void decrement(int index) {
    itemlists[index].count-- ;
    notifyListeners();
  }
}
