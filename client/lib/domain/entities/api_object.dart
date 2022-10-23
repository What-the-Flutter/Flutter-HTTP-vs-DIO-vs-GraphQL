import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_object.freezed.dart';

part 'api_object.g.dart';

@freezed
class ApiObject with _$ApiObject {
  const factory ApiObject() = _ApiObject;

  factory ApiObject.fromJson(Map<String, Object?> json) => _$ApiObjectFromJson(json);
}
