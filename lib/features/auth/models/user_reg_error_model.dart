class ValidationErrorModel {
  Message? message;

  ValidationErrorModel({this.message});

  ValidationErrorModel.fromJson(Map<dynamic, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = Map<dynamic, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  List<dynamic>? username;
  List<dynamic>? password;
  List<dynamic>? email;
  List<dynamic>? phonenumber;

  Message({this.username, this.password, this.email, this.phonenumber});

  Message.fromJson(Map<dynamic, dynamic> json) {
    username = json['username'] != null ? json['username'].cast<dynamic>() : [];
    password = json['password'] != null ? json['password'].cast<dynamic>() : [];
    email = json['email'] != null ? json['email'].cast<dynamic>() : [];
    phonenumber = json['phone_number'] != null
        ? json['phone_number'].cast<dynamic>()
        : [];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['phone_number'] = phonenumber;
    return data;
  }
}
