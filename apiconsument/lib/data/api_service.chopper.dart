// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ApiService extends ApiService {
  _$ApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ApiService;

  @override
  Future<Response<dynamic>> userById(int id) {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/user/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> usersAll() {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/users';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> officeById(int id) {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/office/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> officeAll() {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/offices';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> requestsAll() {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/requests';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> requestsPendingsAll() {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/pendingrequests';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> requestById(int id) {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/request/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> carByPlateNumber(String plate_number) {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/car/$plate_number';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteCarByPlateNumber(String plate_number) {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/_car/$plate_number';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteUserById(String user_id) {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/_user/$user_id';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postNewUser(Map<String, dynamic> myUser) {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/user';
    final $body = myUser;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> carAll() {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/cars';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPosts() {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/posts';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPost(int id) {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net/posts/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postPost(Map<String, dynamic> body) {
    final $url = 'https://iap-warsaw-hq.azurewebsites.net';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
