// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Cat _$$_CatFromJson(Map<String, dynamic> json) => _$_Cat(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_CatToJson(_$_Cat instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$_Dog _$$_DogFromJson(Map<String, dynamic> json) => _$_Dog(
      id: json['id'] as int,
      name: json['name'] as String,
      breed: json['breed'] as String?,
    );

Map<String, dynamic> _$$_DogToJson(_$_Dog instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'breed': instance.breed,
    };

_$_CatAndDog _$$_CatAndDogFromJson(Map<String, dynamic> json) => _$_CatAndDog(
      id: json['id'] as int,
      name: json['name'] as String,
      breed: json['breed'] as String?,
    );

Map<String, dynamic> _$$_CatAndDogToJson(_$_CatAndDog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'breed': instance.breed,
    };

_$_Error _$$_ErrorFromJson(Map<String, dynamic> json) => _$_Error(
      code: json['code'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$_ErrorToJson(_$_Error instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
