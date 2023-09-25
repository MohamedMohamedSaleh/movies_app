import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vedio/cubit/cubit/movies_cubit.dart';
import 'package:test_vedio/screens/widget/notification.dart';
import '../../constants/colors.dart';
import '../../constants/string.dart';
import '../../data/model/movies_data_model.dart';
import '../widget/bottom_navigation.dart';

part '../widget/item.dart';
part '../widget/item_grid.dart';

class MovieHome extends StatelessWidget {
  const MovieHome({super.key});

  @override
  Widget build(BuildContext context) {
    /*     final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Calculate the aspect ratio based on the screen size
    final aspectRatio = screenWidth / (screenHeight);
    print("$aspectRatio");
     */
    return BlocConsumer<MoviesCubit, MoviesState>(
      buildWhen: (previous, current) =>
          current is! MoviesNotFoundState &&
          current is! MoviesPaginationLoadingState &&
          current is! MoviesPaginationLoadingFaildState,
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        MoviesCubit cubit = BlocProvider.of(context);
        return Scaffold(
          backgroundColor: myBlackDark,
          appBar: AppBar(
            title: const Text(
              "Movies",
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    (cubit.isGrid)
                        ? cubit.convertToList()
                        : cubit.convertToGrid();
                  },
                  icon: (cubit.isGrid)
                      ? const Icon(Icons.list)
                      : const Icon(Icons.grid_view))
            ],
          ),
          body: (state is MoviesLoadingState)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (state is MoviesLoadingFaildState)
                  ? Center(
                      child: Text(state.message),
                    )
                  : (state is MoviesIsGridViewState)
                      ? notificationListener(
                          GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: .6,
                            ),
                            itemBuilder: (context, index) {
                              return _ItemGrid(model: state.list[index]);
                            },
                          ),
                        )
                      : (state is MoviesIsListViewState)
                          ? notificationListener(
                              ListView.separated(
                                padding: const EdgeInsets.all(15),
                                itemBuilder: (context, index) =>
                                    _Item(model: state.list[index]),
                                separatorBuilder: (context, index) {
                                  return const Column(
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  );
                                },
                                itemCount: state.list.length,
                              ),
                            )
                          : const SizedBox(),
          bottomNavigationBar: bottomNafigationBar(),
        );
      },
    );
  }
}
