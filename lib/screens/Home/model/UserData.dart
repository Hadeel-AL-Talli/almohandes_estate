class UserData {
  late int id;
  late String name;
  late String email;
  late var phone;
  



  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']??"";
    email = json['email']??"";
    phone = json['phone']??"";
    
  }

}