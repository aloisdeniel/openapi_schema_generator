// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'responses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ListPetsResponseTearOff {
  const _$ListPetsResponseTearOff();

  ListPetsResponse200 status200(
      {required Response<dynamic> response, required List<Pet> result}) {
    return ListPetsResponse200(
      response: response,
      result: result,
    );
  }

  ListPetsResponseFallback fallback(
      {required Response<dynamic> response, required Error result}) {
    return ListPetsResponseFallback(
      response: response,
      result: result,
    );
  }
}

/// @nodoc
const $ListPetsResponse = _$ListPetsResponseTearOff();

/// @nodoc
mixin _$ListPetsResponse {
  Response<dynamic> get response => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Response<dynamic> response, List<Pet> result)
        status200,
    required TResult Function(Response<dynamic> response, Error result)
        fallback,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Response<dynamic> response, List<Pet> result)? status200,
    TResult Function(Response<dynamic> response, Error result)? fallback,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Response<dynamic> response, List<Pet> result)? status200,
    TResult Function(Response<dynamic> response, Error result)? fallback,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ListPetsResponse200 value) status200,
    required TResult Function(ListPetsResponseFallback value) fallback,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ListPetsResponse200 value)? status200,
    TResult Function(ListPetsResponseFallback value)? fallback,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListPetsResponse200 value)? status200,
    TResult Function(ListPetsResponseFallback value)? fallback,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ListPetsResponseCopyWith<ListPetsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListPetsResponseCopyWith<$Res> {
  factory $ListPetsResponseCopyWith(
          ListPetsResponse value, $Res Function(ListPetsResponse) then) =
      _$ListPetsResponseCopyWithImpl<$Res>;
  $Res call({Response<dynamic> response});
}

/// @nodoc
class _$ListPetsResponseCopyWithImpl<$Res>
    implements $ListPetsResponseCopyWith<$Res> {
  _$ListPetsResponseCopyWithImpl(this._value, this._then);

  final ListPetsResponse _value;
  // ignore: unused_field
  final $Res Function(ListPetsResponse) _then;

  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_value.copyWith(
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response<dynamic>,
    ));
  }
}

/// @nodoc
abstract class $ListPetsResponse200CopyWith<$Res>
    implements $ListPetsResponseCopyWith<$Res> {
  factory $ListPetsResponse200CopyWith(
          ListPetsResponse200 value, $Res Function(ListPetsResponse200) then) =
      _$ListPetsResponse200CopyWithImpl<$Res>;
  @override
  $Res call({Response<dynamic> response, List<Pet> result});
}

/// @nodoc
class _$ListPetsResponse200CopyWithImpl<$Res>
    extends _$ListPetsResponseCopyWithImpl<$Res>
    implements $ListPetsResponse200CopyWith<$Res> {
  _$ListPetsResponse200CopyWithImpl(
      ListPetsResponse200 _value, $Res Function(ListPetsResponse200) _then)
      : super(_value, (v) => _then(v as ListPetsResponse200));

  @override
  ListPetsResponse200 get _value => super._value as ListPetsResponse200;

  @override
  $Res call({
    Object? response = freezed,
    Object? result = freezed,
  }) {
    return _then(ListPetsResponse200(
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response<dynamic>,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Pet>,
    ));
  }
}

/// @nodoc

class _$ListPetsResponse200 implements ListPetsResponse200 {
  const _$ListPetsResponse200({required this.response, required this.result});

  @override
  final Response<dynamic> response;
  @override
  final List<Pet> result;

  @override
  String toString() {
    return 'ListPetsResponse.status200(response: $response, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListPetsResponse200 &&
            const DeepCollectionEquality().equals(other.response, response) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(response),
      const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  $ListPetsResponse200CopyWith<ListPetsResponse200> get copyWith =>
      _$ListPetsResponse200CopyWithImpl<ListPetsResponse200>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Response<dynamic> response, List<Pet> result)
        status200,
    required TResult Function(Response<dynamic> response, Error result)
        fallback,
  }) {
    return status200(response, result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Response<dynamic> response, List<Pet> result)? status200,
    TResult Function(Response<dynamic> response, Error result)? fallback,
  }) {
    return status200?.call(response, result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Response<dynamic> response, List<Pet> result)? status200,
    TResult Function(Response<dynamic> response, Error result)? fallback,
    required TResult orElse(),
  }) {
    if (status200 != null) {
      return status200(response, result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ListPetsResponse200 value) status200,
    required TResult Function(ListPetsResponseFallback value) fallback,
  }) {
    return status200(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ListPetsResponse200 value)? status200,
    TResult Function(ListPetsResponseFallback value)? fallback,
  }) {
    return status200?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListPetsResponse200 value)? status200,
    TResult Function(ListPetsResponseFallback value)? fallback,
    required TResult orElse(),
  }) {
    if (status200 != null) {
      return status200(this);
    }
    return orElse();
  }
}

