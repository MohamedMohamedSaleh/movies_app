import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../data/model/movies_data_model.dart';
part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesInitial());
  final List<MovieModel> moviesList = [];
  bool isGridView = false;
  int pageNumber = 1;

  void getData({bool fromPagination = false}) async {

    if (fromPagination) {
      emit(MoviesPaginationLoadingState());
    } else {
      emit(MoviesLoadingState());
    }
    try {

        var response = await Dio().get(
            'https://api.themoviedb.org/3/movie/popular?api_key=bcf2553429a6cf5dfbbb7427841b8530&&page=$pageNumber');
        var model = MoviesData.fromJson(response.data);
        if (model.results.isNotEmpty) {


          pageNumber++;
          moviesList.addAll(model.results);
        }
        emit(MoviesSuccessState());

    } on DioException catch (ex) {
      await Future.delayed(const Duration(seconds: 2));

      if (fromPagination) {
        emit(MoviesPaginationLoadingFaildState());
        await Future.delayed(const Duration(seconds: 2));
        emit(MoviesNotFoundState());
      } else {
        await Future.delayed(const Duration(seconds: 1));
        emit(MoviesLoadingFaildState(message: ex.toString()));
      }
    }
  }
}
