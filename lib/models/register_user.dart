class RegisterUser{
  
  late var email;
  late var phone;
  late var password ; 
 late var c_password ; 
  late var name;
  late var token;
 

  RegisterUser();
  RegisterUser.fromJson(Map<String, dynamic> json){
  //  id= json['id'];
    email = json['email'];
    password = json['password'];
   c_password = json['c_password'];
    name = json['name'];
    phone = json['phone'];
    token = json['token'];
    
  }
}