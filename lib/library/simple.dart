import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supper/library/client.dart';

class DioHaddemine{
  final Dio dio=Dio();
  static const baseURL="http://sup-er-app.herokuapp.com/fournisseur";
  static const Resgisterendpoint= baseURL +"/registerfournisseur/";

  Future<Client> fetchPrduit(String nom, String prenom, String email,String username,String password, String telephone,String sexe,String description,String adresse) async{
    try{
      final response = await dio.post(Resgisterendpoint, data:
      {'nom': nom, 'prenom': prenom,'email':email,'username':username,'password':password,'telephone':telephone,'image':sexe,'description':description,'adresse':adresse}
      );
      debugPrint(response.toString());
      return Client.fromJSON(response.data);
    } on DioError catch(e){
      debugPrint("status code : ${e.response?.statusCode.toString()}");
      throw Exception("Failed");
    }
  }
}

