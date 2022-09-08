class PanierModel{
  ProductData? data;
  int? quantite;
  PanierModel.fromJason(Map<String,dynamic> json)
  {
    data = (json['data'] != null ? PanierModel.fromJason(json['data']): null) as ProductData?;
    quantite = json['Quantiter'];
  }
}

class ProductData{
  int? id;
  bool? available;
  String? nom;
  String? prix;
  String? description;
  String? image;

  ProductData.fromJason(Map<String,dynamic> json)
   {
     id = json['id'];
     available = json['available'];
     nom = json['nom'];
     prix = json['prix'];
     description = json['description'];
     image = json['image'];


   }
}