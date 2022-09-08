import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supper/modules/shop_app/login_shop/login_screen.dart';
import 'package:supper/shared/components/components.dart';
import 'package:supper/styles/icon_broken.dart';
import '../../../library/simple.dart';
import '../login_shop/cubit/cubit.dart';
import '../login_shop/cubit/states.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formkey = GlobalKey<FormState>();
  File? file;
  ImagePicker image = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var nomController = TextEditingController();
    var prenomController = TextEditingController();
    var emailController = TextEditingController();
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();
    var telephoneController = TextEditingController();
    var nom_boutiqueController = TextEditingController();
    var adresseController = TextEditingController();
    var confirmepasswordController = TextEditingController();



    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status == true)
            {
              print(state.loginModel.message);
              //print(state.loginModel.data!.token);

              Fluttertoast.showToast(
                  msg: '${state.loginModel.message}',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 8,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            }else{
              print(state.loginModel.message);
              Fluttertoast.showToast(
                  msg: '${state.loginModel.message}',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Inscription',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'S\'inscrire maintenant et devenir un Fournisseur',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                          controller: nomController,
                          type: TextInputType.text,
                          text: 'Nom',
                          prefix: Icons.person,
                        ),

                        defaultTextField(
                          controller: prenomController,
                          type: TextInputType.text,
                          text: 'Prenom',
                          prefix: Icons.person,
                        ),

                        defaultTextField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          text: 'Email adresse',
                          prefix: Icons.email,
                        ),

                        defaultTextField(
                          controller: usernameController,
                          type: TextInputType.text,
                          text: 'Nom d\'utilisateur',
                          prefix: Icons.person,
                        ),

                        defaultTextField(
                          controller: telephoneController,
                          type: TextInputType.number,
                          text: 'Telephone',
                          prefix: Icons.phone,
                        ),

                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(400, 40),
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
                        height: 20,
                      ),

                        defaultTextField(
                          controller: nom_boutiqueController,
                          type: TextInputType.text,
                          text: 'Nom de boutique',
                          prefix: Icons.comment,
                        ),


                        defaultTextField(
                          controller: passwordController,
                          isPassword:ShopLoginCubit.get(context).isPassword,
                          type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixFunction: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          text: 'Mot de passe',

                          prefix: Icons.lock_outline,
                        ),

                        defaultTextField(
                          controller: confirmepasswordController,
                          isPassword:ShopLoginCubit.get(context).isPassword,
                          type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixFunction: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          text: 'Confirmer le  mot de passe',

                          prefix: Icons.lock_outline,
                        ),

                        defaultButtonL(
                          function: ()
                        {
                          DioHaddemine().fetchPrduit(
                              nomController.text,
                              prenomController.text,
                              emailController.text,
                              usernameController.text,
                              passwordController.text,
                              telephoneController.text,
                              file.toString().split('/').last,
                              nom_boutiqueController.text,
                              adresseController.text
                          ).then(
                                  (value){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                              }
                          );
                        },
                          text: 'S\'inscrire',
                          color:Colors.green.withOpacity(0.7),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Vous avez déjè un compte?'),
                            TextButton(onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            }, child: Text(
                              ' connecter ',
                              style: TextStyle(
                                color: Colors.green.withOpacity(0.7),
                              ) ,
                            ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

  }
  getGall() async{
    var img = await image.getImage(source: ImageSource.gallery);
    setState((){
      file = File(img!.path);
    });
  }
}

