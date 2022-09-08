// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:supper/library/postitem.dart';
// import 'package:supper/modules/shop_app/notification/notification_screen.dart';
// import 'package:supper/modules/shop_app/panier/panier.dart';
// import 'package:supper/styles/icon_broken.dart';
//
//
//
//
// class ProductDetailScreen extends StatefulWidget {
//   final int id;
//
//   ProductDetailScreen({required this.id});
//
//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }
//
// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   int counter = 0;
//
//   Future<ProduitModel> detailproduit() async {
//
//     Response response = await Dio().get('http://sup-er-app.herokuapp.com/apis/produit/'+widget.id.toString(),
//         options: Options(
//             headers: {
//               'Authorization':'token 12ecf0a401cda32fe4b981ece32edb32693bcba2'
//             }
//         ) );
//     print(response.data.toString());
//     if (response.statusCode == 200) {
//       return ProduitModel.fromJSON(response.data);
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var detailsprod=detailproduit();
//     return Scaffold(
//         appBar: AppBar(
//
//           actions: [
//             IconButton(onPressed: ()
//             {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => Panier(),));
//
//             }
//               ,icon:Stack(
//                 alignment: AlignmentDirectional.topEnd,
//                 children: [
//                   CircleAvatar(
//                     radius:50,
//                     backgroundColor: Colors.black12,
//                     child: Icon(
//                       IconBroken.Buy,
//                       size: 30,color: Colors.black,
//                     ),
//                   ),
//                   CircleAvatar(
//                     radius:9,
//                     backgroundColor: Colors.red,
//                     child: Text(
//                       '$counter',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(onPressed: ()
//             {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
//
//             },
//               icon:CircleAvatar(
//                 radius: 30,
//                 backgroundColor: Colors.black12,
//                 child: Icon(
//                   IconBroken.Notification,
//                   size: 30,color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body:FutureBuilder<ProduitModel>(
//           future: detailsprod,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               var user = (snapshot.data as ProduitModel);
//
//               var completePath = user.image;
//               var fileName = (completePath.split('/').last);
//               print(fileName);
//
//
//
//
//
//
//               return  SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       color: Colors.black12,
//                       child: Column(
//                         children: [
//                           Image(image: AssetImage(
//                             'assets/images/'+fileName.toString(),
//                           ),
//                           ),
//                           Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadiusDirectional.only(
//                                 topStart: Radius.circular(60),
//                                 topEnd: Radius.circular(60),
//                               ),
//                             ),
//                             clipBehavior: Clip.antiAliasWithSaveLayer,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start
//                               ,
//                               children: [
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Text(user.nom.toString(),
//                                     style: TextStyle(
//                                       fontSize: 20,
//
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 350),
//                                   child: CircleAvatar(
//                                       backgroundColor: Colors.black12,
//                                       radius: 20,
//                                       child: Icon(IconBroken.Heart,color: Colors.black,)),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Text(
//                                     user.description,
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                     ),
//                                   ),
//                                 ),
//
//                                 MaterialButton(
//                                   onPressed: ()
//                                   {
//
//                                   },
//                                   child: Text(
//                                     'See More Detail ',
//                                     style: TextStyle(
//                                         color: Colors.cyan
//                                     ),
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     MaterialButton(
//                                       onPressed:(){},
//                                       child: CircleAvatar(
//                                         radius: 18,
//                                         backgroundColor: Colors.black12,
//                                         child: Icon(Icons.add,color: Colors.black,)
//                                         ,
//                                       ),
//                                     ),
//
//                                     MaterialButton(
//                                       onPressed: (){},
//                                       child: CircleAvatar(
//                                         radius: 18,
//                                         backgroundColor: Colors.black12,
//                                         child: Icon(
//                                           Icons.minimize,
//                                           color: Colors.black,
//                                         ),),
//                                     ),
//                                   ],
//                                 ),
//
//                                 Center(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(18.0),
//                                     child: MaterialButton(
//                                       onPressed: (){
//                                         setState((){
//                                           counter++;
//                                         });
//                                       },
//                                       child: Container(
//                                         width: 220,
//                                         height: 60,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(30),
//                                            color: Colors.cyan,
//                                         ),
//                                         child: Center(
//                                           child: Text('Add to card',
//                                             style: TextStyle(
//                                                 color: Colors.white,fontSize: 15
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ) ;
//
//             } else if (snapshot.hasError) {
//               return Center( child: Text("${snapshot.error}"));
//             }
//             return Center(
//               child: CircularProgressIndicator(backgroundColor: Colors.cyanAccent),
//             );
//           },
//         ));
//   }
// }
//
//
//
//
//
//
//
//

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supper/library/postitem.dart';
import 'package:supper/shared/components/components.dart';
import 'package:supper/styles/icon_broken.dart';
import 'package:supper/modules/shop_app/login_shop/login_screen.dart';



class ProductDetailScreen extends StatelessWidget {
  final int id;
  final myController = TextEditingController();
  List paniti=[];
  ProductDetailScreen({required this.id});


