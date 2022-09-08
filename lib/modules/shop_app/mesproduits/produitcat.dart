import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supper/library/postitem.dart';
import 'package:supper/modules/shop_app/detail_product/detail_product.dart';
import 'package:supper/modules/shop_app/login_shop/login_screen.dart';

import '../../../shared/components/components.dart';
import '../../../styles/icon_broken.dart';

class ProduitCat extends StatefulWidget {
  int id;
  ProduitCat({required this.id});


  @override
  State<ProduitCat> createState() => _ProduitCatState();
}

class _ProduitCatState extends State<ProduitCat> {
  Future<List<ProduitModel>> fetchUsers() async {
    String? token;
    Response response = await Dio().get('http://sup-er-app.herokuapp.com/fournisseur/mesproduits/',
        options: Options(
            headers: {
              'Authorization':'token '+LoginScreen().localStorage.getItem('token')
            }
        ) );
    if (response.statusCode == 202) {
      var getUsersData = response.data as List;
      var listUsers = getUsersData.map((i) => ProduitModel.fromJSON(i)).toList();
      return Future.value(listUsers) ;
    } else {
      print(widget.id.toString());
      throw Exception('Failed to load users');
    }
  }

  String ok='';
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  bool _value = false;
  final items = ['Foot','Bar'];
  String? values;
  var nomController = TextEditingController();

  var prixController = TextEditingController();

