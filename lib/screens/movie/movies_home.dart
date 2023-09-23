import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vedio/cubit/cubit/movies_cubit.dart';
import 'package:test_vedio/screens/widget/notification.dart';
import '../../constants/colors.dart';
import '../../constants/string.dart';
import '../../data/model/model.dart';
import '../widget/bottom_navigation.dart';

part '../widget/item.dart';
part '../widget/item_grid.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({super.key});

  @override
  State<MovieHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
  bool isGrid = false;
  @override
  Widget build(BuildContext context) {
    /*     final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Calculate the aspect ratio based on the screen size
    final aspectRatio = screenWidth / (screenHeight);
    print("$aspectRatio");
     */
    return Scaffold(
      backgroundColor: myBlackDark,
      appBar: AppBar(
        title: const Text(
          "Movies",
        ),
        actions: [
          BlocBuilder<MoviesCubit, MoviesState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    setState(() {
                      isGrid = !isGrid;
                    });
                  },
                  icon: (isGrid)
                      ? const Icon(Icons.list)
                      : const Icon(Icons.grid_view));
            },
          )
        ],
      ),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        buildWhen: (previous, current) =>
            current is! MoviesNotFoundState &&
            current is! MoviesPaginationLoadingState &&
            current is! MoviesPaginationLoadingFaildState,
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MoviesLoadingFaildState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is MoviesSuccessState && isGrid == true) {
            return notificationListener(
              GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: .6,
                ),
                itemBuilder: (context, index) {
                  return _ItemGrid(model: state.list[index]);
                },
              ),
            );
          } else if (state is MoviesSuccessState) {
            return notificationListener(
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
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      bottomNavigationBar: bottomNafigationBar(),
    );
  }
}
