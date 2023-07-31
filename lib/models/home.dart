class HomeModel {
 late int id;
 late String title;
 late String location;
 late String totalPrice;
 late String meterPrice;
 late String floors;
 late String propertyFloor;
 late String size;
 late String number;  
 late String rooms;
 late String nzal;
 late String front;
 late String street;
 late String description;
 late String tabooId;
 late String typeId;
 late String categoryId;
  late String cityId;
 late String status;
 late String leaseType;
 late String rejectReason;
 late String tabooName;
 late String typeName;
  late String? image;

 late String categoryName;
 late String cityName;
late  List<Features> features;
 List<Images>? images;

  HomeModel(
      {required this.id,
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
     required this.images,
     required   this.description,
     required   this.tabooId,
     required   this.typeId,
     required   this.categoryId,
     required   this.cityId,
    required  this.status,
    required  this.leaseType,
    required  this.rejectReason,
    required  this.features,
   
    });

  HomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title']??'' ;
    location = json['location']?? '';
    totalPrice = json['total_price']?? '';
    meterPrice = json['meter_price']?? '';
    floors = json['floors']?? '';
    propertyFloor = json['property_floor']??'';
    size = json['size']??'';
    number = json['number'] ?? '';
    rooms = json['rooms']??'';
    nzal = json['nzal']??'';
    image = json['image']??'https://app1.tp-iraq.com/property_images/default.png';
    //images = json['images']?? 'https://app1.tp-iraq.com/property_images/default.png';
    front = json['front']??'';
    street = json['street']??'';
    description = json['description']??'';
    tabooId = json['taboo_id']??'';
    typeId = json['type_id']??'';
    categoryId = json['category_id']??'';
    cityId = json['city_id']??'';
    status = json['status']??'';
    leaseType = json['lease_type']??'';
    tabooName = json['taboo_name']??'';
    typeName = json['type_name']??'';
    categoryName = json['category_name']??'';
    cityName = json['city_name']??'';
    rejectReason = json['reject_reason']??'';
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features.add(new Features.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }


}

class Features {
 late String featureName;

  Features({required this.featureName});

  Features.fromJson(Map<String, dynamic> json) {
    featureName = json['feature_name'];
  }

}

class Images {
 late String image;

  Images({required this.image});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'] ;
  }

}
