part of 'base_state_view_model.dart';

@immutable
abstract class PageState {
  const PageState();
}

class PageStateLoading extends PageState {
  const PageStateLoading();
}

class PageStateLoaded<T> extends PageState {
  final T? data;

  const PageStateLoaded({this.data});
}

class PageStateError extends PageState {
  final String message;

  const PageStateError({required this.message});
}