  var descController = TextEditingController();
  File ?file;
  File ?file1;
  ImagePicker image = ImagePicker();
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listUsers=fetchUsers();
    var a=Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(80),
          topEnd: Radius.circular(80),
        ),
      ),
      height: 600,
      width: double.infinity,
      // color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key:formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(20),
                      color: Colors.grey,
                    ),
                    width: 70,
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
                    child: Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          defaultTextField(
                            controller: nomController,
                            type: TextInputType.text,
                            text: 'Name',
                            prefix: Icons.person,
                          ),

                          defaultTextField(
                            controller: prixController,
                            type: TextInputType.number,
                            text: 'prix',
                            prefix: Icons.price_change,
                          ),

                          defaultTextField(
                            controller: descController,
                            type: TextInputType.text,
                            text: 'description',
                            prefix: Icons.description,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    fixedSize: Size(180, 40),
                                  ),
                                  onPressed: ()
                                  {
                                    getGall();
                                  },
                                  child: file == null?
                                  Icon(IconBroken.Image) :

                                  Text(file.toString().split('/').last),

                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    fixedSize: Size(180, 40),
                                  ),
                                  onPressed: ()
                                  {
                                    getCam();
                                  },
                                  child: file1 == null?
                                  Icon(IconBroken.Camera) :
                                  Text(file1.toString().split('/').last),
                                ),

                              ],
                            ),

                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children:[ Checkbox(
                              value: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = !_value;
                                  print(_value);
                                });
                              },
                              activeColor: Colors.green,

                            ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Disponible',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black,width: 1),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  value: values,
                                  isExpanded:true,
                                  iconSize: 36,
                                  items:items.map(buildMenuItem).toList(),
                                  onChanged:(value){
                                    setState(() =>this.values = value);
                                  }
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultButtonL(
                    function: ()
                    {
                      if(formkey.currentState!.validate())
                      {
                        Haddemindio().ajoutprod(_value, nomController.text, prixController.text, descController.text, file.toString().split('/').last,1);
                      }
                    },
                    text: 'Enregistrer',
                    color:  Colors.green.withOpacity(0.7),

                  ),

                ],
              ),
            ),
          )
      ),
    );


    return Scaffold(
        key:scaffoldkey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: FutureBuilder<List<ProduitModel>>(
                future: listUsers,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          var user = (snapshot.data as List<ProduitModel>)[index];
                          var completePath = user.image;
                          var fileName = (completePath
                              .split('/')
                              .last);
                          print(fileName);
                          int id = user.id;


                          final a = user.nom.toLowerCase().contains(ok.toLowerCase());
                          if(ok.isEmpty){
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Column(
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
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailScreen(id: id),));
                                            },
                                            child: ClipOval(
                                              child: Image(image: AssetImage(
                                                'assets/images/' + fileName.toString(),
                                              ), width: 100, height: 100,),
                                            ),
                                          ),
                                          SizedBox(width: 50,),
                                          Column(
                                            children: [
                                              Text(user.nom, style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22)),

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
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailScreen(id: id),));
                                        },
                                        child: ClipOval(
                                          child: Image(image: AssetImage(
                                            'assets/images/' + fileName.toString(),
                                          ), width: 100, height: 100,),
                                        ),
                                      ),
                                      SizedBox(width: 50,),
                                      Column(
                                        children: [
                                          Text(user.nom, style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22)),

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
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: FloatingActionButton(
                onPressed: ()
                {
                  setState((){
                    scaffoldkey.currentState!.showBottomSheet((context) =>
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(80),
                              topEnd: Radius.circular(80),
                            ),
                          ),
                          height: 600,
                          width: double.infinity,
                          // color: Colors.white,
                          child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SingleChildScrollView(
                                child: Form(
                                  key:formkey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:BorderRadius.circular(20),
                                          color: Colors.grey,
                                        ),
                                        width: 70,
                                        height: 10,
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
                                        child: Container(

                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              defaultTextField(
                                                controller: nomController,
                                                type: TextInputType.text,
                                                text: 'Name',
                                                prefix: Icons.person,
                                              ),

                                              defaultTextField(
                                                controller: prixController,
                                                type: TextInputType.number,
                                                text: 'prix',
                                                prefix: Icons.price_change,
                                              ),

                                              defaultTextField(
                                                controller: descController,
                                                type: TextInputType.text,
                                                text: 'description',
                                                prefix: Icons.description,
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    OutlinedButton(
                                                      style: OutlinedButton.styleFrom(
                                                        fixedSize: Size(180, 40),
                                                      ),
                                                      onPressed: ()
                                                      {
                                                        getGall();
                                                      },
                                                      child: file == null?
                                                      Icon(IconBroken.Image) :

                                                      Text(file.toString().split('/').last),

                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    OutlinedButton(
                                                      style: OutlinedButton.styleFrom(
                                                        fixedSize: Size(180, 40),
                                                      ),
                                                      onPressed: ()
                                                      {
                                                        getCam();
                                                      },
                                                      child: file1 == null?
                                                      Icon(IconBroken.Camera) :
                                                      Text(file1.toString().split('/').last),
                                                    ),

                                                  ],
                                                ),

                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children:[ Checkbox(
                                                  value: _value,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _value = !_value;
                                                      print(_value);
                                                    });
                                                  },
                                                  activeColor: Colors.green,

                                                ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Disponible',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                margin: EdgeInsets.all(0),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(color: Colors.black,width: 1),
                                                ),
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                      value: values,
                                                      isExpanded:true,
                                                      iconSize: 36,
                                                      items:items.map(buildMenuItem).toList(),
                                                      onChanged:(value){
                                                        setState(() =>this.values = value);
                                                      }
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      defaultButtonL(
                                        function: ()
                                        {
                                          if(formkey.currentState!.validate())
                                          {
                                            Haddemindio().ajoutprod(_value, nomController.text, prixController.text, descController.text, file.toString().split('/').last,1);
                                          }
                                        },
                                        text: 'Enregistrer',
                                        color:  Colors.green.withOpacity(0.7),

                                      ),

                                    ],
                                  ),
                                ),
                              )
                          ),
                        ),
                      elevation: 35,
                    );
                  });

                },
                child:Icon(
                  Icons.add,
                ),
              ),
            ),
          ],
        )

    );
  }
  void runfilter(String txt){
    setState(() {
      ok=txt;
    });
  }

  //select camera
  getCam() async{
    var img = await image.getImage(source: ImageSource.camera);
    setState((){
      file1 = File(img!.path);
      file=null;
    });
  }
//select image
  getGall() async{
    var img = await image.getImage(source: ImageSource.gallery);
    setState((){
      file = File(img!.path);
      file1=null;
    });
  }
  //select filds

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style:TextStyle(
            fontSize: 18,
          ),
        ),
      );


}

class Haddemindio{
  final Dio dio=Dio();

  Future<ProduitModel> ajoutprod(bool available,String nom,String prix,String description,String img,int categorie) async{
    try{
      final response = await dio.post("http://sup-er-app.herokuapp.com/fournisseur/mesproduits/", data: {'available':available,'nom': nom,'prix':prix,'description':description,'categorie':categorie,'image':img},
          options: Options(
              headers: {
                'Authorization':'token '+LoginScreen().localStorage.getItem('token')
              }
          ) );
      debugPrint(response.toString());
      return ProduitModel.fromJSON(response.data);
    } on DioError catch(e){
      debugPrint("status code : ${e.response?.statusCode.toString()}");
      throw Exception("Failed");
    }
  }
}
