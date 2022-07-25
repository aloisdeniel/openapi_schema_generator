import 'package:dio/dio.dart';
import 'responses.dart';
import 'model.dart';

class Api {
  const Api({
    required this.client,
  });

  static List<String> servers = [
    'https://petstore.swagger.io/',
  ];

  final Dio client;

  /// List all pets
  ///
  /// Parameters :
  ///   * limit : How many items to return at one time (max 100)
  Future<ListPetsResponse> listPets({
    int? limit,
    CancelToken? cancelToken,
  }) async {
    final response = await client.get(
      '/pets',
      cancelToken: cancelToken,
      queryParameters: {
        if (limit != null) 'limit': Uri.encodeQueryComponent(limit.toString()),
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return ListPetsResponse(response);
  }

  /// Create a pet
  ///
  /// Body : The created pet
  Future<CreatePetsResponse> createPets(
    Pet body, {
    CancelToken? cancelToken,
  }) async {
    final response = await client.post(
      '/pets',
      cancelToken: cancelToken,
      data: body.toJson(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return CreatePetsResponse(response);
  }

  /// Info for a specific pet
  ///
  /// Parameters :
  ///   * petId : The id of the pet to retrieve
  Future<ShowPetByIdResponse> showPetById({
    required String petId,
    CancelToken? cancelToken,
  }) async {
    final response = await client.get(
      '/pets/${Uri.encodeComponent(petId.toString())}',
      cancelToken: cancelToken,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return ShowPetByIdResponse(response);
  }
}
