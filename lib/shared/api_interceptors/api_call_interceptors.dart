import 'package:http_interceptor/http/intercepted_client.dart';
import '../utils/local_storage.dart';
import 'interceptors.dart';
import 'package:http/http.dart' as http;

class InterceptorApiCaller {
  final client = InterceptedClient.build(
    interceptors: [HeadersInterceptors()],
    retryPolicy: ExpiredTokenRetryPolicy(),
  );

//

  Future<dynamic> get(String url) async {
    var response = await client.get(Uri.parse(url));
    return response;
  }

  Future<dynamic> post(String url, dynamic body) async {
    var response = await client.post(Uri.parse(url), body: body);
    return response;
  }

  Future<dynamic> put(String url, dynamic body) async {
    var response = await client.put(Uri.parse(url), body: body);
    return response;
  }

  Future<dynamic> delete(String url) async {
    var response = await client.delete(Uri.parse(url));
    return response;
  }

  Future<dynamic> patch(String url, dynamic body) async {
    var response = await client.patch(Uri.parse(url), body: body);
    return response;
  }

  Future<dynamic> postFormData(String url, dynamic body) async {
    var response = await client.post(Uri.parse(url), body: body);
    return response;
  }

  Future<dynamic> putFormData(String url, dynamic body) async {
    var response = await client.put(Uri.parse(url), body: body);
    return response;
  }

  Future<dynamic> patchFormData(String url, dynamic body) async {
    var response = await client.patch(Uri.parse(url), body: body);
    return response;
  }

  Future<dynamic> deleteFormData(String url) async {
    var response = await client.delete(Uri.parse(url));
    return response;
  }

  Future<dynamic> postFormDataWithFile(String url, dynamic body) async {
    var response = await client.post(Uri.parse(url), body: body);
    return response;
  }

  Future<dynamic> putFormDataWithFile(
      String url, Map<String, String> body, String? imageKey) async {
    String token = await SecureLocalStorage.readValue('access_token');

    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.fields.addAll(body);
    request.headers.addAll(headers);

    if (body[imageKey] != '') {
      request.files
          .add(await http.MultipartFile.fromPath(imageKey!, body[imageKey]!));
    }

    http.StreamedResponse response = await request.send();

    return response;
  }
}
