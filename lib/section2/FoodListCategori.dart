import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ras_club_flutter/section2/tableno.dart';

import 'countprovider.dart';

class FoodCategoryList extends StatefulWidget {
  const FoodCategoryList({Key? key}) : super(key: key);

  @override
  State<FoodCategoryList> createState() => _FoodCategoryListState();
}

class _FoodCategoryListState extends State<FoodCategoryList> {



  @override
  Widget build(BuildContext context) {
    print('build');
    final counter = Provider.of<Counter>(context,listen: false);
   return DefaultTabController(
      length: 8,
      child: Scaffold(
          appBar: AppBar(



            bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.blueGrey,
                indicatorColor: Colors.red,
                labelPadding: EdgeInsets.symmetric(horizontal: 30), // Space between tabs
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.black, width: 4), // Indicator height
                  insets: EdgeInsets.symmetric(horizontal: 4), // Indicator width
                ),
                tabs: [
                  Tab(
                    child: Text('All',style: Tablenotextstyle,),
                  ),
                  Tab(
                    child: Text('Italian',style: Tablenotextstyle),
                  ),
                  Tab(
                    child: Text('Rajasthani',style: Tablenotextstyle,),
                  ),
                  Tab(
                    child: Text('North Indian ',style: Tablenotextstyle,),
                  ),
                  Tab(
                    child: Text('South Indian',style: Tablenotextstyle,),
                  ),
                  Tab(
                    child: Text('Sweets',style: Tablenotextstyle,),
                  ),
                  Tab(
                    child: Text('Beverage',style: Tablenotextstyle,),
                  ), Tab(
                    child: Text('Chinese',style: Tablenotextstyle,),
                  ),
                ]),

          ),

          body: TabBarView(
            children: <Widget>[
            AllDishes(),
              RajasthaniDishes(),
              AllDishes(),
              RajasthaniDishes(),
              AllDishes(),
              RajasthaniDishes(),
              AllDishes(),
              RajasthaniDishes(),
            ],
          )),
    );
  }
}

class RajasthaniDishes extends StatelessWidget {
  const RajasthaniDishes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(

      builder: (context,value,child)=>
       ListView.builder(
        itemCount:value.itemlists.length,
        itemBuilder: (context, index) {
          return  Row(
          children: [
            Text('${index+1} ',style: TextStyle(fontSize: 22),),

            Text('${value.itemlists[index].name}',style: TextStyle(fontSize: 22)),
            if(value.itemlists[index].count>=1)
          IconButton( icon: Icon(Icons.remove), onPressed: () {
            if(value.itemlists[index].count>=1)
          value.decrement(index);
            else
              print('');
          },),
            if(value.itemlists[index].count>=1)
              Text(' ${value.itemlists[index].count}',style: TextStyle(fontSize: 22)),

          IconButton( icon: Icon(Icons.add), onPressed: () {
            value.increment(index);
          },),
      ],
      );


        },
      ),
    );
  }
}
class AllDishes extends StatelessWidget {
  const AllDishes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(

      builder: (context,value,child)=>
          ListView.builder(
            itemCount:value.allfood.length,
            itemBuilder: (context, index) {
              return  InkWell(
                onTap: (){

                },
                child: Row(
                  children: [
                    Text('${index+1} ',style: TextStyle(fontSize: 22),),

                    Text('${value.allfood[index].name}',style: TextStyle(fontSize: 22)),
                    if(value.allfood[index].count>=1)
                      IconButton( icon: Icon(Icons.remove), onPressed: () {
                        if(value.allfood[index].count>=1)
                          value.decrementall(index);
                        else
                          print('');
                      },),
                    if(value.allfood[index].count>=1)
                      Text(' ${value.allfood[index].count}',style: TextStyle(fontSize: 22)),

                      IconButton( icon: Icon(Icons.add), onPressed: () {
                        value.incrementall(index);
                      },),
                  ],
                ),
              );


            },
          ),
    );
  }
}
