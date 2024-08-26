part of 'search_movies_cubit.dart';

@immutable
sealed class SearchMoviesState {}

final class SearchMoviesInitial extends SearchMoviesState {}

final class SearchMoviesLoading extends SearchMoviesState {}

final class SearchMoviesSuccess extends SearchMoviesState {}

final class SearchMoviesFailure extends SearchMoviesState {
  final String message;

  SearchMoviesFailure({required this.message});
}

final class SearchPaginationLoadingState extends SearchMoviesState {}