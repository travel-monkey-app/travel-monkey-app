class UserRegirationnModel {
  String? message;
  int? userId;
  String? username;
  String? email;

  UserRegirationnModel({this.message, this.userId, this.username, this.email});

  UserRegirationnModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}
