import 'package:conditional_builder/conditional_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supper/library/postitem.dart';
//import 'package:supper/modules/news_app/settings/settings_screen.dart';
import 'package:supper/modules/shop_app/detail_product/detail_product.dart';
import 'package:supper/shared/components/components.dart';
import 'package:supper/shared/components/icon_btn_with_counter.dart';
import 'package:supper/shared/components/size_config.dart';
import 'package:supper/modules/shop_app/login_shop/login_screen.dart';
import '../../../styles/icon_broken.dart';

class Panier extends StatefulWidget {


  @override
  State<Panier> createState() => _PanierState();
}


Future<List<Paniers>> fetchUsers() async {
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


class _PanierState extends State<Panier> {
  final descController=TextEditingController();
  final payementController=TextEditingController();
  final prixtotalController=TextEditingController();
  final okController=TextEditingController();
  String okpanier='';
  double prixtot=0;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var listUsers=fetchUsers();

    return
      Scaffold(
        key:scaffoldkey,
          appBar: AppBar(
            title: Container(
              width: 270,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12
              ),
              child: TextField(
                onChanged: (value) => print(value),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 9,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Search product",
                    prefixIcon: Icon(IconBroken.Search)),
              ),
            ),
            actions: [
              IconButton(onPressed: (){

              }, icon:CircleAvatar(
                radius:50,
                backgroundColor: Colors.black12,
                child: Icon(
                  IconBroken.Buy,
                  size: 30,color: Colors.black,
                ),
              ),
              ),
              IconButton(onPressed: (){

              }, icon:CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black12,
                child: Icon(
                  IconBroken.Notification,
                  size: 30,color: Colors.black,
                ),
              ),
              ),
            ],
          ),
          body: FutureBuilder<List<Paniers>>(
            future: listUsers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for(int i=0;i<(snapshot.data as List<Paniers>).length;i++){

                  okpanier=okpanier +(snapshot.data as List<Paniers>)[i].produit['nom'].toString() +' ';

                  prixtot=prixtot + (snapshot.data as List<Paniers>)[i].quantite * double.parse((snapshot.data as List<Paniers>)[i].produit['prix']);

                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            children: [
                              for(int i=0;i<(snapshot.data as List<Paniers>).length;i++)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: Container(
                                        width: 140,
                                        height: 140,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            color: Colors.black12
                                        ),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child: MaterialButton(
                                          onPressed: ()
                                          {

                                          },
                                          child: Image(
                                            image:
                                            AssetImage(
                                              'assets/images/'+((snapshot.data as List<Paniers>)[i].produit['image'].split('/').last).toString(),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                        Text(
                                          (snapshot.data as List<Paniers>)[i].produit['nom'].toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color:Colors.black,
                                          ),
                                        ),
                                          SizedBox(height: 10,),
                                          Text('Prix: '+
                                              (snapshot.data as List<Paniers>)[i].produit['prix'].toString()+'UM',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color:Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Text('Quantité: '+
                                              (snapshot.data as List<Paniers>)[i].quantite.toString()+'UM',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color:Colors.black,
                                            ),
                                          ),

                                      ],
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: ()
                        {
                          scaffoldkey.currentState!.showBottomSheet((context) =>
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.only(
                                    topStart: Radius.circular(80),
                                    topEnd: Radius.circular(80),
                                  ),
                                ),
                                height: 300,
                                width: double.infinity,
                                // color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Form(
                                    key: formkey,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:BorderRadius.circular(20),
                                            color: Colors.grey,
                                          ),
                                          width: 70,
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        defaultTextField(
                                          controller: descController,
                                          type: TextInputType.text,
                                          text: 'Entrer la description',
                                          prefix: Icons.description_outlined,
                                        ),
                                        defaultTextField(
                                          controller: payementController,
                                          type: TextInputType.number,
                                          text: 'Entrer le code de payement',
                                          prefix: Icons.account_balance_wallet_outlined,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'total:',
                                                  style:TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 14,
                                                ),
                                                Text(
                                                  '${prixtot.toString()}UM',
                                                  style:TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            ConditionalBuilder(
                                              condition: 1==1,
                                              builder: (context) =>defaultButtonL(

                                                function: ()
                                                {
                                                  if(formkey.currentState!.validate())
                                                  {
                                                    DioHadde().fetchPrduit(descController.text,
                                                        payementController.text,
                                                        prixtot.toString(),
                                                        'Commande de :'+okpanier).then((value) =>
                                                        Fluttertoast.showToast(
                                                        msg: 'Commande successfully',
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 8,
                                                        backgroundColor: Colors.green,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0
                                                    ),);

                                                  }
                                                },
                                                text: 'effectuer payement',
                                              ),
                                              fallback: (context) => Center(child: CircularProgressIndicator()),
                                            ),
                                            // InkWell(
                                            //   onTap: (){},
                                            //   child: Container(
                                            //     width: 220,
                                            //     height: 60,
                                            //     decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.circular(30),
                                            //       color: Colors.cyan,
                                            //     ),
                                            //     child: Center(
                                            //       child: Text('effectuer payement',
                                            //         style: TextStyle(
                                            //             color: Colors.white,fontSize: 15
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            elevation: 35,
                          );
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
                              Icon(IconBroken.Wallet,
                                color: Colors.cyan,),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Lancer un payment',
                                style: TextStyle(
                                  color: Colors.cyan,
                                )
                                ,
                              ),
                              Spacer(),
                              Icon(IconBroken.Arrow___Right_Circle,
                                color: Colors.cyan,),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],),

                );

              } else if (snapshot.hasError) {
                return Center( child: Text("${snapshot.error}"));
              }
              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.cyanAccent),
              );
            },
          ),
      );

  }
}
class DioHadde{
  final Dio dio=Dio();

  Future<Demande> fetchPrduit(String description,String payement,String prixtotal,String ok) async{
    try{
      final response = await dio.post("http://sup-er-app.herokuapp.com/apis/lancerdemande/", data: {'description': description,'payement': payement,'prixtotal': prixtotal,'ok': ok},
          options: Options(
              headers: {
                'Authorization':'token '+LoginScreen().localStorage.getItem('token')
              }
          ) );
      debugPrint(response.toString());
      return Demande.fromJSON(response.data);
    } on DioError catch(e){
      debugPrint("status code : ${e.response?.statusCode.toString()}");
      throw Exception("Failed");
    }
  }
}