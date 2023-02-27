class AdModel {
AdModel({
    required this.id,
    required this.images,
    required this.title,
    required this.typeName,
    required this.city
    
    
  });
  late final int id;
  late final String images;
  late final String title;
  late String typeName;
  late String city;
  AdModel.fromJson(Map<String, dynamic> json){
    id = json['id'] ;
    images = json['images'];
    title = json["title"]?? '';
     typeName = json['type_name']??'';
     city = json['city_name'];
   
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['images'] = images;
    _data['title'] = title;
   _data['city_name']= city;
    return _data;
  }
}