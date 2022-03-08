import 'package:freezed_annotation/freezed_annotation.dart';
part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Cat with _$Cat {
  const factory Cat({
    required int id,
    required String name,
  }) = _Cat;

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);
}

enum DogBreed {
  @JsonValue('Dingo')
  dingo,
  @JsonValue('Husky')
  husky,
  @JsonValue('Retriever')
  retriever,
  @JsonValue('Shepherd')
  shepherd
}

@freezed
class Dog with _$Dog {
  const factory Dog({
    required int id,
    required String name,
    DogBreed? breed,
  }) = _Dog;

  factory Dog.fromJson(Map<String, dynamic> json) => _$DogFromJson(json);
}

@freezed
class CatAndDog with _$CatAndDog {
  const factory CatAndDog({
    required int id,
    required String name,
    DogBreed? breed,
  }) = _CatAndDog;

  factory CatAndDog.fromJson(Map<String, dynamic> json) =>
      _$CatAndDogFromJson(json);
}

@immutable
class Pet {
  const Pet.cat(Cat value) : _value = value;

  const Pet.dog(Dog value) : _value = value;

  factory Pet.fromJson(Map<String, dynamic> json) {
    switch (json['objectType']) {
      case 'Cat':
        return Pet.cat(Cat.fromJson(json));
      case 'Dog':
        return Pet.dog(Dog.fromJson(json));
      default:
        throw Exception('Invalid or missing discriminator');
    }
  }

  final Object _value;

  Map<String, dynamic> toJson() {
    return {
      'objectType': map(
        cat: (v) => 'Cat',
        dog: (v) => 'Dog',
      ),
      ...map(
        cat: (v) => v.toJson(),
        dog: (v) => v.toJson(),
      ),
    };
  }

  T map<T>({
    required T Function(Cat value) cat,
    required T Function(Dog value) dog,
  }) {
    final value = _value;
    if (value is Cat) return cat(value);
    if (value is Dog) return dog(value);
    throw Exception();
  }

  @override
  int get hashCode => _value.hashCode;
  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Pet &&
            _value == other._value);
  }
}

typedef Pets = List<Pet>;

@freezed
class Error with _$Error {
  const factory Error({
    required int code,
    required String message,
  }) = _Error;

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
}
