import 'package:flutter/material.dart';
import 'package:ras_club_flutter/section2/listitem.dart';
import 'package:ras_club_flutter/section2/tableno.dart';

class FoodCategories extends StatefulWidget {
  const FoodCategories({Key? key}) : super(key: key);

  @override
  State<FoodCategories> createState() => _FoodCategoriesState();
}

class _FoodCategoriesState extends State<FoodCategories> {

  List<ListItem> items = [
    ListItem('Chinese', false,'https://images.pexels.com/photos/5409009/pexels-photo-5409009.jpeg?auto=compress&cs=tinysrgb&w=600'),
  ListItem('Italian', false,'https://images.pexels.com/photos/2295285/pexels-photo-2295285.jpeg?auto=compress&cs=tinysrgb&w=800'),
  ListItem('North Indian', false,'https://images.pexels.com/photos/2474661/pexels-photo-2474661.jpeg?auto=compress&cs=tinysrgb&w=600'),
  ListItem('South Indian', false,'https://images.pexels.com/photos/674574/pexels-photo-674574.jpeg?auto=compress&cs=tinysrgb&w=800'),
  ListItem('Beverage', false,'https://images.pexels.com/photos/340996/pexels-photo-340996.jpeg?auto=compress&cs=tinysrgb&w=800'),
    ListItem('Punjabi', false, 'https://images.pexels.com/photos/5031947/pexels-photo-5031947.jpeg?auto=compress&cs=tinysrgb&w=800'),
    ListItem('Sweets', false, 'https://images.pexels.com/photos/5350676/pexels-photo-5350676.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ListItem('Rajasthani', false, 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Royal_Rajasthani_Thali_at_Suvarna_Mahal%2C_Ram_Bagh_Hotel%2C_Jaipur.jpg'),
  ];
  List<ListItem> selectedItems = [];

  Color colors = Colors.black;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.white12,
        title: Text('Choose Category Type',style:Tablenotextstyle,),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: (){
        }, child: Text(''),
      ),
      body: Column(
        children: [

      Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),),
          Expanded(
            child: GridView.builder(

              itemCount: items.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:  items[index].isSelected ? Colors.green.withOpacity(0.2) : Colors.white,
                      borderRadius: BorderRadius.circular(20),

                    ),
                  child:Center(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  items[index].isSelected = !items[index].isSelected;
                                  if (items[index].isSelected) {
                                    selectedItems.add(items[index]);
                                  } else {
                                    selectedItems.remove(items[index]);
                                  }
                                });
                                },
                              child: CircleAvatar(
                                radius: 110,
                                backgroundColor: items[index].isSelected ? Colors.green : Colors.grey,
                                backgroundImage:  NetworkImage(items[index].url),
                              ),
                            ),
                            Text(items[index].text,style:items[index].isSelected? Tablenotextstyle:TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 28,color: Colors.black
                            ),),
                          ],
                        ),
                        if(items[index].isSelected)...{
                          Positioned(child:
                          Icon(Icons.check_circle,color: Colors.green,size: 40,)),
                        }

                      ],
                    ),
                  )

                );
              }, gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 380),
            ),
          ),
        ],
      )
    );
  }
  void selectAllItems() {
    setState(() {
      for (var item in items) {
        item.isSelected = true;
      }
      selectedItems = List.from(items);
    });
  }
}
