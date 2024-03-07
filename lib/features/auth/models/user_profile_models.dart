class UserProfilemodel {
  User? user;
  String? userProfilePic;
  String? phone;

  UserProfilemodel({this.user, this.userProfilePic, this.phone});

  UserProfilemodel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    userProfilePic = json['user_profile_pic'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['user_profile_pic'] = userProfilePic;
    data['phone'] = phone;
    return data;
  }
}

class User {
  String? username;
  String? email;
  String? firstName;
  String? lastName;

  User({this.username, this.email, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'] ?? '';
    email = json['email'] ?? '';
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
