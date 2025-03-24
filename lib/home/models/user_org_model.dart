import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_org_model.freezed.dart';
part 'user_org_model.g.dart';

@freezed
abstract class UserOrgModel with _$UserOrgModel {
  const factory UserOrgModel({
    required int id,
    required String organization_name,
  }) = _UserOrgModel;

  factory UserOrgModel.fromJson(Map<String, dynamic> json) =>
      _$UserOrgModelFromJson(json);

}
