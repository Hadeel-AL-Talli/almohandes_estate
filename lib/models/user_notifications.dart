class UserNotifications {
  late var id ;
  late var title;
  late var body;
  late var type;
  late var product_id;
  late var user_id;
  late var fcm_token;
  late var created_at;
  late var reject_reason;

  UserNotifications({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.reject_reason,
    required this.created_at
  });


UserNotifications.fromJson(Map<String, dynamic> json){
  id = json['id'];
  title = json['title'];
  body = json['body'];
  type = json['type'];
  reject_reason = json['reject_reason'];
  created_at = json['created_at'];
}
}