abstract class ListPetsResponse200 implements ListPetsResponse {
  const factory ListPetsResponse200(
      {required Response<dynamic> response,
      required List<Pet> result}) = _$ListPetsResponse200;

  @override
  Response<dynamic> get response;
  List<Pet> get result;
  @override
  @JsonKey(ignore: true)
  $ListPetsResponse200CopyWith<ListPetsResponse200> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListPetsResponseFallbackCopyWith<$Res>
    implements $ListPetsResponseCopyWith<$Res> {
  factory $ListPetsResponseFallbackCopyWith(ListPetsResponseFallback value,
          $Res Function(ListPetsResponseFallback) then) =
      _$ListPetsResponseFallbackCopyWithImpl<$Res>;
  @override
  $Res call({Response<dynamic> response, Error result});

  $ErrorCopyWith<$Res> get result;
}

/// @nodoc
class _$ListPetsResponseFallbackCopyWithImpl<$Res>
    extends _$ListPetsResponseCopyWithImpl<$Res>
    implements $ListPetsResponseFallbackCopyWith<$Res> {
  _$ListPetsResponseFallbackCopyWithImpl(ListPetsResponseFallback _value,
      $Res Function(ListPetsResponseFallback) _then)
      : super(_value, (v) => _then(v as ListPetsResponseFallback));

  @override
  ListPetsResponseFallback get _value =>
      super._value as ListPetsResponseFallback;

  @override
  $Res call({
    Object? response = freezed,
    Object? result = freezed,
  }) {
    return _then(ListPetsResponseFallback(
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response<dynamic>,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Error,
    ));
  }

  @override
  $ErrorCopyWith<$Res> get result {
    return $ErrorCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
  }
}

/// @nodoc

class _$ListPetsResponseFallback implements ListPetsResponseFallback {
  const _$ListPetsResponseFallback(
      {required this.response, required this.result});

  @override
  final Response<dynamic> response;
  @override
  final Error result;

  @override
  String toString() {
    return 'ListPetsResponse.fallback(response: $response, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListPetsResponseFallback &&
            const DeepCollectionEquality().equals(other.response, response) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(response),
      const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  $ListPetsResponseFallbackCopyWith<ListPetsResponseFallback> get copyWith =>
      _$ListPetsResponseFallbackCopyWithImpl<ListPetsResponseFallback>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Response<dynamic> response, List<Pet> result)
        status200,
    required TResult Function(Response<dynamic> response, Error result)
        fallback,
  }) {
    return fallback(response, result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Response<dynamic> response, List<Pet> result)? status200,
    TResult Function(Response<dynamic> response, Error result)? fallback,
  }) {
    return fallback?.call(response, result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Response<dynamic> response, List<Pet> result)? status200,
    TResult Function(Response<dynamic> response, Error result)? fallback,
    required TResult orElse(),
  }) {
    if (fallback != null) {
      return fallback(response, result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ListPetsResponse200 value) status200,
    required TResult Function(ListPetsResponseFallback value) fallback,
  }) {
    return fallback(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ListPetsResponse200 value)? status200,
    TResult Function(ListPetsResponseFallback value)? fallback,
  }) {
    return fallback?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListPetsResponse200 value)? status200,
    TResult Function(ListPetsResponseFallback value)? fallback,
    required TResult orElse(),
  }) {
    if (fallback != null) {
      return fallback(this);
    }
    return orElse();
  }
}

abstract class ListPetsResponseFallback implements ListPetsResponse {
  const factory ListPetsResponseFallback(
      {required Response<dynamic> response,
      required Error result}) = _$ListPetsResponseFallback;

