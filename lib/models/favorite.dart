class FavoriteModel {
  FavoriteModel({
    required this.id,
    required this.title,
    required this.location,
    required this.totalPrice,
    required this.meterPrice,
    required this.floors,
    required this.propertyFloor,
    required this.size,
    required this.number,
    required this.rooms,
    required this.nzal,
    required this.front,
    required this.street,
    required this.description,
    required this.tabooId,
    required this.typeId,
    required this.categoryId,
    required this.cityId,
    required this.status,
     this.leaseType,
    required this.rejectReason,
    required this.tabooName,
    required this.typeName,
    required this.categoryName,
    required this.cityName,
    required this.features,
    required this.images,
    required this.taboo,
    required this.type,
    required this.category,
    required this.city,
  });
  late final int id;
  late final String title;
  late final String location;
  late final String totalPrice;
  late final String meterPrice;
  late final String floors;
  late final String propertyFloor;
  late final String size;
  late final String number;
  late final String rooms;
  late final String nzal;
  late final String front;
  late final String street;
  late final String description;
  late final dynamic tabooId;
  late final dynamic typeId;
  late final dynamic categoryId;
  late final dynamic cityId;
  late final String status;
  late final Null leaseType;
  late final String rejectReason;
  late final String tabooName;
  late final String typeName;
  late final String categoryName;
  late final String cityName;
  late final List<Features> features;
  late final String images;
  late final Taboo taboo;
  late final Type type;
  late final Category category;
  late final City city;
  
  FavoriteModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title']??"";
    location = json['location']??"";
    totalPrice = json['total_price']??"";
    meterPrice = json['meter_price']??"";
    floors = json['floors']??"";
    propertyFloor = json['property_floor']??"";
    size = json['size']??"";
    number = json['number']??"";
    rooms = json['rooms']??"";
    nzal = json['nzal']??"";
    front = json['front']??"";
    street = json['street']??"";
    description = json['description']??"";
    tabooId = json['taboo_id']??"";
    typeId = json['type_id']??"";
    categoryId = json['category_id']??"";
    cityId = json['city_id']??"";
    status = json['status']??"";
    leaseType = null;
    rejectReason = json['reject_reason']??"";
    tabooName = json['taboo_name']??"";
    typeName = json['type_name']??"";
    categoryName = json['category_name']??"";
    cityName = json['city_name'];
    features = List.from(json['features']).map((e)=>Features.fromJson(e)).toList();
    images = json['images'];
    taboo = Taboo.fromJson(json['taboo']);
    type = Type.fromJson(json['type']);
    category = Category.fromJson(json['category']);
    city = City.fromJson(json['city']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['location'] = location;
    _data['total_price'] = totalPrice;
    _data['meter_price'] = meterPrice;
    _data['floors'] = floors;
    _data['property_floor'] = propertyFloor;
    _data['size'] = size;
    _data['number'] = number;
    _data['rooms'] = rooms;
    _data['nzal'] = nzal;
    _data['front'] = front;
    _data['street'] = street;
    _data['description'] = description;
    _data['taboo_id'] = tabooId;
    _data['type_id'] = typeId;
    _data['category_id'] = categoryId;
    _data['city_id'] = cityId;
    _data['status'] = status;
    _data['lease_type'] = leaseType;
    _data['reject_reason'] = rejectReason;
    _data['taboo_name'] = tabooName;
    _data['type_name'] = typeName;
    _data['category_name'] = categoryName;
    _data['city_name'] = cityName;
    _data['features'] = features.map((e)=>e.toJson()).toList();
    _data['images'] = images;
    _data['taboo'] = taboo.toJson();
    _data['type'] = type.toJson();
    _data['category'] = category.toJson();
    _data['city'] = city.toJson();
    return _data;
  }
}

class Features {
  Features({
    required this.featureName,
  });
  late final String featureName;
  
  Features.fromJson(Map<String, dynamic> json){
    featureName = json['feature_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['feature_name'] = featureName;
    return _data;
  }
}

class Taboo {
  Taboo({
    required this.id,
    required this.taboo,
  });
  late final int id;
  late final String taboo;
  
  Taboo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    taboo = json['taboo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['taboo'] = taboo;
    return _data;
  }
}

class Type {
  Type({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;
  
  Type.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;
  
  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class City {
  City({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;
  
  City.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}