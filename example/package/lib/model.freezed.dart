// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Cat _$CatFromJson(Map<String, dynamic> json) {
  return _Cat.fromJson(json);
}

/// @nodoc
class _$CatTearOff {
  const _$CatTearOff();

  _Cat call({required int id, required String name}) {
    return _Cat(
      id: id,
      name: name,
    );
  }

  Cat fromJson(Map<String, Object?> json) {
    return Cat.fromJson(json);
  }
}

/// @nodoc
const $Cat = _$CatTearOff();

/// @nodoc
mixin _$Cat {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CatCopyWith<Cat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatCopyWith<$Res> {
  factory $CatCopyWith(Cat value, $Res Function(Cat) then) =
      _$CatCopyWithImpl<$Res>;
  $Res call({int id, String name});
}

/// @nodoc
class _$CatCopyWithImpl<$Res> implements $CatCopyWith<$Res> {
  _$CatCopyWithImpl(this._value, this._then);

  final Cat _value;
  // ignore: unused_field
  final $Res Function(Cat) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CatCopyWith<$Res> implements $CatCopyWith<$Res> {
  factory _$CatCopyWith(_Cat value, $Res Function(_Cat) then) =
      __$CatCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name});
}

/// @nodoc
class __$CatCopyWithImpl<$Res> extends _$CatCopyWithImpl<$Res>
    implements _$CatCopyWith<$Res> {
  __$CatCopyWithImpl(_Cat _value, $Res Function(_Cat) _then)
      : super(_value, (v) => _then(v as _Cat));

  @override
  _Cat get _value => super._value as _Cat;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_Cat(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Cat implements _Cat {
  const _$_Cat({required this.id, required this.name});

  factory _$_Cat.fromJson(Map<String, dynamic> json) => _$$_CatFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'Cat(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Cat &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$CatCopyWith<_Cat> get copyWith =>
      __$CatCopyWithImpl<_Cat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CatToJson(this);
  }
}

abstract class _Cat implements Cat {
  const factory _Cat({required int id, required String name}) = _$_Cat;

  factory _Cat.fromJson(Map<String, dynamic> json) = _$_Cat.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$CatCopyWith<_Cat> get copyWith => throw _privateConstructorUsedError;
}

Dog _$DogFromJson(Map<String, dynamic> json) {
  return _Dog.fromJson(json);
}

/// @nodoc
class _$DogTearOff {
  const _$DogTearOff();

  _Dog call({required int id, required String name, DogBreed? breed}) {
    return _Dog(
      id: id,
      name: name,
      breed: breed,
    );
  }

  Dog fromJson(Map<String, Object?> json) {
    return Dog.fromJson(json);
  }
}

/// @nodoc
const $Dog = _$DogTearOff();

/// @nodoc
mixin _$Dog {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DogBreed? get breed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DogCopyWith<Dog> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DogCopyWith<$Res> {
  factory $DogCopyWith(Dog value, $Res Function(Dog) then) =
      _$DogCopyWithImpl<$Res>;
  $Res call({int id, String name, DogBreed? breed});
}

/// @nodoc
class _$DogCopyWithImpl<$Res> implements $DogCopyWith<$Res> {
  _$DogCopyWithImpl(this._value, this._then);

  final Dog _value;
  // ignore: unused_field
  final $Res Function(Dog) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? breed = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      breed: breed == freezed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as DogBreed?,
    ));
  }
}

/// @nodoc
abstract class _$DogCopyWith<$Res> implements $DogCopyWith<$Res> {
  factory _$DogCopyWith(_Dog value, $Res Function(_Dog) then) =
      __$DogCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name, DogBreed? breed});
}

