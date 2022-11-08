// class Options {
//  late bool success;
//    late Data data;
//  late  String message;

//   Options({ required this.success, required this.data, required this.message});

//   Options.fromJson(Map<String, dynamic> json) {
//     success = json['success']?? false;
//     data = json['data'] ;
//     message = json['message']?? '';
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }

class Data {
 late List<Categories> categories;
 late List<Types> types;
 late List<Taboos> taboos;
 late List<Cities> cities;
 late List<Features> features;

  Data({required this.categories,required this.types,required this.taboos,required this.cities,required this.features});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types.add( Types.fromJson(v));
      });
    }
    if (json['taboos'] != null) {
      taboos = <Taboos>[];
      json['taboos'].forEach((v) {
        taboos.add( Taboos.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities.add( Cities.fromJson(v));
      });
    }
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features.add( Features.fromJson(v));
      });
    }
  }

}

class Categories {
 late  int id;
 late String name;

 bool selected=false;

  Categories({required this.id,required this.name,});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

  }
}

class Taboos {
  late int id;
  late String taboo;

  bool selected=false;
  Taboos({required this.id,required  this.taboo,});

  Taboos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taboo = json['taboo'];

  }

}


class Types {
 late int id;
 late String name;

 bool selected=false;
  Types({ required this.id, required this.name});

  Types.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']??'';

  }

}


class Cities {
 late int id;
 late String name;

 bool selected=false;
  Cities({ required this.id,required  this.name,});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

  }

}

class Features {
 late  int id;
 late  String name;

 bool selected=false;
  Features({required this.id,required  this.name,});

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

  }

}