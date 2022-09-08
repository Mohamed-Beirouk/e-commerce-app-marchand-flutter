import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supper/library/postitem.dart';
import 'package:supper/modules/shop_app/mesproduits/produitcat.dart';
import 'package:supper/modules/shop_app/detail_product/detail_product.dart';
import 'package:supper/modules/shop_app/product/product_screen.dart';
import 'package:supper/shared/components/components.dart';
import 'package:supper/styles/icon_broken.dart';
import 'package:supper/modules/shop_app/login_shop/login_screen.dart';
class HomScreen extends StatefulWidget {

  @override
  State<HomScreen> createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {
  bool _value = false;
  final items = ['Foot','Bar'];
  String? values;
  var nomController = TextEditingController();

  var prixController = TextEditingController();

  var descController = TextEditingController();
  File ?file;
  File ?file1;
  ImagePicker image = ImagePicker();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(),
    );
  }



}




