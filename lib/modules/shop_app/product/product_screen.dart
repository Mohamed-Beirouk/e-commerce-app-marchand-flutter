import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supper/modules/shop_app/detail_product/detail_product.dart';
import 'package:supper/modules/shop_app/login_shop/cubit/cubit.dart';
import 'package:supper/modules/shop_app/login_shop/cubit/states.dart';
import 'package:supper/shared/components/icon_btn_with_counter.dart';
import 'package:supper/shared/components/size_config.dart';
import 'package:supper/modules/shop_app/login_shop/login_screen.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../library/postitem.dart';
import '../../../styles/icon_broken.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String ok='';

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var listUsers=fetchUsers();
    return
      BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
                appBar: AppBar(
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
                          prefixIcon: Icon(IconBroken.Search)),
                    ),
                  ),
                  actions: [
                    IconButton(onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Panier(),));

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
                body: FutureBuilder<List<ProduitModel>>(
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
                            if(ok.isEmpty){
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
                            else if (a) {
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
                ));
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




class DioHaddeman{
  final Dio dio=Dio();

  Future<Paniers> fetchPrduit(String url) async{
    try{
      final response = await dio.post("http://sup-er-app.herokuapp.com/apis/addtofavoris/"+url+"/",
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