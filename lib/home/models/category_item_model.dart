import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_item_model.freezed.dart';
part 'category_item_model.g.dart';

@freezed
abstract class CategoryItemModel with _$CategoryItemModel {
  const factory CategoryItemModel({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String material,
    @Default('') String pattern,
    @Default('') String type,
    @Default(0) int gsm,
    @Default(0) int price_per_unit,
    @Default('') String created_at,
    @Default([]) List<String> search_tags,
    @Default(0) int category,
    @Default(0) int organization_id,
  }) = _CategoryItemModel;

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemModelFromJson(json);
}
