import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supper/library/postitem.dart';
import 'package:supper/modules/shop_app/login_shop/login_screen.dart';

class FavoriteScreen extends StatelessWidget {

  Future<List<Favoris>> fetchUsers() async {
    String? token;
    Response response = await Dio().get('http://sup-er-app.herokuapp.com/apis/favorisclient/'+LoginScreen().localStorage.getItem('ok'),
        options: Options(
            headers: {
              'Authorization':'token '+LoginScreen().localStorage.getItem('token')
            }
        ) );
    if (response.statusCode == 202) {
      var getUsersData = response.data as List;
      var listUsers = getUsersData.map((i) => Favoris.fromJSON(i)).toList();
      return Future.value(listUsers) ;
    } else {
      print(LoginScreen().localStorage.getItem('ok'));
      throw Exception('Failed to load users');
    }
  }
  @override
  Widget build(BuildContext context) {
    var listUsers=fetchUsers();
    return Scaffold(
        body: FutureBuilder<List<Favoris>>(
          future: listUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for(int i=0;i<(snapshot.data as List<Favoris>).length;i++)
                        MaterialButton(
                          onPressed: ()
                          {
                          },
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    width: 140,
                                    height: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: Colors.black12
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image(
                                      fit: BoxFit.cover,

                                      image:
                                      AssetImage(
                                        'assets/images/'+((snapshot.data as List<Favoris>)[i].produit['image'].split('/').last).toString(),

                                      ),width: 20, height: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: [
                                    Text(
                                      (snapshot.data as List<Favoris>)[i].produit['nom'].toString(),
                                      style:
                                    TextStyle(
                                        fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:Colors.black,
                                    ),
                                    ),
                                      SizedBox(height: 10,),
                                      Text(
                                        (snapshot.data as List<Favoris>)[i].produit['prix'].toString(),
                                        style:
                                        TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:Colors.black,
                                        ),),
                                  ],),
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),

              );
            } else if (snapshot.hasError) {
              return Center( child: Text("${snapshot.error}"));
            }
            return Center(
              child: CircularProgressIndicator(backgroundColor: Colors.cyanAccent),
            );
          },
        ));


  }
}
