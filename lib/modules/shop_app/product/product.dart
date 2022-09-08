import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supper/layout/shop_app/cubit/cubit.dart';
import 'package:supper/layout/shop_app/cubit/states.dart';
import 'package:supper/modules/shop_app/login_shop/cubit/states.dart';

import '../login_shop/cubit/cubit.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold();
            // ConditionalBuilder(
            // condition: ,
            // builder: (context) =>,
            // fallback: (context) => Center(child: CircularProgressIndicator()),);
        },
      ),
    );
  }
}
