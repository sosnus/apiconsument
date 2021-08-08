import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  @Get(path: '/user/{id}')
  Future<Response> userById(@Path('id') int id);

  @Post(path: '/assign/{requestCarId}')
  Future<Response> assignRequestCar(@Path('requestCarId') int requestCarId);

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

  @Get(path: '/posts/{id}')
  Future<Response> getPost(@Path('id') int id);

  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  static ApiService create(String address) {
    final client = ChopperClient(
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
