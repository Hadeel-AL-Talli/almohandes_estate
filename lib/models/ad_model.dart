class AdModel {
AdModel({
    required this.id,
    required this.image,
    
  });
  late final int id;
  late final String image;
  
  
  AdModel.fromJson(Map<String, dynamic> json){
    id = json['id'] ;
    image = json['image'];
   
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
   
    return _data;
  }
}