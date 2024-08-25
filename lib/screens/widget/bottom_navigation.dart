import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/cubit/movies_cubit.dart';

Widget bottomNafigationBar() {
  return BlocBuilder<MoviesCubit, MoviesState>(
    buildWhen: (previous, current) =>
        current is MoviesPaginationLoadingState ||
        current is MoviesPaginationLoadingFaildState ||
        current is MoviesSuccessState ||
        current is MoviesNotFoundState,

    builder: (context, state) {
      if (state is MoviesPaginationLoadingState) {
        return safeAreaa(const CircularProgressIndicator());
      } else if (state is MoviesPaginationLoadingFaildState) {
        return safeAreaa(Text(state.message));
      } else {
        return const SizedBox.shrink();
      }
    },
  );
}

Widget safeAreaa(Widget d) {
  return SafeArea(
    child: SizedBox(height: 60, child: Center(child: d)),
  );
}
