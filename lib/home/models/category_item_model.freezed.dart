// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryItemModel {

 int get id; String get name; String get material; String get pattern; String get type; String get image; int get gsm; int get price_per_unit; int get length; int get stock; String get created_at; List<String> get search_tags; int get category; int get organization_id;
/// Create a copy of CategoryItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryItemModelCopyWith<CategoryItemModel> get copyWith => _$CategoryItemModelCopyWithImpl<CategoryItemModel>(this as CategoryItemModel, _$identity);

  /// Serializes this CategoryItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.material, material) || other.material == material)&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.type, type) || other.type == type)&&(identical(other.image, image) || other.image == image)&&(identical(other.gsm, gsm) || other.gsm == gsm)&&(identical(other.price_per_unit, price_per_unit) || other.price_per_unit == price_per_unit)&&(identical(other.length, length) || other.length == length)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.created_at, created_at) || other.created_at == created_at)&&const DeepCollectionEquality().equals(other.search_tags, search_tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.organization_id, organization_id) || other.organization_id == organization_id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,material,pattern,type,image,gsm,price_per_unit,length,stock,created_at,const DeepCollectionEquality().hash(search_tags),category,organization_id);

@override
String toString() {
  return 'CategoryItemModel(id: $id, name: $name, material: $material, pattern: $pattern, type: $type, image: $image, gsm: $gsm, price_per_unit: $price_per_unit, length: $length, stock: $stock, created_at: $created_at, search_tags: $search_tags, category: $category, organization_id: $organization_id)';
}


}

/// @nodoc
abstract mixin class $CategoryItemModelCopyWith<$Res>  {
  factory $CategoryItemModelCopyWith(CategoryItemModel value, $Res Function(CategoryItemModel) _then) = _$CategoryItemModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String material, String pattern, String type, String image, int gsm, int price_per_unit, int length, int stock, String created_at, List<String> search_tags, int category, int organization_id
});




}
/// @nodoc
class _$CategoryItemModelCopyWithImpl<$Res>
    implements $CategoryItemModelCopyWith<$Res> {
  _$CategoryItemModelCopyWithImpl(this._self, this._then);

  final CategoryItemModel _self;
  final $Res Function(CategoryItemModel) _then;

/// Create a copy of CategoryItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? material = null,Object? pattern = null,Object? type = null,Object? image = null,Object? gsm = null,Object? price_per_unit = null,Object? length = null,Object? stock = null,Object? created_at = null,Object? search_tags = null,Object? category = null,Object? organization_id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,material: null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as String,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,gsm: null == gsm ? _self.gsm : gsm // ignore: cast_nullable_to_non_nullable
as int,price_per_unit: null == price_per_unit ? _self.price_per_unit : price_per_unit // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,created_at: null == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as String,search_tags: null == search_tags ? _self.search_tags : search_tags // ignore: cast_nullable_to_non_nullable
as List<String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int,organization_id: null == organization_id ? _self.organization_id : organization_id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CategoryItemModel implements CategoryItemModel {
  const _CategoryItemModel({this.id = 0, this.name = '', this.material = '', this.pattern = '', this.type = '', this.image = '', this.gsm = 0, this.price_per_unit = 0, this.length = 0, this.stock = 0, this.created_at = '', final  List<String> search_tags = const [], this.category = 0, this.organization_id = 0}): _search_tags = search_tags;
  factory _CategoryItemModel.fromJson(Map<String, dynamic> json) => _$CategoryItemModelFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String material;
@override@JsonKey() final  String pattern;
@override@JsonKey() final  String type;
@override@JsonKey() final  String image;
@override@JsonKey() final  int gsm;
@override@JsonKey() final  int price_per_unit;
@override@JsonKey() final  int length;
@override@JsonKey() final  int stock;
@override@JsonKey() final  String created_at;
 final  List<String> _search_tags;
@override@JsonKey() List<String> get search_tags {
  if (_search_tags is EqualUnmodifiableListView) return _search_tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_search_tags);
}

@override@JsonKey() final  int category;
@override@JsonKey() final  int organization_id;

/// Create a copy of CategoryItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryItemModelCopyWith<_CategoryItemModel> get copyWith => __$CategoryItemModelCopyWithImpl<_CategoryItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.material, material) || other.material == material)&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.type, type) || other.type == type)&&(identical(other.image, image) || other.image == image)&&(identical(other.gsm, gsm) || other.gsm == gsm)&&(identical(other.price_per_unit, price_per_unit) || other.price_per_unit == price_per_unit)&&(identical(other.length, length) || other.length == length)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.created_at, created_at) || other.created_at == created_at)&&const DeepCollectionEquality().equals(other._search_tags, _search_tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.organization_id, organization_id) || other.organization_id == organization_id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,material,pattern,type,image,gsm,price_per_unit,length,stock,created_at,const DeepCollectionEquality().hash(_search_tags),category,organization_id);

@override
String toString() {
  return 'CategoryItemModel(id: $id, name: $name, material: $material, pattern: $pattern, type: $type, image: $image, gsm: $gsm, price_per_unit: $price_per_unit, length: $length, stock: $stock, created_at: $created_at, search_tags: $search_tags, category: $category, organization_id: $organization_id)';
}


}

/// @nodoc
abstract mixin class _$CategoryItemModelCopyWith<$Res> implements $CategoryItemModelCopyWith<$Res> {
  factory _$CategoryItemModelCopyWith(_CategoryItemModel value, $Res Function(_CategoryItemModel) _then) = __$CategoryItemModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String material, String pattern, String type, String image, int gsm, int price_per_unit, int length, int stock, String created_at, List<String> search_tags, int category, int organization_id
});




}
/// @nodoc
class __$CategoryItemModelCopyWithImpl<$Res>
    implements _$CategoryItemModelCopyWith<$Res> {
  __$CategoryItemModelCopyWithImpl(this._self, this._then);

  final _CategoryItemModel _self;
  final $Res Function(_CategoryItemModel) _then;

/// Create a copy of CategoryItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? material = null,Object? pattern = null,Object? type = null,Object? image = null,Object? gsm = null,Object? price_per_unit = null,Object? length = null,Object? stock = null,Object? created_at = null,Object? search_tags = null,Object? category = null,Object? organization_id = null,}) {
  return _then(_CategoryItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,material: null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as String,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,gsm: null == gsm ? _self.gsm : gsm // ignore: cast_nullable_to_non_nullable
as int,price_per_unit: null == price_per_unit ? _self.price_per_unit : price_per_unit // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,created_at: null == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as String,search_tags: null == search_tags ? _self._search_tags : search_tags // ignore: cast_nullable_to_non_nullable
as List<String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int,organization_id: null == organization_id ? _self.organization_id : organization_id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
