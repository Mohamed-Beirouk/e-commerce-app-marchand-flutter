class Client{
  final String username;
  final String password;

  Client({
    required this.username, required this.password
});
  factory Client.fromJSON(Map<String,dynamic> parsedJson){
    return Client(username: parsedJson['username'], password: parsedJson['password']);
  }


Map<String,dynamic> toJson() => {
  'username':username,
  'password':password
};

//static List<Client> listFromJson(List<dynamic> list)=> List<Client>.from(list.map((x)=> Client.fromJSON(x)));

}