
class Details {
 late  int id;
 late  String title;
 late  String location;
 late  String totalPrice;
 late  String meterPrice;
 late  String floors;
 late  String propertyFloor;
 late  String size;
 late  String number;
 late  String rooms;
 late  String nzal;
 late  String front;
 late  String street;
 late  String description;
 late  String tabooId;
 late  String typeId;
 late  String categoryId;
 late  String cityId;
late  String status;
 late var leaseType;
// late  String rejectReason;
 late String tabooName;
 late String typeName;
 late String categoryName;
 late String cityName;
 late List<Features> features;
 late List<Images> images;
 late Taboo taboo;
  late Type type;
 late Type category;
 late Type city;

  Details(
      {required this.id,
     required  this.title,
     required  this.location,
     required  this.totalPrice,
     required  this.meterPrice,
     required  this.floors,
     required  this.propertyFloor,
     required  this.size,
     required  this.number,
     required  this.rooms,
     required  this.nzal,
     required  this.front,
     required  this.street,
     required  this.description,
     required  this.tabooId,
     required  this.typeId,
     required  this.categoryId,
     required  this.cityId,
     required  this.status,
     required  this.leaseType,
    // required  this.rejectReason,
     required  this.tabooName,
     required  this.typeName,
     required  this.categoryName,
     required  this.cityName,
     required  this.features,
     required  this.images,
     required  this.taboo,
     required  this.type,
     required this.category,
     required this.city});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ??'';
    location = json['location']?? '';
    totalPrice = json['total_price']?? '';
    meterPrice = json['meter_price']?? '';
    floors = json['floors']?? '';
    propertyFloor = json['property_floor']??'';
    size = json['size']?? '';
    number = json['number']??'';
    rooms = json['rooms']??'';
    nzal = json['nzal']??'';
    front = json['front']??'';
    street = json['street']??'';
    description = json['description']??'';
    tabooId = json['taboo_id']??'';
    typeId = json['type_id']??'';
    categoryId = json['category_id']??'';
    cityId = json['city_id']??'';
    status = json['status']??'';
    leaseType = json['lease_type']??'';
    //rejectReason = json['reject_reason'];
    tabooName = json['taboo_name']??'';
    typeName = json['type_name']??'';
    categoryName = json['category_name']??'';
    cityName = json['city_name']??'';
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    //taboo = json['taboo'] ;
   // type = json['type'];
   // category = json['category'] ;
       
    //city = json['city'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['location'] = this.location;
    data['total_price'] = this.totalPrice;
    data['meter_price'] = this.meterPrice;
    data['floors'] = this.floors;
    data['property_floor'] = this.propertyFloor;
    data['size'] = this.size;
    data['number'] = this.number;
    data['rooms'] = this.rooms;
    data['nzal'] = this.nzal;
    data['front'] = this.front;
    data['street'] = this.street;
    data['description'] = this.description;
    data['taboo_id'] = this.tabooId;
    data['type_id'] = this.typeId;
    data['category_id'] = this.categoryId;
    data['city_id'] = this.cityId;
    data['status'] = this.status;
    data['lease_type'] = this.leaseType;
 //   data['reject_reason'] = this.rejectReason;
    data['taboo_name'] = this.tabooName;
    data['type_name'] = this.typeName;
    data['category_name'] = this.categoryName;
    data['city_name'] = this.cityName;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.taboo != null) {
      data['taboo'] = this.taboo!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class Features {
 late String featureName;

  Features({ required this.featureName});

  Features.fromJson(Map<String, dynamic> json) {
    featureName = json['feature_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feature_name'] = this.featureName;
    return data;
  }
}

class Images {
 late String image;

  Images({required this.image});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class Taboo {
 late int id;
 late String taboo;

  Taboo({required this.id,required this.taboo});

  Taboo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taboo = json['taboo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['taboo'] = this.taboo;
    return data;
  }
}

class Type {
 late int id;
  late String name;

  Type({ required this.id,required  this.name});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
