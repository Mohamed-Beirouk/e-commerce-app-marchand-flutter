class LoginModel
{
int? id;
bool? status;
String? message;
String? token;
UserData? data;

LoginModel.fromJason(Map<String,dynamic> json)
{
  id = json['id'];
  status = json['status'];
  message = json['message'];
  token = json['token'];
  data = json['data'] != null ? UserData.fromJason(json['data']): null;
}

}

class UserData
{
  String? username;
  String? phone;

  //named constractor
  UserData.fromJason(Map<String,dynamic> json)
  {
     username = json['username'];
     phone = json['phone'];
  }
}


