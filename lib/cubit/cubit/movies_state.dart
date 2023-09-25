part of 'movies_cubit.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

final class MoviesNotFoundState extends MoviesState {}

final class MoviesLoadingState extends MoviesState {}

final class MoviesSuccessState extends MoviesState {
  final List<MovieModel> list;
  MoviesSuccessState({required this.list});
}

final class MoviesLoadingFaildState extends MoviesState {
  final String message;

  MoviesLoadingFaildState({required this.message});
}

final class MoviesPaginationLoadingState extends MoviesState {}

final class MoviesPaginationLoadingFaildState extends MoviesState {
  final String message = "there are no more movies";
}

final class MoviesIsGridViewState extends MoviesState {
  final List<MovieModel> list;
  MoviesIsGridViewState({required this.list});
}

final class MoviesIsListViewState extends MoviesState {
  final List<MovieModel> list;
  MoviesIsListViewState({required this.list});
}
