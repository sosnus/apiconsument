import 'package:chopper/chopper.dart';

// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.
part 'api_service.chopper.dart';

@ChopperApi(baseUrl: 'https://jsonplaceholder.typicode.com/posts')
abstract class ApiService extends ChopperService {
  @Get()
  Future<Response> getPosts();

// @Get(headers: {'Constant-Header-Name': 'Header-Value'})
// Future<Response> getPosts([
//   // Parameter headers are suitable for ones which values need to change
//   @Header('Changeable-Header-Name') String headerValue,
// ]);

  @Get(path: '/{id}')
  // Query parameters are specified the same way as @Path
  // but obviously with a @Query annotation
  Future<Response> getPost(@Path('id') int id);

  // Put & Patch requests are specified the same way - they must contain the @Body
  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  static ApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        // The generated implementation
        _$ApiService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$ApiService(client);
  }
}