  @override
  Response<dynamic> get response;
  Error get result;
  @override
  @JsonKey(ignore: true)
  $ListPetsResponseFallbackCopyWith<ListPetsResponseFallback> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$CreatePetsResponseTearOff {
  const _$CreatePetsResponseTearOff();

  CreatePetsResponse201 status201({required Response<dynamic> response}) {
    return CreatePetsResponse201(
      response: response,
    );
  }

  CreatePetsResponseFallback fallback(
      {required Response<dynamic> response, required Error result}) {
    return CreatePetsResponseFallback(
      response: response,
      result: result,
    );
  }
}

/// @nodoc
const $CreatePetsResponse = _$CreatePetsResponseTearOff();

/// @nodoc
mixin _$CreatePetsResponse {
  Response<dynamic> get response => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Response<dynamic> response) status201,
    required TResult Function(Response<dynamic> response, Error result)
        fallback,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Response<dynamic> response)? status201,
    TResult Function(Response<dynamic> response, Error result)? fallback,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Response<dynamic> response)? status201,
    TResult Function(Response<dynamic> response, Error result)? fallback,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreatePetsResponse201 value) status201,
    required TResult Function(CreatePetsResponseFallback value) fallback,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreatePetsResponse201 value)? status201,
    TResult Function(CreatePetsResponseFallback value)? fallback,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreatePetsResponse201 value)? status201,
    TResult Function(CreatePetsResponseFallback value)? fallback,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreatePetsResponseCopyWith<CreatePetsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePetsResponseCopyWith<$Res> {
  factory $CreatePetsResponseCopyWith(
          CreatePetsResponse value, $Res Function(CreatePetsResponse) then) =
      _$CreatePetsResponseCopyWithImpl<$Res>;
  $Res call({Response<dynamic> response});
}

/// @nodoc
class _$CreatePetsResponseCopyWithImpl<$Res>
    implements $CreatePetsResponseCopyWith<$Res> {
  _$CreatePetsResponseCopyWithImpl(this._value, this._then);

  final CreatePetsResponse _value;
  // ignore: unused_field
  final $Res Function(CreatePetsResponse) _then;

  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_value.copyWith(
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response<dynamic>,
    ));
  }
}

/// @nodoc
abstract class $CreatePetsResponse201CopyWith<$Res>
    implements $CreatePetsResponseCopyWith<$Res> {
  factory $CreatePetsResponse201CopyWith(CreatePetsResponse201 value,
          $Res Function(CreatePetsResponse201) then) =
      _$CreatePetsResponse201CopyWithImpl<$Res>;
  @override
  $Res call({Response<dynamic> response});
}

/// @nodoc
class _$CreatePetsResponse201CopyWithImpl<$Res>
    extends _$CreatePetsResponseCopyWithImpl<$Res>
    implements $CreatePetsResponse201CopyWith<$Res> {
  _$CreatePetsResponse201CopyWithImpl(
      CreatePetsResponse201 _value, $Res Function(CreatePetsResponse201) _then)
      : super(_value, (v) => _then(v as CreatePetsResponse201));

  @override
  CreatePetsResponse201 get _value => super._value as CreatePetsResponse201;

  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(CreatePetsResponse201(
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response<dynamic>,
    ));
  }
}

/// @nodoc

class _$CreatePetsResponse201 implements CreatePetsResponse201 {
  const _$CreatePetsResponse201({required this.response});

  @override
  final Response<dynamic> response;

  @override
  String toString() {
    return 'CreatePetsResponse.status201(response: $response)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreatePetsResponse201 &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  $CreatePetsResponse201CopyWith<CreatePetsResponse201> get copyWith =>
      _$CreatePetsResponse201CopyWithImpl<CreatePetsResponse201>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Response<dynamic> response) status201,
    required TResult Function(Response<dynamic> response, Error result)
        fallback,
  }) {
    return status201(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Response<dynamic> response)? status201,
    TResult Function(Response<dynamic> response, Error result)? fallback,
  }) {
    return status201?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Response<dynamic> response)? status201,
    TResult Function(Response<dynamic> response, Error result)? fallback,
    required TResult orElse(),
  }) {
    if (status201 != null) {
      return status201(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreatePetsResponse201 value) status201,
    required TResult Function(CreatePetsResponseFallback value) fallback,
  }) {
    return status201(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreatePetsResponse201 value)? status201,
    TResult Function(CreatePetsResponseFallback value)? fallback,
  }) {
    return status201?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreatePetsResponse201 value)? status201,
    TResult Function(CreatePetsResponseFallback value)? fallback,
    required TResult orElse(),
  }) {
    if (status201 != null) {
      return status201(this);
    }
    return orElse();
  }
}

