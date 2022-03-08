import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'model.dart';
part 'responses.freezed.dart';

@freezed
class ListPetsResponse with _$ListPetsResponse {
  const factory ListPetsResponse.status200({
    required Response response,
    required Pets result,
  }) = ListPetsResponse200;

  const factory ListPetsResponse.fallback({
    required Response response,
    required Error result,
  }) = ListPetsResponseFallback;

  factory ListPetsResponse(Response response) {
    if (response.statusCode == 200) {
      return ListPetsResponse.status200(
        response: response,
        result: [...(response.data as List).map((e) => Pet.fromJson(e))],
      );
    }
    return ListPetsResponse.fallback(
      response: response,
      result: response.data,
    );
  }
}

@freezed
class CreatePetsResponse with _$CreatePetsResponse {
  const factory CreatePetsResponse.status201({
    required Response response,
  }) = CreatePetsResponse201;

  const factory CreatePetsResponse.fallback({
    required Response response,
    required Error result,
  }) = CreatePetsResponseFallback;

  factory CreatePetsResponse(Response response) {
    if (response.statusCode == 201) {
      return CreatePetsResponse.status201(
        response: response,
      );
    }
    return CreatePetsResponse.fallback(
      response: response,
      result: response.data,
    );
  }
}

@freezed
class ShowPetByIdResponse with _$ShowPetByIdResponse {
  const factory ShowPetByIdResponse.status200({
    required Response response,
    required Pet result,
  }) = ShowPetByIdResponse200;

  const factory ShowPetByIdResponse.fallback({
    required Response response,
    required Error result,
  }) = ShowPetByIdResponseFallback;

  factory ShowPetByIdResponse(Response response) {
    if (response.statusCode == 200) {
      return ShowPetByIdResponse.status200(
        response: response,
        result: response.data,
      );
    }
    return ShowPetByIdResponse.fallback(
      response: response,
      result: response.data,
    );
  }
}
