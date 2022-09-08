import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProduitModel
{
  int id;
  bool available;
  String nom;
  String prix;
  String description;
  String image;
  Map<String,dynamic> fournisseurs;
  Map<String,dynamic> categories;
  Map<String,dynamic> marqueprives;

  ProduitModel({
    required this.available, required this.nom, required this.prix, required this.description, required this.image
    ,required this.fournisseurs, required this.categories, required this.marqueprives,required this.id
  });

  factory ProduitModel.fromJSON(Map<String,dynamic> parsedJson)
  {
    return ProduitModel(
      id: parsedJson['id'],
      available : parsedJson['available'],
      nom : parsedJson['nom'],
      prix : parsedJson['prix'],
      description : parsedJson['description'],
      image : parsedJson['image'],
      fournisseurs : parsedJson['fournisseurs'],
      marqueprives : parsedJson['marqueprives'],
      categories : parsedJson['categories'],
    );
  }

}
//
class Demande
{
  String description;
  String payement;
  String prixtotal;
  String ok;
  String statut;
  String created_at;
  String modePaiment;
  Demande({required this.description, required this.payement, required this.prixtotal, required this.ok, required this.statut, required this.modePaiment, required this.created_at});
  factory Demande.fromJSON(Map<String,dynamic> parsedJson)
  {
    return Demande(description: parsedJson['description'],payement: parsedJson['payement'],
      prixtotal: parsedJson['prixtotal'],ok: parsedJson['ok'],
      statut: parsedJson['statut'],modePaiment: parsedJson['modePaiment'],created_at: parsedJson['created_at'],
    );

  }
}
class Paniers
{
  int id;
  int quantite;
  Map<String,dynamic> client;
  Map<String,dynamic> produit;
  Paniers({required this.id, required this.quantite, required this.produit, required this.client});
  factory Paniers.fromJSON(Map<String,dynamic> parsedJson)
  {
    return Paniers(id: parsedJson['id'],quantite: parsedJson['quantite'],
      client: parsedJson['client'],produit: parsedJson['produit'],
    );

  }
}

class Client
{
  String telephone;
  String image;
  String sexe;
  String description;
  Map<String,dynamic> user;
  int id;
  String adresse;
  Client({required this.image,required this.description, required this.user, required this.telephone,required this.adresse,required this.id,required this.sexe});
  factory Client.fromJSON(Map<String,dynamic> parsedJson)
  {
    return Client(
      telephone: parsedJson['telephone'],
      image: parsedJson['image'],
      description: parsedJson['description'],
      sexe: parsedJson['sexe'],
      user: parsedJson['user'],
      id:parsedJson['id'],
      adresse: parsedJson['adresse'],
    );


  }
}
class Favoris
{
  int id;
  int client;
  Map<String,dynamic> produit;
  Favoris({required this.id,  required this.produit, required this.client});
  factory Favoris.fromJSON(Map<String,dynamic> parsedJson)
  {
    return Favoris(id: parsedJson['id'],
      client: parsedJson['client'],produit: parsedJson['produit'],
    );

  }
}
class Fournisseur
{
  String telephone;
  String image;
  String status;
  String nom_boutique;
  Map<String,dynamic>  user;
  int id;

  Fournisseur({ required this.id, required this.telephone,required this.image,required this.status,required this.nom_boutique,required this.user});

  //named constractor
  factory Fournisseur.fromJSON(Map<String,dynamic> parsedJson)
  {
    return Fournisseur(
        telephone: parsedJson['telephone'],
        image: parsedJson['image'],
        status: parsedJson['status'],
        nom_boutique: parsedJson['nom_boutique'],
        user: parsedJson['user'],
        id:parsedJson['id']
    );


  }
}
class Categorie
{
  int id;
  String nom;
  String image;
  Categorie({required this.nom, required this.id, required this.image});
  //named constractor
  factory Categorie.fromJSON(Map<String,dynamic> parsedJson)
  {
    return Categorie(nom: parsedJson['nom'],
        id: parsedJson['id'],
        image:parsedJson['image']);

  }
}

class MarquePrive
{
  int id;
  String nom;
  MarquePrive({required this.nom, required this.id});
  //named constractor
  factory MarquePrive.fromJSON(Map<String,dynamic> parsedJson)
  {
    return MarquePrive(nom: parsedJson['nom'],
        id: parsedJson['id']);

  }
}



class Commande
{
  int id;
  String description;
  String created_at;
  String modePaiment;
  String statut;
  int Client;
  List<CommandeItem> commandeitem;
  Commande({required this.id, required this.description, required this.Client, required this.created_at, required this.modePaiment, required this.statut, required this.commandeitem});
  //named constractor
  factory Commande.fromJSON(Map<String,dynamic> parsedJson)
  {
    return Commande(id: parsedJson['id'],description: parsedJson['description'],
      modePaiment: parsedJson['modePaiment'],created_at: parsedJson['created_at'],
      Client: parsedJson['Client'],
      statut: parsedJson['statut'],
      commandeitem: parsedJson["commandeitem"],
    );

  }
}
class CommandeItem{
  int id;
  int quantite;
  int commande;
  int produit;
  CommandeItem({required this.id,required this.commande, required this.produit,required this.quantite});
  factory CommandeItem.fromJSON(Map<String,dynamic> parsedJson)
  {
    return CommandeItem(id: parsedJson['id'],quantite: parsedJson['quantite'],
      commande: parsedJson['commande'],produit: parsedJson['produit'],);

  }
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



class diouser extends StatefulWidget {


  @override
  State<diouser> createState() => _diouserState();
}

class _diouserState extends State<diouser> {

  @override
  void initState() {
    super.initState();
    var listUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    var listUsers=fetchUsers();
    return
      Scaffold(
          body: FutureBuilder<List<ProduitModel>>(
            future: listUsers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      var user = (snapshot.data as List<ProduitModel>)[index];
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
                                ClipOval(
                                  child: Image.network(
                                    "https://img.directindustry.fr/images_di/photo-g/30589-8512626.jpg",
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                SizedBox(width: 50,),
                                Column(
                                  children: [
                                    Text(user.nom, style: TextStyle( fontWeight: FontWeight.bold, fontSize: 22)),

                                    SizedBox(height: 5),
                                    Text(user.description),
                                    // SizedBox(height: 5),
                                    // Text(user.fr.telephone + " " + user.fr.nom_boutique +" " +user.fr.status +" " + user.fr.user.nom),
                                    //
                                    SizedBox(height: 5),
                                    Text(user.prix),
                                    SizedBox(height: 5),
                                    Text(user.nom),

                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.heart,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.bookmark,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {},
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.hand_thumbsdown,
                                    color: Colors.blueAccent,
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.hand_thumbsup,
                                    color: Colors.blueAccent,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),

                          ],
                        ),

                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: (snapshot.data as List<ProduitModel>).length);
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
