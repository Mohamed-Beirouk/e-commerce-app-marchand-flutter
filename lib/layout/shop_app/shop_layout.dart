import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supper/library/postitem.dart';
import 'package:supper/modules/drawer/my_drawer_list.dart';
import 'package:supper/modules/shop_app/login_shop/login_screen.dart';
import 'package:supper/modules/shop_app/mesproduits/produitcat.dart';
import 'package:supper/modules/shop_app/detail_product/detail_product.dart';
import 'package:supper/modules/shop_app/notification/notification_screen.dart';
import 'package:supper/modules/shop_app/panier/panier.dart';
import 'package:supper/modules/shop_app/product/product_screen.dart';
import 'package:supper/shared/components/components.dart';
import 'package:supper/styles/icon_broken.dart';
import '../../modules/drawer/my_header_drawer.dart';
import '../../modules/shop_app/register_shope/register_screen.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/components/icon_btn_with_counter.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopLayout extends StatefulWidget {

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

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

class _ShopLayoutState extends State<ShopLayout> {
  String ok='';

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var listUsers=fetchUsers();
    return BlocProvider(
      create: (BuildContext context) =>ShopCubit(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = ShopCubit.get(context);
          return Scaffold(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProduitCat(id: 1,),));

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

          body: ok.isEmpty ? cubit.bottomScreen[cubit.currentIndex]:
          FutureBuilder<List<ProduitModel>>(
            future: listUsers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      var user = (snapshot.data as List<ProduitModel>)[index];
                      var completePath = user.image;
                      var fileName = (completePath.split('/').last);
                      print(fileName);
                      int id=user.id;

                      final a = user.nom.toLowerCase().contains(ok.toLowerCase());
                      if (a) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: ()
                                      {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(id:id),));

                                      },
                                      child: ClipOval(
                                        child:Image(image: AssetImage(
                                          'assets/images/'+fileName.toString(),
                                        ), width: 100, height: 100,),
                                      ),
                                    ),
                                    // SizedBox(height: 15,),
                                    Column(
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              softWrap: false,
                                              user.nom, style:
                                          TextStyle( fontWeight: FontWeight.bold, fontSize: 22)
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(user.description,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          textAlign: TextAlign.center,),
                                        SizedBox(height: 5),
                                        Text(user.prix,
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,),
                                        SizedBox(height: 5),
                                        Text(user.nom,
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.heart,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () {
                                      DioHaddeman().fetchPrduit(user.nom);
                                    },
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
                      }
                      else{
                        return Container();
                      }
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
          ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index)
              {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                      IconBroken.Home,
                  ),
                label: 'home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        IconBroken.Work,
                    ),
                    label: 'Commande'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        IconBroken.Buy,
                    ),
                    label: 'Produits'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        IconBroken.Chat,
                    ),
                    label: 'chats'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        IconBroken.Setting,
                    ),
                    label: 'settings',
                ),
              ],
            ),
                drawer: Drawer(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      MyHeaderDrawer(),
                      MyDrawerList(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  void runfilter(String txt){
    setState(() {
      ok=txt;
    });
  }
}
