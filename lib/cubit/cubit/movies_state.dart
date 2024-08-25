part of 'movies_cubit.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

final class MoviesNotFoundState extends MoviesState {}

final class MoviesLoadingState extends MoviesState {}

final class MoviesSuccessState extends MoviesState {

}

final class MoviesLoadingFaildState extends MoviesState {
  final String message;

  MoviesLoadingFaildState({required this.message});
}

final class MoviesPaginationLoadingState extends MoviesState {}

final class MoviesPaginationLoadingFaildState extends MoviesState {
  final String message = "there are no more movies";
}


