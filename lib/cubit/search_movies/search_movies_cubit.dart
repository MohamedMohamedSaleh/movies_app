import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/movies_data_model.dart';

part 'search_movies_state.dart';

class SearchMoviesCubit extends Cubit<SearchMoviesState> {
  SearchMoviesCubit() : super(SearchMoviesInitial());
  int pageNumber = 1;


  List<MovieModel> searchMoviesList = [];
  Future<void> searchMovies(
      {bool fromPagination = false, required String query}) async {
    if (!fromPagination) {
      emit(SearchMoviesLoading());
    }

    //my key =>  bcf2553429a6cf5dfbbb7427841b8530
    try {
     
        searchMoviesList.clear();
        var response = await Dio().get(
            'https://api.themoviedb.org/3/search/movie?api_key=2001486a0f63e9e4ef9c4da157ef37cd&query=$query');
        var model = MoviesData.fromJson(response.data);
        if (model.results.isNotEmpty) {


          pageNumber++;
          searchMoviesList.addAll(model.results);
        }

        emit(SearchMoviesSuccess());
  
    } on DioException catch (ex) {
      await Future.delayed(const Duration(seconds: 2));

      if (fromPagination) {
      } else {
        await Future.delayed(const Duration(seconds: 1));
        emit(SearchMoviesFailure(message: ex.toString()));
      }
    }
  }
}