/// @nodoc
class __$DogCopyWithImpl<$Res> extends _$DogCopyWithImpl<$Res>
    implements _$DogCopyWith<$Res> {
  __$DogCopyWithImpl(_Dog _value, $Res Function(_Dog) _then)
      : super(_value, (v) => _then(v as _Dog));

  @override
  _Dog get _value => super._value as _Dog;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? breed = freezed,
  }) {
    return _then(_Dog(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      breed: breed == freezed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as DogBreed?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Dog implements _Dog {
  const _$_Dog({required this.id, required this.name, this.breed});

  factory _$_Dog.fromJson(Map<String, dynamic> json) => _$$_DogFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final DogBreed? breed;

  @override
  String toString() {
    return 'Dog(id: $id, name: $name, breed: $breed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Dog &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.breed, breed));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(breed));

  @JsonKey(ignore: true)
  @override
  _$DogCopyWith<_Dog> get copyWith =>
      __$DogCopyWithImpl<_Dog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DogToJson(this);
  }
}

abstract class _Dog implements Dog {
  const factory _Dog({required int id, required String name, DogBreed? breed}) =
      _$_Dog;

  factory _Dog.fromJson(Map<String, dynamic> json) = _$_Dog.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  DogBreed? get breed;
  @override
  @JsonKey(ignore: true)
  _$DogCopyWith<_Dog> get copyWith => throw _privateConstructorUsedError;
}

CatAndDog _$CatAndDogFromJson(Map<String, dynamic> json) {
  return _CatAndDog.fromJson(json);
}

/// @nodoc
class _$CatAndDogTearOff {
  const _$CatAndDogTearOff();

  _CatAndDog call({required int id, required String name, DogBreed? breed}) {
    return _CatAndDog(
      id: id,
      name: name,
      breed: breed,
    );
  }

  CatAndDog fromJson(Map<String, Object?> json) {
    return CatAndDog.fromJson(json);
  }
}

/// @nodoc
const $CatAndDog = _$CatAndDogTearOff();

/// @nodoc
mixin _$CatAndDog {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DogBreed? get breed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CatAndDogCopyWith<CatAndDog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatAndDogCopyWith<$Res> {
  factory $CatAndDogCopyWith(CatAndDog value, $Res Function(CatAndDog) then) =
      _$CatAndDogCopyWithImpl<$Res>;
  $Res call({int id, String name, DogBreed? breed});
}

/// @nodoc
class _$CatAndDogCopyWithImpl<$Res> implements $CatAndDogCopyWith<$Res> {
  _$CatAndDogCopyWithImpl(this._value, this._then);

  final CatAndDog _value;
  // ignore: unused_field
  final $Res Function(CatAndDog) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? breed = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      breed: breed == freezed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as DogBreed?,
    ));
  }
}

/// @nodoc
abstract class _$CatAndDogCopyWith<$Res> implements $CatAndDogCopyWith<$Res> {
  factory _$CatAndDogCopyWith(
          _CatAndDog value, $Res Function(_CatAndDog) then) =
      __$CatAndDogCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name, DogBreed? breed});
}

/// @nodoc
class __$CatAndDogCopyWithImpl<$Res> extends _$CatAndDogCopyWithImpl<$Res>
    implements _$CatAndDogCopyWith<$Res> {
  __$CatAndDogCopyWithImpl(_CatAndDog _value, $Res Function(_CatAndDog) _then)
      : super(_value, (v) => _then(v as _CatAndDog));

  @override
  _CatAndDog get _value => super._value as _CatAndDog;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? breed = freezed,
  }) {
    return _then(_CatAndDog(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      breed: breed == freezed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as DogBreed?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CatAndDog extends _CatAndDog {
  const _$_CatAndDog({required this.id, required this.name, this.breed})
      : super._();

  factory _$_CatAndDog.fromJson(Map<String, dynamic> json) =>
      _$$_CatAndDogFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final DogBreed? breed;

  @override
  String toString() {
    return 'CatAndDog(id: $id, name: $name, breed: $breed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CatAndDog &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.breed, breed));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(breed));

  @JsonKey(ignore: true)
  @override
  _$CatAndDogCopyWith<_CatAndDog> get copyWith =>
      __$CatAndDogCopyWithImpl<_CatAndDog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CatAndDogToJson(this);
  }
}

abstract class _CatAndDog extends CatAndDog {
  const factory _CatAndDog(
      {required int id, required String name, DogBreed? breed}) = _$_CatAndDog;
  const _CatAndDog._() : super._();

  factory _CatAndDog.fromJson(Map<String, dynamic> json) =
      _$_CatAndDog.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  DogBreed? get breed;
  @override
  @JsonKey(ignore: true)
  _$CatAndDogCopyWith<_CatAndDog> get copyWith =>
      throw _privateConstructorUsedError;
}

Error _$ErrorFromJson(Map<String, dynamic> json) {
  return _Error.fromJson(json);
}

/// @nodoc
class _$ErrorTearOff {
  const _$ErrorTearOff();

  _Error call({required int code, required String message}) {
    return _Error(
      code: code,
      message: message,
    );
  }

  Error fromJson(Map<String, Object?> json) {
    return Error.fromJson(json);
  }
}

/// @nodoc
const $Error = _$ErrorTearOff();

/// @nodoc
mixin _$Error {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({int code, String message});
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._value, this._then);

  final Error _value;
  // ignore: unused_field
  final $Res Function(Error) _then;

  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> implements $ErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) =
      __$ErrorCopyWithImpl<$Res>;
  @override
  $Res call({int code, String message});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(_Error _value, $Res Function(_Error) _then)
      : super(_value, (v) => _then(v as _Error));

  @override
  _Error get _value => super._value as _Error;

  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
  }) {
    return _then(_Error(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Error implements _Error {
  const _$_Error({required this.code, required this.message});

  factory _$_Error.fromJson(Map<String, dynamic> json) =>
      _$$_ErrorFromJson(json);

  @override
  final int code;
  @override
  final String message;

  @override
  String toString() {
    return 'Error(code: $code, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Error &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ErrorToJson(this);
  }
}

abstract class _Error implements Error {
  const factory _Error({required int code, required String message}) = _$_Error;

  factory _Error.fromJson(Map<String, dynamic> json) = _$_Error.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}
