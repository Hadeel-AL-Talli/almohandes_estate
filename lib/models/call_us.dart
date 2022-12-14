class CallUsModel{
CallUsModel({
    required this.id,
    required this.phone,
    required this.address,
    required this.about_us,
    required this.email,
    required this.link
    
  });
  late final int id;
  late final String phone;
  late final String email;
  late final String about_us;
  late final String address;
  late final String link;
  
  
  CallUsModel.fromJson(Map<String, dynamic> json){
    id = json['id'] ;
    phone = json['phone'];
    email = json['email'];
    about_us = json['about_us'];
    address = json['address'];
    link = json['link'];
   
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['phone'] = phone;
      _data['email'] = email;
        _data['email'] = email;
          _data['about_us'] = about_us;
            _data['address'] = address;
              _data['link'] = link;
   
    return _data;
  }
}