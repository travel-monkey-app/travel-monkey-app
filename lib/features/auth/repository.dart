import 'dart:convert';
import 'dart:developer';
import '../../shared/environment/environment.dart';
import '../../shared/api_interceptors/api_call_interceptors.dart';
import 'models/user_login_models.dart';
import 'models/user_profile_models.dart';
import 'models/user_regirationn_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Environment environment;
  InterceptorApiCaller apiCaller = InterceptorApiCaller();

  //  final CallApi callApiInterceptor = CallApi();

  AuthRepository({required this.environment});

  Future<UserLoginModel> login(
      {required String username, required String password}) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var url = environment.getBaseUrl + environment.tenant_login_sub_url;
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({"username": username, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    log(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      // log('Response: $jsonResponse');

      return UserLoginModel.fromJson(jsonResponse);
    } else {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      throw jsonResponse['detail'];
    }
  }

  Future<UserRegirationnModel> register(
      {required String username,
      required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String phonenumber,
      required confirmPassword}) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            environment.getBaseUrl + environment.tenant_registration_sub_url));
    request.body = json.encode({
      "username": username,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "password2": confirmPassword,
      "phone_number": phonenumber
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      log('Response: $jsonResponse');
      return UserRegirationnModel.fromJson(jsonResponse);
    } else {
      var jsonResponse = await response.stream.bytesToString();

      throw jsonResponse;
    }
  }

  Future<String> validateAccount(
      {required String otp, required String email}) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    String url =
        environment.getBaseUrl + environment.tenant_validate_account_sub_url;
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({"otp": otp, "email": email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      return jsonResponse['message'];
    } else {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      throw jsonResponse['error'];
    }
  }

  Future<String> resendValidateAccountOtp({required String email}) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    String url = environment.getBaseUrl + environment.tenant_resend_otp_url;
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({"email": email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      return jsonResponse['message'];
    } else {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      throw jsonResponse['error'];
    }
  }

  Future<String> resetPassword({required String email}) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    String url =
        environment.getBaseUrl + environment.tenant_forgot_password_url;
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({"email": email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      return jsonResponse['message'];
    } else {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      throw jsonResponse['error'];
    }
  }

  Future<String> confirmResetPassword(
      {required String otp,
      required String email,
      required String newPassword,
      required cinfirmPassword}) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    String url =
        environment.getBaseUrl + environment.tenant_confirm_reset_password_url;
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "token": otp,
      "email": email,
      "new_password": newPassword,
      "confirm_password": cinfirmPassword
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      return jsonResponse['message'];
    } else {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      throw jsonResponse['message'];
    }
  }

  Future<String> updateUserProfile(
      {required String token,
      required String firstName,
      required String lastName,
      required String email,
      required String username}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    String url = environment.getBaseUrl + environment.tenant_user_profile_url;
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode({
      "username": username,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      return jsonResponse['message'];
    } else {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      throw jsonResponse['message'];
    }
  }

  Future<UserProfilemodel> fetchUserProfile() async {
    String url = environment.getBaseUrl + environment.tenant_user_profile_url;
    var response = await apiCaller.get(url);

    // log(response.toString());

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      UserProfilemodel userProfilemodel =
          UserProfilemodel.fromJson(jsonResponse);
      return userProfilemodel;
    } else {
      var jsonResponse = json.decode(response.body);

      throw jsonResponse;
    }
  }

  //  edit profile

  Future<dynamic> editProfile(
      {required String firstName,
      required String lastName,
      required String phoneNumber,
      required String email,
      profilePicPath}) async {
    Map<String, String> body = {
      'first_name': firstName.toString(),
      'last_name': lastName.toString(),
      'email': email.toString(),
      'phone_number': phoneNumber.toString(),
      "user_profile_pic": profilePicPath.toString()
    };

    var url = environment.getBaseUrl + environment.tenant_user_profile_url;

    var response =
        await apiCaller.putFormDataWithFile(url, body, 'user_profile_pic');

    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      return jsonResponse['message'];
    } else {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      log(jsonResponse.toString());

      throw jsonResponse;
    }
  }

  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    var body = json.encode({
      "old_password": oldPassword,
      "new_password": newPassword,
    });
    String url =
        environment.getBaseUrl + environment.tenant_change_password_url;
    var response = await apiCaller.put(url, body);
    var jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return jsonResponse['message'];
    } else {
      throw jsonResponse['message'];
    }
  }

  Future<UserLoginModel> googleSignIn({
    required String? accessToken,
  }) async {
    String url = environment.getBaseUrl + environment.tenant_google_auth_url;

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "access_token": accessToken,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      // log('Response: $jsonResponse');

      return UserLoginModel.fromJson(jsonResponse);
    } else {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      throw jsonResponse['message'];
    }
  }
}
