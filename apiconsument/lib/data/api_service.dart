import 'package:chopper/chopper.dart';

// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.
part 'api_service.chopper.dart';

// @ChopperApi(baseUrl: 'https://jsonplaceholder.typicode.com')
// const String testAddr = 'https://iap-warsaw-hq.azurewebsites.net';

// @ChopperApi(baseUrl: testAddr)
@ChopperApi()
// @ChopperApi(baseUrl: 'https://iap-warsaw-hq.azurewebsites.net')
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

  @Get(path: '/pendingrequests')
  Future<Response> requestsPendingsAll();

  @Get(path: '/request/{id}')
  Future<Response> requestById(@Path('id') int id);

  @Get(path: '/car/{plate_number}')
  Future<Response> carByPlateNumber(@Path('plate_number') String plate_number);

  @Delete(path: '/_car/{plate_number}')
  Future<Response> deleteCarByPlateNumber(
      @Path('plate_number') String plate_number);

  @Delete(path: '/_user/{user_id}')
  Future<Response> deleteUserById(@Path('user_id') String user_id);

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
  // Query parameters are specified the same way as @Path
  // but obviously with a @Query annotation
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
        // The generated implementation
        _$ApiService(),
      ],

      interceptors: [HttpLoggingInterceptor(), CurlInterceptor()],
      // interceptors: [
      //   (Request request) async {
      //     if (request.method == HttpMethod.Post) {
      //       chopperLogger.info('Performed a POST request');
      //     }
      //     return request;
      //   },
      //   (Response response) async {
      //     if (response.statusCode == 404) {
      //       chopperLogger.severe('404 NOT FOUND');
      //     }
      //     return response;
      //   },
      // ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$ApiService(client);
  }

  // requestsPendingsAll() {}
}
