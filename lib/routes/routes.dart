
import 'package:flutter/material.dart';
import 'package:ras_club_flutter/routes/routes_name.dart';
import 'package:ras_club_flutter/section2/Categorytype.dart';
import 'package:ras_club_flutter/section2/FoodCategories.dart';
import 'package:ras_club_flutter/section2/tableno.dart';

class Routes{
  static Route<dynamic>  generateRoute(RouteSettings settings){
    final argume =settings.arguments;
    switch(settings.name){

      case RoutesName.categorytype:
        return MaterialPageRoute(builder: (BuildContext context)=>CategoryType());

      case RoutesName.tablenumber:
        return MaterialPageRoute(builder: (BuildContext context)=>TableNo());
      case RoutesName.foodcategories:
        return MaterialPageRoute(builder: (BuildContext context)=>FoodCategories());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text(
                "No route defined"
              ),
            ),
          );
        });
    }
  }
}