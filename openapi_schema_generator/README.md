# openapi_schema_generator

An opiniated generator for [OpenAPI](https://swagger.io/) definitions.

It only works for a subset of definitions and aims to make generated code more human readable by using [freezed package](https://pub.dev/packages/freezed) for modeling data.

## Install

```bash
> dart pub global activate openapi_schema_generator
```

## Usage

```bash
> dart pub global run openapi_schema_generator:generate -o ./package/ ./definitions/pets.json
```

For generating models :

```bash
cd package
flutter pub get
flutter pub run build_runner build
```

## Definition rules

* All schemas must be defined in `components.schema` and referenced from child objects and routes.
* Route parameters must be of basic types (`string`, `integer`, `number`).

## FAQ

> Why don`t you simply use the official OpenAPI generator ?

The OpenAPI official generator supports dart language, but the generated code seems over complicated in my opinion. It also generates mutable objects which makes object instantiation less simple that a simply constructor/copyWith combination. 

And the other reason is that `oneOf` [isn't supported yet for Dart](https://github.com/OpenAPITools/openapi-generator/issues/3884).

> What do you mean by "opiniated"?

The supported definition subset is only designed to support my own needs. So there are specific rules that may not fit the way you write your OpenAPI definitions, but this limitations allow me to simplify the maintenance since I work on it alone, on my spare time. 

> Where can I find an example supported definition and generated code ?

You have [one in the repository](example/).