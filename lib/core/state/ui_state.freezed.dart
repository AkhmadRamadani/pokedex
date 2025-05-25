// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UIState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UIState<$T>()';
}


}

/// @nodoc
class $UIStateCopyWith<T,$Res>  {
$UIStateCopyWith(UIState<T> _, $Res Function(UIState<T>) __);
}


/// @nodoc


class UIStateSuccess<T> extends UIState<T> {
  const UIStateSuccess({required this.data}): super._();
  

 final  T data;

/// Create a copy of UIState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateSuccessCopyWith<T, UIStateSuccess<T>> get copyWith => _$UIStateSuccessCopyWithImpl<T, UIStateSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'UIState<$T>.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $UIStateSuccessCopyWith<T,$Res> implements $UIStateCopyWith<T, $Res> {
  factory $UIStateSuccessCopyWith(UIStateSuccess<T> value, $Res Function(UIStateSuccess<T>) _then) = _$UIStateSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$UIStateSuccessCopyWithImpl<T,$Res>
    implements $UIStateSuccessCopyWith<T, $Res> {
  _$UIStateSuccessCopyWithImpl(this._self, this._then);

  final UIStateSuccess<T> _self;
  final $Res Function(UIStateSuccess<T>) _then;

/// Create a copy of UIState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(UIStateSuccess<T>(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class UIStateEmpty<T> extends UIState<T> {
  const UIStateEmpty({this.message = 'Sorry, data is still empty'}): super._();
  

@JsonKey() final  String message;

/// Create a copy of UIState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateEmptyCopyWith<T, UIStateEmpty<T>> get copyWith => _$UIStateEmptyCopyWithImpl<T, UIStateEmpty<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateEmpty<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UIState<$T>.empty(message: $message)';
}


}

/// @nodoc
abstract mixin class $UIStateEmptyCopyWith<T,$Res> implements $UIStateCopyWith<T, $Res> {
  factory $UIStateEmptyCopyWith(UIStateEmpty<T> value, $Res Function(UIStateEmpty<T>) _then) = _$UIStateEmptyCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$UIStateEmptyCopyWithImpl<T,$Res>
    implements $UIStateEmptyCopyWith<T, $Res> {
  _$UIStateEmptyCopyWithImpl(this._self, this._then);

  final UIStateEmpty<T> _self;
  final $Res Function(UIStateEmpty<T>) _then;

/// Create a copy of UIState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(UIStateEmpty<T>(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UIStateLoading<T> extends UIState<T> {
  const UIStateLoading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateLoading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UIState<$T>.loading()';
}


}




/// @nodoc


class UIStateLoadingMore<T> extends UIState<T> {
  const UIStateLoadingMore(this.data): super._();
  

 final  T data;

/// Create a copy of UIState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateLoadingMoreCopyWith<T, UIStateLoadingMore<T>> get copyWith => _$UIStateLoadingMoreCopyWithImpl<T, UIStateLoadingMore<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateLoadingMore<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'UIState<$T>.loadingMore(data: $data)';
}


}

/// @nodoc
abstract mixin class $UIStateLoadingMoreCopyWith<T,$Res> implements $UIStateCopyWith<T, $Res> {
  factory $UIStateLoadingMoreCopyWith(UIStateLoadingMore<T> value, $Res Function(UIStateLoadingMore<T>) _then) = _$UIStateLoadingMoreCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$UIStateLoadingMoreCopyWithImpl<T,$Res>
    implements $UIStateLoadingMoreCopyWith<T, $Res> {
  _$UIStateLoadingMoreCopyWithImpl(this._self, this._then);

  final UIStateLoadingMore<T> _self;
  final $Res Function(UIStateLoadingMore<T>) _then;

/// Create a copy of UIState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(UIStateLoadingMore<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class UIStateError<T> extends UIState<T> {
  const UIStateError({this.message = 'Oops, there is a problem, please wait a moment', this.data}): super._();
  

@JsonKey() final  String message;
 final  T? data;

/// Create a copy of UIState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateErrorCopyWith<T, UIStateError<T>> get copyWith => _$UIStateErrorCopyWithImpl<T, UIStateError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateError<T>&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'UIState<$T>.error(message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $UIStateErrorCopyWith<T,$Res> implements $UIStateCopyWith<T, $Res> {
  factory $UIStateErrorCopyWith(UIStateError<T> value, $Res Function(UIStateError<T>) _then) = _$UIStateErrorCopyWithImpl;
@useResult
$Res call({
 String message, T? data
});




}
/// @nodoc
class _$UIStateErrorCopyWithImpl<T,$Res>
    implements $UIStateErrorCopyWith<T, $Res> {
  _$UIStateErrorCopyWithImpl(this._self, this._then);

  final UIStateError<T> _self;
  final $Res Function(UIStateError<T>) _then;

/// Create a copy of UIState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? data = freezed,}) {
  return _then(UIStateError<T>(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}


}

/// @nodoc


class UIStateIdle<T> extends UIState<T> {
  const UIStateIdle(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateIdle<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UIState<$T>.idle()';
}


}




// dart format on
