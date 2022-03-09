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

  static bool validateJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') || !(json['id'] is num)) return false;
    if (!json.containsKey('name') || !(json['name'] is String)) return false;
    return true;
  }
}

typedef DogBreed = String;

@freezed
class Dog with _$Dog {
  const factory Dog({
    required int id,
    required String name,
    DogBreed? breed,
  }) = _Dog;

  factory Dog.fromJson(Map<String, dynamic> json) => _$DogFromJson(json);

  static bool validateJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') || !(json['id'] is num)) return false;
    if (!json.containsKey('name') || !(json['name'] is String)) return false;
    return true;
  }
}

@immutable
class CatOrDog {
  const CatOrDog.cat(Cat value) : _value = value;

  const CatOrDog.dog(Dog value) : _value = value;

  factory CatOrDog.fromJson(Map<String, dynamic> json) {
    switch (json['objectType']) {
      case 'Cat':
        return CatOrDog.cat(Cat.fromJson(json));
      case 'Dog':
        return CatOrDog.dog(Dog.fromJson(json));
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

  static bool validateJson(Map<String, dynamic> json) {
    if (!json.containsKey('objectType')) return false;
    if (Cat.validateJson(json)) return true;
    if (Dog.validateJson(json)) return true;
    return false;
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
            other is CatOrDog &&
            _value == other._value);
  }
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

  const CatAndDog._();

  Cat asCat() {
    return Cat(
      id: id,
      name: name,
    );
  }

  Dog asDog() {
    return Dog(
      id: id,
      name: name,
      breed: breed,
    );
  }
}

@immutable
class CatAndOrDog {
  const CatAndOrDog({
    this.cat,
    this.dog,
  }) : assert(cat != null || dog != null);

  factory CatAndOrDog.fromJson(Map<String, dynamic> json) {
    return CatAndOrDog(
      cat: Cat.validateJson(json) ? Cat.fromJson(json) : null,
      dog: Dog.validateJson(json) ? Dog.fromJson(json) : null,
    );
  }

  final Cat? cat;

  final Dog? dog;

  Map<String, dynamic> toJson() {
    return {
      if (cat != null) ...cat!.toJson(),
      if (dog != null) ...dog!.toJson(),
    };
  }

  static bool validateJson(Map<String, dynamic> json) {
    if (Cat.validateJson(json)) return true;
    if (Dog.validateJson(json)) return true;
    return false;
  }

  @override
  int get hashCode => Object.hashAll([cat, dog]);
  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CatAndOrDog &&
            cat == other.cat &&
            dog == other.dog);
  }
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

  static bool validateJson(Map<String, dynamic> json) {
    if (!json.containsKey('objectType')) return false;
    if (Cat.validateJson(json)) return true;
    if (Dog.validateJson(json)) return true;
    return false;
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

  static bool validateJson(Map<String, dynamic> json) {
    if (!json.containsKey('code') || !(json['code'] is num)) return false;
    if (!json.containsKey('message') || !(json['message'] is String))
      return false;
    return true;
  }
}
