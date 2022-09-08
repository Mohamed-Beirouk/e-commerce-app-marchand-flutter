// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:supper/library/postitem.dart';
// import 'package:supper/modules/shop_app/login_shop/cubit/cubit.dart';
// import 'package:supper/modules/shop_app/login_shop/cubit/states.dart';
// import 'package:supper/network/local/cache_helper.dart';
// import 'package:supper/shared/components/components.dart';
// import 'package:supper/shared/components/constants.dart';
// import 'package:supper/styles/icon_broken.dart';
// import 'package:supper/modules/shop_app/login_shop/login_screen.dart';
//
// class SettingsScreen extends StatelessWidget {
//
//   Future<Client> detailproduit() async {
//
//     Response response = await Dio().get('http://sup-er-app.herokuapp.com/apis/client/1/',
//         options: Options(
//             headers: {
//               'token':token,
//               'Authorization':'token 12ecf0a401cda32fe4b981ece32edb32693bcba2'
//             }
//         ) );
//     print(response.data.toString());
//     if (response.statusCode == 200) {
//       return Client.fromJSON(response.data);
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var detailsprod=detailproduit();
//
//     return BlocProvider(
//       create: (BuildContext context) => ShopLoginCubit(),
//       child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
//         listener: (context,state){},
//         builder: (context,state){
//           return Scaffold(
//               appBar: AppBar(),
//               body:FutureBuilder<Client>(
//                 future: detailsprod,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     var user = (snapshot.data as Client);
//                     var completePath = user.sexe;
//                     // var fileName = (completePath.split('/').last);
//                     // print(fileName);
//                     print(completePath);
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Center(
//                                 child:Stack(
//                                   alignment: AlignmentDirectional.bottomEnd,
//                                   children: [
//
//                                     CircleAvatar(
//                                       radius: 45,
//                                       child: CircleAvatar(
//                                         radius: 43,
//                                         backgroundImage: AssetImage('assets/images/Snapchat-131876016.jpg'),
//                                       ),
//                                     ),
//                                     CircleAvatar(
//                                       radius: 18,
//                                       child: IconButton(onPressed: ()
//                                       {
//
//                                       },
//                                         icon: Icon(
//                                           IconBroken.Camera,
//                                           size: 18,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               user.sexe,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             InkWell(
//                               onTap: (){},
//                               child: Container(
//                                 width: double.infinity,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color: Colors.black12,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Icon(IconBroken.Notification,
//                                       color: Colors.cyan,),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Text(
//                                       'Notification',
//                                       style: TextStyle(
//                                         color: Colors.cyan,
//                                       )
//                                       ,
//                                     ),
//                                     Spacer(),
//                                     Icon(IconBroken.Arrow___Right_Circle,
//                                       color: Colors.cyan,),
//                                     SizedBox(
//                                       width: 15,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             InkWell(
//                               onTap: (){},
//                               child: Container(
//                                 width: double.infinity,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color: Colors.black12,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Icon(IconBroken.Setting,
//                                       color: Colors.cyan,),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Text(
//                                       'Sittings',
//                                       style: TextStyle(
//                                         color: Colors.cyan,
//                                       )
//                                       ,
//                                     ),
//                                     Spacer(),
//                                     Icon(IconBroken.Arrow___Right_Circle,
//                                       color: Colors.cyan,),
//                                     SizedBox(
//                                       width: 15,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             InkWell(
//                               onTap: (){},
//                               child: Container(
//                                 width: double.infinity,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color: Colors.black12,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Icon(IconBroken.Danger,
//                                       color: Colors.cyan,),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Text(
//                                       'Help Center',
//                                       style: TextStyle(
//                                         color: Colors.cyan,
//                                       )
//                                       ,
//                                     ),
//                                     Spacer(),
//                                     Icon(IconBroken.Arrow___Right_Circle,
//                                       color: Colors.cyan,),
//                                     SizedBox(
//                                       width: 15,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             InkWell(
//                               onTap: (){
//                                 CacheHelper.removeData(key:'token').then((value)
//                                 {
//                                   navigateAndFinish(context,LoginScreen());
//                                 });
//                               },
//                               child: Container(
//                                 width: double.infinity,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color: Colors.black12,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Icon(IconBroken.Logout,
//                                         color: Colors.cyan,),
//
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Text(
//                                       'Logout',
//                                       style: TextStyle(
//                                         color: Colors.cyan,
//                                       )
//                                       ,
//                                     ),
//                                     Spacer(),
//                                     Icon(IconBroken.Arrow___Right_Circle,
//                                       color: Colors.cyan,),
//                                     SizedBox(
//                                       width: 15,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   } else if (snapshot.hasError) {
//                     return Center( child: Text("${snapshot.error}"));
//                   }
//                   return Center(
//                     child: CircularProgressIndicator(backgroundColor: Colors.cyanAccent),
//                   );
//                 },
//               ));},
//       ),
//     );
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
//

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supper/library/postitem.dart';
import 'package:supper/models/shop_app/login_model.dart';
import 'package:supper/modules/shop_app/settings/help_center.dart';
import 'package:supper/network/local/cache_helper.dart';
import 'package:supper/shared/components/components.dart';
import 'package:supper/styles/icon_broken.dart';
import 'package:localstorage/localstorage.dart';
import 'package:supper/modules/shop_app/login_shop/login_screen.dart';

class SettingsScreen extends StatelessWidget {

  Future<Fournisseur> detailproduit() async {

    Response response = await Dio().get('http://sup-er-app.herokuapp.com/apis/fournisseur/'+LoginScreen().localStorage.getItem('ok'),
        options: Options(
            headers: {
              'Authorization':'token '+LoginScreen().localStorage.getItem('token')
            }
        ) );
    print(response.data.toString());
    if (response.statusCode == 200) {
      return Fournisseur.fromJSON(response.data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    var detailsprod=detailproduit();
    return Scaffold(
        appBar: AppBar(),
        body:FutureBuilder<Fournisseur>(
          future: detailsprod,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var user = (snapshot.data as Fournisseur);
              var completePath = user.image;
              var fileName = (completePath.split('/').last);
              print(fileName);
              print(completePath);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                          child:Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [

                              CircleAvatar(
                                radius: 45,
                                child: CircleAvatar(
                                  radius: 43,
                                  backgroundImage: AssetImage('assets/images/'+fileName),
                                ),
                              ),
                              CircleAvatar(
                                radius: 18,
                                child: IconButton(
                                  onPressed: ()
                                {

                                },
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      // Center(
                      //   child: Container(
                      //     width: 110,
                      //     height: 110,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(180),
                      //     ),
                      //     clipBehavior: Clip.antiAliasWithSaveLayer,
                      //     child: Image(
                      //         image: AssetImage("assets/images/"+fileName)),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(user.user['username'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: (){},
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black12,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(IconBroken.Notification,
                                  color: Colors.brown,
                                  ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Notification',
                                style: TextStyle(
                                    color: Colors.brown,

                                )
                                ,
                              ),
                              Spacer(),
                              Icon(IconBroken.Arrow___Right_Circle,
                                  color: Colors.brown,
                                  ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: (){},
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black12,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(IconBroken.Setting,
                                color: Colors.brown,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Sittings',
                                style: TextStyle(
                                  color: Colors.brown,
                                )
                                ,
                              ),
                              Spacer(),
                              Icon(IconBroken.Arrow___Right_Circle,
                                color: Colors.brown,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HelepCenter()));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black12,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(IconBroken.Danger,
                                color: Colors.brown,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Help Center',
                                style: TextStyle(
                                  color: Colors.brown,
                                )
                                ,
                              ),
                              Spacer(),
                              Icon(IconBroken.Arrow___Right_Circle,
                                color: Colors.brown,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: (){
                          CacheHelper.removeData(key:'token').then((value)
                          {
                            navigateAndFinish(context,LoginScreen());
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black12,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(IconBroken.Logout,
                                color: Colors.brown,
                              ),

                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  color: Colors.brown,
                                )
                                ,
                              ),
                              Spacer(),
                              Icon(IconBroken.Arrow___Right_Circle,
                                color: Colors.brown,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center( child: Text("${snapshot.error}"));
            }
            return Center(
              child: CircularProgressIndicator(backgroundColor:Colors.brown,
              ),
            );
          },
        ));
  }
}

