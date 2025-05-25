import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state.freezed.dart';

@freezed
abstract class UIState<T> with _$UIState<T> {
  const UIState._();
  const factory UIState.success({required T data}) = UIStateSuccess<T>;
  const factory UIState.empty({
    @Default('Sorry, data is still empty') String message,
  }) = UIStateEmpty<T>;
  const factory UIState.loading() = UIStateLoading<T>;
  const factory UIState.loadingMore(T data) = UIStateLoadingMore<T>;
  const factory UIState.error({
    @Default('Oops, there is a problem, please wait a moment') String message,
    T? data,
  }) = UIStateError<T>;
  const factory UIState.idle() = UIStateIdle<T>;

  bool isLoading() {
    return this is UIStateLoading<T> || this is UIStateLoadingMore<T>;
  }

  bool isLoadingMore() {
    return this is UIStateLoadingMore<T>;
  }

  bool isSuccess() {
    return this is UIStateSuccess<T>;
  }

  bool isEmpty() {
    return this is UIStateEmpty<T>;
  }

  bool isError() {
    return this is UIStateError<T>;
  }

  bool isIdle() {
    return this is UIStateIdle<T>;
  }

  T? dataSuccess() {
    if (this is UIStateSuccess<T>) {
      return (this as UIStateSuccess<T>).data;
    }
    if (this is UIStateLoadingMore<T>) {
      return (this as UIStateLoadingMore<T>).data;
    }
    if (this is UIStateError<T>) {
      return (this as UIStateError<T>).data;
    }
    return null;
  }

  String? messageError() {
    if (this is UIStateError<T>) {
      return (this as UIStateError<T>).message;
    }
    return null;
  }

  String? messageEmpty() {
    if (this is UIStateEmpty<T>) {
      return (this as UIStateEmpty<T>).message;
    }
    return null;
  }
}
