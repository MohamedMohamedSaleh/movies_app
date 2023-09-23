import 'package:flutter/material.dart';
import 'package:test_vedio/screens/movie/movie_details.dart';
import 'package:test_vedio/screens/movie/movies_home.dart';

import 'constants/string.dart';
import 'data/model/model.dart';

class AppRoute {
  MaterialPageRoute? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case moviesRoute:
        return MaterialPageRoute(builder: ((context) => const MovieHome()));
      case movieDetailsRoute:
      final model = settings.arguments as MovieModel;
        return MaterialPageRoute(builder: ((context) => MovieDetails(model: model)));
    }
    return null;
  }
}
