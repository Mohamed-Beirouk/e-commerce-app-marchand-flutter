import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supper/library/postitem.dart';
import 'package:supper/styles/icon_broken.dart';




class DetailCommande extends StatelessWidget {
  final int id;
  DetailCommande({required this.id});


  Future<Commande> detailproduit() async {

    Response response = await Dio().get('http://sup-er-app.herokuapp.com/apis/detailcommande/'+id.toString(),
        options: Options(
            headers: {
              'Authorization':'token 12ecf0a401cda32fe4b981ece32edb32693bcba2'
            }
        ) );
    print(response.data.toString());
    if (response.statusCode == 200) {
      return Commande.fromJSON(response.data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    var detailsprod=detailproduit();
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
        body:FutureBuilder<Commande>(
          future: detailsprod,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var user = (snapshot.data as Commande);
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(15)
                          ),
                        ),

                        SizedBox(width: 50,),

                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text("Mode de paiement : "+user.modePaiment),

                        Spacer(),
                        Text("Status: "+user.statut),
                      ],
                    ),

                  ],
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

