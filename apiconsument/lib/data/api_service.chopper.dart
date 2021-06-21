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
    final $url = 'http://s-vm.northeurope.cloudapp.azure.com:8081/user/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> usersAll() {
    final $url = 'http://s-vm.northeurope.cloudapp.azure.com:8081/users';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> officeById(int id) {
    final $url = 'http://s-vm.northeurope.cloudapp.azure.com:8081/office/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> officeAll() {
    final $url = 'http://s-vm.northeurope.cloudapp.azure.com:8081/offices';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> carByPlateNumber(String plate_number) {
    final $url =
        'http://s-vm.northeurope.cloudapp.azure.com:8081/car/$plate_number';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteCarByPlateNumber(String plate_number) {
    final $url =
        'http://s-vm.northeurope.cloudapp.azure.com:8081/_car/$plate_number';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> carAll() {
    final $url = 'http://s-vm.northeurope.cloudapp.azure.com:8081/cars';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPosts() {
    final $url = 'http://s-vm.northeurope.cloudapp.azure.com:8081/posts';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPost(int id) {
    final $url = 'http://s-vm.northeurope.cloudapp.azure.com:8081/posts/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postPost(Map<String, dynamic> body) {
    final $url = 'http://s-vm.northeurope.cloudapp.azure.com:8081';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
