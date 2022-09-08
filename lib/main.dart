import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supper/modules/shop_app/hom/home_screen.dart';
import 'package:supper/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:supper/shared/components/constants.dart';
import 'layout/shop_app/shop_layout.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'package:supper/modules/shop_app/login_shop/login_screen.dart';

void main()
async
{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,

          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor:Colors.green.withOpacity(0.7),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green.withOpacity(0.7),
          elevation: 20
        )
      ),
      darkTheme: ThemeData(
      scaffoldBackgroundColor: Colors.black26,
    ),
      themeMode: ThemeMode.light,

      home: LoginScreen().localStorage.getItem('token')==null ?
      OnBoardingScreen() :ShopLayout(),
    );
  }
}