abstract class CreatePetsResponse201 implements CreatePetsResponse {
  const factory CreatePetsResponse201({required Response<dynamic> response}) =
      _$CreatePetsResponse201;

  @override
  Response<dynamic> get response;
  @override
  @JsonKey(ignore: true)
  $CreatePetsResponse201CopyWith<CreatePetsResponse201> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePetsResponseFallbackCopyWith<$Res>
    implements $CreatePetsResponseCopyWith<$Res> {
  factory $CreatePetsResponseFallbackCopyWith(CreatePetsResponseFallback value,
          $Res Function(CreatePetsResponseFallback) then) =
      _$CreatePetsResponseFallbackCopyWithImpl<$Res>;
  @override
  $Res call({Response<dynamic> response, Error result});

  $ErrorCopyWith<$Res> get result;
}

/// @nodoc
class _$CreatePetsResponseFallbackCopyWithImpl<$Res>
    extends _$CreatePetsResponseCopyWithImpl<$Res>
    implements $CreatePetsResponseFallbackCopyWith<$Res> {
  _$CreatePetsResponseFallbackCopyWithImpl(CreatePetsResponseFallback _value,
      $Res Function(CreatePetsResponseFallback) _then)
      : super(_value, (v) => _then(v as CreatePetsResponseFallback));

  @override
  CreatePetsResponseFallback get _value =>
      super._value as CreatePetsResponseFallback;

  @override
  $Res call({
    Object? response = freezed,
    Object? result = freezed,
  }) {
    return _then(CreatePetsResponseFallback(
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response<dynamic>,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Error,
    ));
  }

  @override
  $ErrorCopyWith<$Res> get result {
    return $ErrorCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
  }
}

/// @nodoc

class _$CreatePetsResponseFallback implements CreatePetsResponseFallback {
  const _$CreatePetsResponseFallback(
      {required this.response, required this.result});

  @override
  final Response<dynamic> response;
  @override
  final Error result;

  @override
  String toString() {
    return 'CreatePetsResponse.fallback(response: $response, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreatePetsResponseFallback &&
            const DeepCollectionEquality().equals(other.response, response) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(response),
      const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  $CreatePetsResponseFallbackCopyWith<CreatePetsResponseFallback>
      get copyWith =>
          _$CreatePetsResponseFallbackCopyWithImpl<CreatePetsResponseFallback>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Response<dynamic> response) status201,
    required TResult Function(Response<dynamic> response, Error result)
        fallback,
  }) {
    return fallback(response, result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Response<dynamic> response)? status201,
    TResult Function(Response<dynamic> response, Error result)? fallback,
  }) {
    return fallback?.call(response, result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Response<dynamic> response)? status201,
    TResult Function(Response<dynamic> response, Error result)? fallback,
    required TResult orElse(),
  }) {
    if (fallback != null) {
      return fallback(response, result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreatePetsResponse201 value) status201,
    required TResult Function(CreatePetsResponseFallback value) fallback,
  }) {
    return fallback(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreatePetsResponse201 value)? status201,
    TResult Function(CreatePetsResponseFallback value)? fallback,
  }) {
    return fallback?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreatePetsResponse201 value)? status201,
    TResult Function(CreatePetsResponseFallback value)? fallback,
    required TResult orElse(),
  }) {
    if (fallback != null) {
      return fallback(this);
    }
    return orElse();
  }
}

abstract class CreatePetsResponseFallback implements CreatePetsResponse {
  const factory CreatePetsResponseFallback(
      {required Response<dynamic> response,
      required Error result}) = _$CreatePetsResponseFallback;

