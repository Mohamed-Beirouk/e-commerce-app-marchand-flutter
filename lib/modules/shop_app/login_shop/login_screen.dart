import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supper/layout/shop_app/shop_layout.dart';
import 'package:supper/modules/shop_app/login_shop/cubit/cubit.dart';
import 'package:supper/modules/shop_app/login_shop/cubit/states.dart';
import 'package:supper/modules/shop_app/register_shope/register_screen.dart';
import 'package:supper/network/local/cache_helper.dart';
import 'package:supper/shared/components/components.dart';
import 'package:localstorage/localstorage.dart';



class LoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  String id='';

  LocalStorage localStorage =new LocalStorage('ok');

  getData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status == true)
            {
              print(state.loginModel.message);
              print(state.loginModel.token);
              print(state.loginModel.id);
              id=state.loginModel.id.toString();
              localStorage.setItem('ok', id);
              localStorage.setItem('token', state.loginModel.token);
              print(localStorage.getItem('ok'));

              Fluttertoast.showToast(
                  msg: '${state.loginModel.message}',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 8,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.token
              ).then((value){
                navigateAndFinish(context, ShopLayout(),
                );
              });

            }else{
              print(state.loginModel.message);
              showToast(
                  text: '${state.loginModel.message}',
                  state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 75,
                          child: CircleAvatar(
                            radius: 73,
                            backgroundImage: AssetImage('assets/images/bare.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Se Connecter',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      defaultTextField(
                        controller: emailController,
                        type: TextInputType.text,
                        text: 'nom d\'utilisateur',
                        prefix: Icons.person,
                      ),
                      SizedBox(
                        height: 10,
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
                      SizedBox(
                        height: 15,
                      ),


                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => defaultButtonL(
                            function: ()
                            {
                              if(formkey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                    username: emailController.text,
                                    password: passwordController.text,
                                );

                              }

                            },
                            text: 'Connecter',
                          color:  Colors.green.withOpacity(0.7),

                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Vous n\'avez pas un compte ?'),
                          TextButton(onPressed: ()
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                          }, child: Text(
                            ' s\'inscrire ',
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
          );
        },
      ),
    );
  }
}
