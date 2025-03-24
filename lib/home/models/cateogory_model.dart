import 'package:freezed_annotation/freezed_annotation.dart';

part 'cateogory_model.freezed.dart';
part 'cateogory_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required int id,
    required int organization,
    @Default(null) int? items,
    @Default('') String category_name,
    @Default('') String created_at,
    @Default('') String user_id,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

}