  @override
  Response<dynamic> get response;
  Error get result;
  @override
  @JsonKey(ignore: true)
  $CreatePetsResponseFallbackCopyWith<CreatePetsResponseFallback>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$ShowPetByIdResponseTearOff {
  const _$ShowPetByIdResponseTearOff();

  ShowPetByIdResponse200 status200(
      {required Response<dynamic> response, required Pet result}) {
    return ShowPetByIdResponse200(
      response: response,
      result: result,
    );
  }

  ShowPetByIdResponseFallback fallback(
      {required Response<dynamic> response, required Error result}) {
    return ShowPetByIdResponseFallback(
      response: response,
      result: result,
    );
  }
}

/// @nodoc
const $ShowPetByIdResponse = _$ShowPetByIdResponseTearOff();

/// @nodoc
mixin _$ShowPetByIdResponse {
  Response<dynamic> get response => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Response<dynamic> response, Pet result) status200,
    required TResult Function(Response<dynamic> response, Error result)
        fallback,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Response<dynamic> response, Pet result)? status200,
    TResult Function(Response<dynamic> response, Error result)? fallback,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Response<dynamic> response, Pet result)? status200,
    TResult Function(Response<dynamic> response, Error result)? fallback,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowPetByIdResponse200 value) status200,
    required TResult Function(ShowPetByIdResponseFallback value) fallback,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ShowPetByIdResponse200 value)? status200,
    TResult Function(ShowPetByIdResponseFallback value)? fallback,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowPetByIdResponse200 value)? status200,
    TResult Function(ShowPetByIdResponseFallback value)? fallback,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShowPetByIdResponseCopyWith<ShowPetByIdResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShowPetByIdResponseCopyWith<$Res> {
  factory $ShowPetByIdResponseCopyWith(
          ShowPetByIdResponse value, $Res Function(ShowPetByIdResponse) then) =
      _$ShowPetByIdResponseCopyWithImpl<$Res>;
  $Res call({Response<dynamic> response});
}

/// @nodoc
class _$ShowPetByIdResponseCopyWithImpl<$Res>
    implements $ShowPetByIdResponseCopyWith<$Res> {
  _$ShowPetByIdResponseCopyWithImpl(this._value, this._then);

  final ShowPetByIdResponse _value;
  // ignore: unused_field
  final $Res Function(ShowPetByIdResponse) _then;

  @override
  $Res call({
    Object? response = freezed,
  }) {
    return _then(_value.copyWith(
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response<dynamic>,
    ));
  }
}

/// @nodoc
abstract class $ShowPetByIdResponse200CopyWith<$Res>
    implements $ShowPetByIdResponseCopyWith<$Res> {
  factory $ShowPetByIdResponse200CopyWith(ShowPetByIdResponse200 value,
          $Res Function(ShowPetByIdResponse200) then) =
      _$ShowPetByIdResponse200CopyWithImpl<$Res>;
  @override
  $Res call({Response<dynamic> response, Pet result});
}

/// @nodoc
class _$ShowPetByIdResponse200CopyWithImpl<$Res>
    extends _$ShowPetByIdResponseCopyWithImpl<$Res>
    implements $ShowPetByIdResponse200CopyWith<$Res> {
  _$ShowPetByIdResponse200CopyWithImpl(ShowPetByIdResponse200 _value,
      $Res Function(ShowPetByIdResponse200) _then)
      : super(_value, (v) => _then(v as ShowPetByIdResponse200));

  @override
  ShowPetByIdResponse200 get _value => super._value as ShowPetByIdResponse200;

  @override
  $Res call({
    Object? response = freezed,
    Object? result = freezed,
  }) {
    return _then(ShowPetByIdResponse200(
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response<dynamic>,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Pet,
    ));
  }
}

/// @nodoc

class _$ShowPetByIdResponse200 implements ShowPetByIdResponse200 {
  const _$ShowPetByIdResponse200(
      {required this.response, required this.result});

  @override
  final Response<dynamic> response;
  @override
  final Pet result;

  @override
  String toString() {
    return 'ShowPetByIdResponse.status200(response: $response, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShowPetByIdResponse200 &&
            const DeepCollectionEquality().equals(other.response, response) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(response),
      const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  $ShowPetByIdResponse200CopyWith<ShowPetByIdResponse200> get copyWith =>
      _$ShowPetByIdResponse200CopyWithImpl<ShowPetByIdResponse200>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Response<dynamic> response, Pet result) status200,
    required TResult Function(Response<dynamic> response, Error result)
        fallback,
  }) {
    return status200(response, result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Response<dynamic> response, Pet result)? status200,
    TResult Function(Response<dynamic> response, Error result)? fallback,
  }) {
    return status200?.call(response, result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Response<dynamic> response, Pet result)? status200,
    TResult Function(Response<dynamic> response, Error result)? fallback,
    required TResult orElse(),
  }) {
    if (status200 != null) {
      return status200(response, result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowPetByIdResponse200 value) status200,
    required TResult Function(ShowPetByIdResponseFallback value) fallback,
  }) {
    return status200(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ShowPetByIdResponse200 value)? status200,
    TResult Function(ShowPetByIdResponseFallback value)? fallback,
  }) {
    return status200?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowPetByIdResponse200 value)? status200,
    TResult Function(ShowPetByIdResponseFallback value)? fallback,
    required TResult orElse(),
  }) {
    if (status200 != null) {
      return status200(this);
    }
    return orElse();
  }
}

