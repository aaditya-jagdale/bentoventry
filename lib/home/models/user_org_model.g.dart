// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_org_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserOrgModel _$UserOrgModelFromJson(Map<String, dynamic> json) =>
    _UserOrgModel(
      id: (json['id'] as num).toInt(),
      organization_name: json['organization_name'] as String,
    );

Map<String, dynamic> _$UserOrgModelToJson(_UserOrgModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organization_name': instance.organization_name,
    };
