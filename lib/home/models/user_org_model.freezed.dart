// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_org_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserOrgModel {

 int get id; String get organization_name;
/// Create a copy of UserOrgModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserOrgModelCopyWith<UserOrgModel> get copyWith => _$UserOrgModelCopyWithImpl<UserOrgModel>(this as UserOrgModel, _$identity);

  /// Serializes this UserOrgModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserOrgModel&&(identical(other.id, id) || other.id == id)&&(identical(other.organization_name, organization_name) || other.organization_name == organization_name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,organization_name);

@override
String toString() {
  return 'UserOrgModel(id: $id, organization_name: $organization_name)';
}


}

/// @nodoc
abstract mixin class $UserOrgModelCopyWith<$Res>  {
  factory $UserOrgModelCopyWith(UserOrgModel value, $Res Function(UserOrgModel) _then) = _$UserOrgModelCopyWithImpl;
@useResult
$Res call({
 int id, String organization_name
});




}
/// @nodoc
class _$UserOrgModelCopyWithImpl<$Res>
    implements $UserOrgModelCopyWith<$Res> {
  _$UserOrgModelCopyWithImpl(this._self, this._then);

  final UserOrgModel _self;
  final $Res Function(UserOrgModel) _then;

/// Create a copy of UserOrgModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? organization_name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,organization_name: null == organization_name ? _self.organization_name : organization_name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UserOrgModel implements UserOrgModel {
  const _UserOrgModel({required this.id, required this.organization_name});
  factory _UserOrgModel.fromJson(Map<String, dynamic> json) => _$UserOrgModelFromJson(json);

@override final  int id;
@override final  String organization_name;

/// Create a copy of UserOrgModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserOrgModelCopyWith<_UserOrgModel> get copyWith => __$UserOrgModelCopyWithImpl<_UserOrgModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserOrgModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserOrgModel&&(identical(other.id, id) || other.id == id)&&(identical(other.organization_name, organization_name) || other.organization_name == organization_name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,organization_name);

@override
String toString() {
  return 'UserOrgModel(id: $id, organization_name: $organization_name)';
}


}

/// @nodoc
abstract mixin class _$UserOrgModelCopyWith<$Res> implements $UserOrgModelCopyWith<$Res> {
  factory _$UserOrgModelCopyWith(_UserOrgModel value, $Res Function(_UserOrgModel) _then) = __$UserOrgModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String organization_name
});




}
/// @nodoc
class __$UserOrgModelCopyWithImpl<$Res>
    implements _$UserOrgModelCopyWith<$Res> {
  __$UserOrgModelCopyWithImpl(this._self, this._then);

  final _UserOrgModel _self;
  final $Res Function(_UserOrgModel) _then;

/// Create a copy of UserOrgModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? organization_name = null,}) {
  return _then(_UserOrgModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,organization_name: null == organization_name ? _self.organization_name : organization_name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
