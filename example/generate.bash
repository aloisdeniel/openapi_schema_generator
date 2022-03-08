dart ../openapi_schema_generator/bin/generate.dart -o ./package/ ./definitions/pets.json
cd package
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs 