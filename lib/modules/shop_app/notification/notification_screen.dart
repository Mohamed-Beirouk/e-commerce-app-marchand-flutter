import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../library/postitem.dart';
import '../../../styles/icon_broken.dart';
import '../mesproduits/produitcat.dart';

class NotificationScreen extends StatefulWidget {

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}
Future<List<ProduitModel>> fetchUsers() async {
  String? token;
  Response response = await Dio().get('http://sup-er-app.herokuapp.com/apis/produit/',
      options: Options(
          headers: {
            'Authorization':'token 12ecf0a401cda32fe4b981ece32edb32693bcba2'
          }
      ) );
  if (response.statusCode == 200) {
    var getUsersData = response.data as List;
    var listUsers = getUsersData.map((i) => ProduitModel.fromJSON(i)).toList();
    return Future.value(listUsers) ;
  } else {
    throw Exception('Failed to load users');
  }
}

class _NotificationScreenState extends State<NotificationScreen> {
  String ok='';
  @override
  Widget build(BuildContext context) {
    return
     Scaffold(
       appBar: AppBar(
         leading: Builder(
           builder: (context) => IconButton(
             icon: Icon(
               Icons.menu_outlined,
               size: 25,
               color: Colors.brown,
             ),
             onPressed: () => Scaffold.of(context).openDrawer(),
           ),
         ),
         centerTitle: true,
         systemOverlayStyle: SystemUiOverlayStyle(
             statusBarColor: Colors.transparent,
             statusBarIconBrightness: Brightness.dark),
         elevation: 0,
         backgroundColor: Colors.green.withOpacity(0.4),
         backwardsCompatibility: false,
         title: Container(
           width:double.infinity,
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               color: Colors.black12
           ),
           child: TextField(
             onChanged: (value) {
               runfilter(value);
               print (value);
               print(ok);
             },
             decoration: InputDecoration(
               contentPadding: EdgeInsets.symmetric(
                 horizontal: 20,
                 vertical: 9,
               ),
               border: InputBorder.none,
               focusedBorder: InputBorder.none,
               enabledBorder: InputBorder.none,
               hintText: "Search product",
               prefixIcon: Icon(
                 IconBroken.Search,
                 color: Colors.brown,
               ),),
           ),
         ),
         actions: [
           IconButton(onPressed: ()
           {
             Navigator.push(context,MaterialPageRoute(builder: (context) => ProduitCat(id: 1,),));
           },
             icon:CircleAvatar(
               radius: 30,
               backgroundColor: Colors.black12,
               child: Icon(
                 IconBroken.Notification,
                 size: 30,color: Colors.brown,
               ),
             ),
           ),
         ],
       ),
       body: Center(
        child: Text(
            'No Natifications',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        ),
    ),
     );
  }
  void runfilter(String txt){
    setState(() {
      ok=txt;
    });
  }
}
