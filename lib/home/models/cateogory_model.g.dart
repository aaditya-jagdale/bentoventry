// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cateogory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    _CategoryModel(
      id: (json['id'] as num).toInt(),
      organization: (json['organization'] as num).toInt(),
      items: (json['items'] as num?)?.toInt() ?? null,
      category_name: json['category_name'] as String? ?? '',
      created_at: json['created_at'] as String? ?? '',
      user_id: json['user_id'] as String? ?? '',
    );

Map<String, dynamic> _$CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organization': instance.organization,
      'items': instance.items,
      'category_name': instance.category_name,
      'created_at': instance.created_at,
      'user_id': instance.user_id,
    };
