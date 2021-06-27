import 'package:chopper/chopper.dart';

// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.
part 'api_service.chopper.dart';

@ChopperApi()
// @ChopperApi(baseUrl: 'http://s-vm.northeurope.cloudapp.azure.com:8081')
abstract class ApiService extends ChopperService {
  @Get(path: '/user/{id}')
  Future<Response> userById(@Path('id') int id);

  @Get(path: '/users')
  Future<Response> usersAll();

  @Get(path: '/office/{id}')
  Future<Response> officeById(@Path('id') int id);

  @Get(path: '/offices')
  Future<Response> officeAll();

  @Get(path: '/requests')
  Future<Response> requestsAll();

  @Post(path: '/request')
  Future<Response> postNewRequestCar(@Body() Map<String, dynamic> myRequest);

  @Get(path: '/pendingrequests')
  Future<Response> requestsPendingsAll();

  @Get(path: '/request/{id}')
  Future<Response> requestById(@Path('id') int id);

  @Get(path: '/car/{plateNumber}')
  Future<Response> carByPlateNumber(@Path('plateNumber') String plateNumber);

  @Delete(path: '/_car/{plateNumber}')
  Future<Response> deleteCarByPlateNumber(
      @Path('plateNumber') String plateNumber);

  @Delete(path: '/_user/{userId}')
  Future<Response> deleteUserById(@Path('userId') String userId);

  @Post(path: '/user')
  Future<Response> postNewUser(@Body() Map<String, dynamic> myUser);

  @Get(path: '/cars')
  Future<Response> carAll();

  @Get(path: '/posts')
  Future<Response> getPosts();

// @Get(headers: {'Constant-Header-Name': 'Header-Value'})
// Future<Response> getPosts([
//   // Parameter headers are suitable for ones which values need to change
//   @Header('Changeable-Header-Name') String headerValue,
// ]);

  @Get(path: '/posts/{id}')
  Future<Response> getPost(@Path('id') int id);

  // Put & Patch requests are specified the same way - they must contain the @Body
  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  static ApiService create(String address) {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: address,
      services: [
        _$ApiService(),
      ],

      interceptors: [HttpLoggingInterceptor(), CurlInterceptor()],

      converter: JsonConverter(),
    );

    return _$ApiService(client);
  }
}
