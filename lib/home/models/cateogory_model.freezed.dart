// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cateogory_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryModel {

 int get id; int get organization; int? get items; String get category_name; String get created_at; String get user_id;
/// Create a copy of CategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryModelCopyWith<CategoryModel> get copyWith => _$CategoryModelCopyWithImpl<CategoryModel>(this as CategoryModel, _$identity);

  /// Serializes this CategoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.items, items) || other.items == items)&&(identical(other.category_name, category_name) || other.category_name == category_name)&&(identical(other.created_at, created_at) || other.created_at == created_at)&&(identical(other.user_id, user_id) || other.user_id == user_id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,organization,items,category_name,created_at,user_id);

@override
String toString() {
  return 'CategoryModel(id: $id, organization: $organization, items: $items, category_name: $category_name, created_at: $created_at, user_id: $user_id)';
}


}

/// @nodoc
abstract mixin class $CategoryModelCopyWith<$Res>  {
  factory $CategoryModelCopyWith(CategoryModel value, $Res Function(CategoryModel) _then) = _$CategoryModelCopyWithImpl;
@useResult
$Res call({
 int id, int organization, int? items, String category_name, String created_at, String user_id
});




}
/// @nodoc
class _$CategoryModelCopyWithImpl<$Res>
    implements $CategoryModelCopyWith<$Res> {
  _$CategoryModelCopyWithImpl(this._self, this._then);

  final CategoryModel _self;
  final $Res Function(CategoryModel) _then;

/// Create a copy of CategoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? organization = null,Object? items = freezed,Object? category_name = null,Object? created_at = null,Object? user_id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as int,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as int?,category_name: null == category_name ? _self.category_name : category_name // ignore: cast_nullable_to_non_nullable
as String,created_at: null == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as String,user_id: null == user_id ? _self.user_id : user_id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CategoryModel implements CategoryModel {
  const _CategoryModel({required this.id, required this.organization, this.items = null, this.category_name = '', this.created_at = '', this.user_id = ''});
  factory _CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

@override final  int id;
@override final  int organization;
@override@JsonKey() final  int? items;
@override@JsonKey() final  String category_name;
@override@JsonKey() final  String created_at;
@override@JsonKey() final  String user_id;

/// Create a copy of CategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryModelCopyWith<_CategoryModel> get copyWith => __$CategoryModelCopyWithImpl<_CategoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.items, items) || other.items == items)&&(identical(other.category_name, category_name) || other.category_name == category_name)&&(identical(other.created_at, created_at) || other.created_at == created_at)&&(identical(other.user_id, user_id) || other.user_id == user_id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,organization,items,category_name,created_at,user_id);

@override
String toString() {
  return 'CategoryModel(id: $id, organization: $organization, items: $items, category_name: $category_name, created_at: $created_at, user_id: $user_id)';
}


}

/// @nodoc
abstract mixin class _$CategoryModelCopyWith<$Res> implements $CategoryModelCopyWith<$Res> {
  factory _$CategoryModelCopyWith(_CategoryModel value, $Res Function(_CategoryModel) _then) = __$CategoryModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int organization, int? items, String category_name, String created_at, String user_id
});




}
/// @nodoc
class __$CategoryModelCopyWithImpl<$Res>
    implements _$CategoryModelCopyWith<$Res> {
  __$CategoryModelCopyWithImpl(this._self, this._then);

  final _CategoryModel _self;
  final $Res Function(_CategoryModel) _then;

/// Create a copy of CategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? organization = null,Object? items = freezed,Object? category_name = null,Object? created_at = null,Object? user_id = null,}) {
  return _then(_CategoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as int,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as int?,category_name: null == category_name ? _self.category_name : category_name // ignore: cast_nullable_to_non_nullable
as String,created_at: null == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as String,user_id: null == user_id ? _self.user_id : user_id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
