// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryItemModel _$CategoryItemModelFromJson(Map<String, dynamic> json) =>
    _CategoryItemModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      material: json['material'] as String? ?? '',
      pattern: json['pattern'] as String? ?? '',
      type: json['type'] as String? ?? '',
      gsm: (json['gsm'] as num?)?.toInt() ?? 0,
      price_per_unit: (json['price_per_unit'] as num?)?.toInt() ?? 0,
      length: (json['length'] as num?)?.toInt() ?? 0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      created_at: json['created_at'] as String? ?? '',
      search_tags:
          (json['search_tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      category: (json['category'] as num?)?.toInt() ?? 0,
      organization_id: (json['organization_id'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CategoryItemModelToJson(_CategoryItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'material': instance.material,
      'pattern': instance.pattern,
      'type': instance.type,
      'gsm': instance.gsm,
      'price_per_unit': instance.price_per_unit,
      'length': instance.length,
      'stock': instance.stock,
      'created_at': instance.created_at,
      'search_tags': instance.search_tags,
      'category': instance.category,
      'organization_id': instance.organization_id,
    };
