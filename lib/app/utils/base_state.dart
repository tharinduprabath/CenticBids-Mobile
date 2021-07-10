part of 'base_state_view_model.dart';

@immutable
abstract class PageState extends Equatable {
  const PageState();
}

class PageStateLoading extends PageState {
  const PageStateLoading();

  @override
  List<Object?> get props => [];
}

class PageStateLoaded<T> extends PageState {
  final T? data;

  const PageStateLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class PageStateError extends PageState {
  final String message;

  const PageStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
