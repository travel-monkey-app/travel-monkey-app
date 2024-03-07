import 'dart:convert';

import 'package:http_interceptor/http/intercepted_client.dart';

import '../environment/environment.dart';
import '../utils/local_storage.dart';
import 'interceptors.dart';

class TokenRefreshRepo {
  Environment? environment;
  final client = InterceptedClient.build(
    interceptors: [HeadersInterceptors()],
    retryPolicy: ExpiredTokenRetryPolicy(),
  );

  TokenRefreshRepo({required this.environment});

  Future<String> refreshToken() async {
    var url = environment!.getBaseUrl + environment!.tenant_refresh_token_url;
    var refresh = await SecureLocalStorage.readValue('refresh_token');
    var body = json.encode({"refresh": refresh});
    var response = await client.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var newToken = jsonResponse['access'];
      await SecureLocalStorage.writeValue('access_token', newToken);

      return newToken;
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}
