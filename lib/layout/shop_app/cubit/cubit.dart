import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supper/layout/shop_app/cubit/states.dart';
import 'package:supper/modules/shop_app/favorite/favorite.dart';
import 'package:supper/modules/shop_app/hom/home_screen.dart';
import 'package:supper/modules/shop_app/shats/shats_screen.dart';
import 'package:supper/network/end_points.dart';
import '../../../modules/shop_app/mesproduits/produitcat.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> bottomScreen = [
    HomScreen(),
    FavoriteScreen(),
    ProduitCat(id:1),
    ShatScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void getBusiness()
  {
    emit(ShopLoadingProductDataState());

    DioHelper.getData(
      url: PRODUCT,

      query: {
        "id": 1,
        "available": true,
        "nom": "Iphone 8",
        "prix": "120.0000000",
        "description": "Noire",
        "image": "https://sup-er-app.herokuapp.com/7.jpg",
        "fournisseurs": 34,
        "marqueprives": 1,
        "categories": 1
      },).then((value)
    {
      print(value.data.toString());

      emit(ShopSuccessProductDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorProductDataState());
    });
  }
}