abstract class ShowPetByIdResponse200 implements ShowPetByIdResponse {
  const factory ShowPetByIdResponse200(
      {required Response<dynamic> response,
      required Pet result}) = _$ShowPetByIdResponse200;

  @override
  Response<dynamic> get response;
  Pet get result;
  @override
  @JsonKey(ignore: true)
  $ShowPetByIdResponse200CopyWith<ShowPetByIdResponse200> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShowPetByIdResponseFallbackCopyWith<$Res>
    implements $ShowPetByIdResponseCopyWith<$Res> {
  factory $ShowPetByIdResponseFallbackCopyWith(
          ShowPetByIdResponseFallback value,
          $Res Function(ShowPetByIdResponseFallback) then) =
      _$ShowPetByIdResponseFallbackCopyWithImpl<$Res>;
  @override
  $Res call({Response<dynamic> response, Error result});

  $ErrorCopyWith<$Res> get result;
}

/// @nodoc
class _$ShowPetByIdResponseFallbackCopyWithImpl<$Res>
    extends _$ShowPetByIdResponseCopyWithImpl<$Res>
    implements $ShowPetByIdResponseFallbackCopyWith<$Res> {
  _$ShowPetByIdResponseFallbackCopyWithImpl(ShowPetByIdResponseFallback _value,
      $Res Function(ShowPetByIdResponseFallback) _then)
      : super(_value, (v) => _then(v as ShowPetByIdResponseFallback));

  @override
  ShowPetByIdResponseFallback get _value =>
      super._value as ShowPetByIdResponseFallback;

  @override
  $Res call({
    Object? response = freezed,
    Object? result = freezed,
  }) {
    return _then(ShowPetByIdResponseFallback(
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response<dynamic>,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Error,
    ));
  }

  @override
  $ErrorCopyWith<$Res> get result {
    return $ErrorCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
  }
}

/// @nodoc

class _$ShowPetByIdResponseFallback implements ShowPetByIdResponseFallback {
  const _$ShowPetByIdResponseFallback(
      {required this.response, required this.result});

  @override
  final Response<dynamic> response;
  @override
  final Error result;

  @override
  String toString() {
    return 'ShowPetByIdResponse.fallback(response: $response, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShowPetByIdResponseFallback &&
            const DeepCollectionEquality().equals(other.response, response) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(response),
      const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  $ShowPetByIdResponseFallbackCopyWith<ShowPetByIdResponseFallback>
      get copyWith => _$ShowPetByIdResponseFallbackCopyWithImpl<
          ShowPetByIdResponseFallback>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Response<dynamic> response, Pet result) status200,
    required TResult Function(Response<dynamic> response, Error result)
        fallback,
  }) {
    return fallback(response, result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Response<dynamic> response, Pet result)? status200,
    TResult Function(Response<dynamic> response, Error result)? fallback,
  }) {
    return fallback?.call(response, result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Response<dynamic> response, Pet result)? status200,
    TResult Function(Response<dynamic> response, Error result)? fallback,
    required TResult orElse(),
  }) {
    if (fallback != null) {
      return fallback(response, result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowPetByIdResponse200 value) status200,
    required TResult Function(ShowPetByIdResponseFallback value) fallback,
  }) {
    return fallback(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ShowPetByIdResponse200 value)? status200,
    TResult Function(ShowPetByIdResponseFallback value)? fallback,
  }) {
    return fallback?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowPetByIdResponse200 value)? status200,
    TResult Function(ShowPetByIdResponseFallback value)? fallback,
    required TResult orElse(),
  }) {
    if (fallback != null) {
      return fallback(this);
    }
    return orElse();
  }
}

abstract class ShowPetByIdResponseFallback implements ShowPetByIdResponse {
  const factory ShowPetByIdResponseFallback(
      {required Response<dynamic> response,
      required Error result}) = _$ShowPetByIdResponseFallback;

  @override
  Response<dynamic> get response;
  Error get result;
  @override
  @JsonKey(ignore: true)
  $ShowPetByIdResponseFallbackCopyWith<ShowPetByIdResponseFallback>
      get copyWith => throw _privateConstructorUsedError;
}
