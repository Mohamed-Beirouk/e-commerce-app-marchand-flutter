import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../library/postitem.dart';
import '../shop_app/login_shop/login_screen.dart';

class MyHeaderDrawer extends StatelessWidget {
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
    var ane =detailproduit();
    return FutureBuilder<Fournisseur>(
      future: ane,
        builder: (context, snapshot) {
      if (snapshot.hasData) {
        var user = (snapshot.data as Fournisseur);

      return Container(
        color: Colors.green.withOpacity(0.7),
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.only(
          top: 20
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Container(
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/'+user.image.split('/').last),
                ),
              ),
            ),
            Text(
                user.user['username'],
            style:TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            ),
            Text(
              user.user['email'],
              style:TextStyle(
                color: Colors.grey[200],
                fontSize: 14,
              ),
            ),
          ],
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
    );
  }
}