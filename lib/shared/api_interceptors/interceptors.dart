import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';

import '../environment/environment.dart';
import '../utils/local_storage.dart';
import 'interceptor_repo.dart';

class HeadersInterceptors implements InterceptorContract {
  @override
  Future<bool> shouldInterceptRequest() async => true;
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    String token = await SecureLocalStorage.readValue('access_token') ?? '';
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'application/json';
    return Future.value(request);
  }

  @override
  Future<bool> shouldInterceptResponse() async => true;
  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) {
    return Future.value(response);
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 2;

  @override
  Future<bool> shouldAttemptRetryOnException(
      Exception exception, BaseRequest request) async {
    if (exception is SocketException || exception is HttpException) {
      return true;
    }

    return true;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    // final token = await SecureLocalStorage.readValue('access_token');
    // final tokenExpiry = getTokenExpiry(token);
    // final timeUntilExpiry = tokenExpiry.difference(DateTime.now());
    // const refreshTime = Duration(minutes: 5);

    // if (timeUntilExpiry <= refreshTime) {
    //   // Refresh the token
    //   TokenRefreshRepo tokenRefreshRepo = TokenRefreshRepo(
    //     environment: Environment.instance,
    //   );
    //   await tokenRefreshRepo.refreshToken();

    //   return true;
    // }

    if (response.statusCode == 401) {
      // Call the refresh token endpoint
      TokenRefreshRepo tokenRefreshRepo = TokenRefreshRepo(
        environment: Environment.instance,
      );
      await tokenRefreshRepo.refreshToken();

      return true;
    }

    return false;
  }
}

DateTime getTokenExpiry(String? token) {
  final parts = token?.split('.');
  if (parts?.length != 3) {
    throw const FormatException('Invalid token');
  }

  final payloadPart = parts?[1];
  final payloadString =
      utf8.decode(base64Url.decode(base64Url.normalize(payloadPart!)));

  final payloadMap = json.decode(payloadString);
  if (payloadMap is! Map<String, dynamic>) {
    throw const FormatException('Invalid payload');
  }

  final exp = payloadMap['exp'];
  if (exp is! int) {
    throw const FormatException('Invalid expiration time');
  }

  return DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true);
}
