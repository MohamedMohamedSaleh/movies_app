import 'package:flutter/material.dart';

import 'constants/string.dart';
import 'data/model/movies_data_model.dart';
import 'screens/movie/movie_details.dart';
import 'screens/movie/movies_home.dart';

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