  Future<ProduitModel> detailproduit() async {

    Response response = await Dio().get('http://sup-er-app.herokuapp.com/apis/produit/'+id.toString(),
        options: Options(
            headers: {
              'Authorization':'token 12ecf0a401cda32fe4b981ece32edb32693bcba2'
            }
        ) );
    print(response.data.toString());
    if (response.statusCode == 200) {
      return ProduitModel.fromJSON(response.data);
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<List<Paniers>> fpanier() async {
    String? token;
    Response response = await Dio().get('http://sup-er-app.herokuapp.com/apis/panierclient/'+LoginScreen().localStorage.getItem('ok'),
        options: Options(
            headers: {
              'Authorization':'token 12ecf0a401cda32fe4b981ece32edb32693bcba2'
            }
        ) );
    if (response.statusCode == 202) {
      var getUsersData = response.data as List;
      var listUsers = getUsersData.map((i) => Paniers.fromJSON(i)).toList();
      return Future.value(listUsers) ;
    } else {
      print(LoginScreen().localStorage.getItem('ok'));
      throw Exception('Failed to load users');
    }
  }


  @override
  Widget build(BuildContext context) {
    var detailsprod=detailproduit();
    var pani=fpanier();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          actions: [
            IconButton(
              onPressed: ()
              {

              },
              icon:Icon(
                IconBroken.Star,

              ),
            )
          ],
        ),
        body:SingleChildScrollView(
          child: Column(
              children: [
          FutureBuilder<List<Paniers>>(
          future: pani,
            builder: (context, snapshot) {

              if(snapshot.hasData) {
                for(int i=0;i<(snapshot.data as List<Paniers>).length;i++){
                  paniti.add((snapshot.data as List<Paniers>)[i].produit['nom'].toString());
                }
                print(paniti);
                LoginScreen().localStorage.setItem('panier',paniti);
                print(LoginScreen().localStorage.getItem('panier'));
              }
              else if (snapshot.hasError) {
                return Center( child: Text("${snapshot.error}"));
              }
              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(),
              );
            },
          ),
          FutureBuilder<ProduitModel>(
            future: detailsprod,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var user = (snapshot.data as ProduitModel);
print(user.nom);
                var completePath = user.image;
                var fileName = (completePath.split('/').last);
                print(fileName);






                return  SingleChildScrollView(

                  child: Column(
                    
                    children: [
                      Container(
                        color: Colors.black12,
                        child: Column(
                          children: [
                            Image(image: AssetImage(
                              'assets/images/'+fileName.toString(),
                            ),),
                            Container(

                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(left:Radius.circular(50),right: Radius.circular(50)),
                                color: Colors.white,
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start
                                ,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Text(user.nom.toString(),
                                      style: TextStyle(
                                        fontSize: 20,

                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 350),
                                    child: CircleAvatar(
                                        backgroundColor: Colors.black12,
                                        radius: 20,
                                        child: Icon(IconBroken.Heart,color: Colors.black,)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Text(
                                      user.description,
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  // TextField(
                                  //   controller: myController,
                                  //   decoration: InputDecoration(
                                  //       contentPadding: EdgeInsets.symmetric(
                                  //         horizontal: 20,
                                  //         vertical: 9,
                                  //       ),
                                  //       border: InputBorder.none,
                                  //       focusedBorder: InputBorder.none,
                                  //       enabledBorder: InputBorder.none,
                                  //       hintText: "Entrer la quantite"),
                                  // ),
                                  defaultTextField(
                                    controller: myController,
                                    type: TextInputType.text,
                                    text: 'Entrer la quantite',
                                    prefix: Icons.description_outlined,
                                  ),
                                  MaterialButton(
                                    onPressed: ()
                                    {

                                    },
                                    child: Text(
                                      'See More Detail ',
                                      style: TextStyle(
                                          color: Colors.cyan
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      MaterialButton(
                                        onPressed:(){},
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Colors.black12,
                                          child: Icon(Icons.add,color: Colors.black,)
                                          ,
                                        ),
                                      ),

                                      MaterialButton(
                                        onPressed: (){},
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Colors.black12,
                                          child: Icon(
                                            Icons.minimize,
                                            color: Colors.black,
                                          ),),
                                      ),
                                    ],
                                  ),
                                  
                                 paniti.contains(user.nom.toString()) ?
                                 Center(
                                   child: Padding(
                                     padding: const EdgeInsets.all(18.0),
                                     child: MaterialButton(
                                       onPressed: (){

                                       },
                                       child: Container(
                                         width: 220,
                                         height: 60,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(30),
                                           color: Colors.redAccent,
                                         ),

                                         child: Center(

                                           child: Text('Enlever de pnaier',
                                             style: TextStyle(
                                                 color: Colors.white,fontSize: 15
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                                 ):
                                 Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: MaterialButton(
                                        onPressed: (){
                                          DioHadd().fetchPrduit(user.nom,myController.text);
                                        },
                                        child: Container(
                                          width: 220,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.cyan,
                                          ),

                                          child: Center(

                                            child: Text('Ajouter au panier',
                                              style: TextStyle(
                                                  color: Colors.white,fontSize: 15
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ) ;

              } else if (snapshot.hasError) {
                return Center( child: Text("${snapshot.error}"));
              }
              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.cyanAccent),
              );
            },
          )
    ],
              ),
        ),
    );
  }
}


class DioHadd{
  final Dio dio=Dio();

  Future<Paniers> fetchPrduit(String url,String quantite) async{
    try{
      final response = await dio.post("http://sup-er-app.herokuapp.com/apis/addtopanier/"+url+"/", data: {'quantite': quantite},
          options: Options(
              headers: {
                'Authorization':'token '+LoginScreen().localStorage.getItem('token')
              }
          ) );
      debugPrint(response.toString());
      return Paniers.fromJSON(response.data);
    } on DioError catch(e){
      debugPrint("status code : ${e.response?.statusCode.toString()}");
      throw Exception("Failed");
    }
  }
}


