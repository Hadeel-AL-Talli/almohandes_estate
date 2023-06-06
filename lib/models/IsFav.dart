class IsFav{
  late bool isFavorite ;


  IsFav({required bool favorite});


  IsFav.fromJson(Map<String, dynamic> json) {
    isFavorite = json['isFavorite'];
  }

  
}

