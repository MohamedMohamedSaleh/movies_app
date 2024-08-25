import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vedio/cubit/cubit/movies_cubit.dart';
import 'package:test_vedio/cubit/themes/my_theme_cubit.dart';
import 'package:test_vedio/screens/widget/custom_notify_listener.dart';
import '../../constants/colors.dart';
import '../../constants/string.dart';
import '../../data/model/movies_data_model.dart';
import '../widget/bottom_navigation.dart';

part '../widget/item_list.dart';
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
          appBar: AppBar(
            title: const Text(
              "Movies",
            ),
            actions: [
              StatefulBuilder(builder: (context, setState) {
                var cubit = context.read<MyThemeCubit>();
                print(cubit.isDarkMode);
                return CircleAvatar(
                  maxRadius: 18,
                  minRadius: 18,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    onPressed: () {
                      cubit.isDarkMode = !cubit.isDarkMode;
                      context
                          .read<MyThemeCubit>()
                          .toggleTheme(isDark: cubit.isDarkMode);
                      setState(() {});
                    },
                    icon: (cubit.isDarkMode)
                        ? const Icon(
                            Icons.light_mode,
                            size: 20,
                            color: Colors.orangeAccent,
                          )
                        : const Icon(
                            Icons.dark_mode_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                  ),
                );
              }),
              const SizedBox(
                width: 8,
              ),
              CircleAvatar(
                radius: 18,
                child: IconButton(
                  onPressed: () {
                    isGrid = !isGrid;
                    setState(() {});
                  },
                  icon: (isGrid)
                      ? const Icon(
                          Icons.list,
                          size: 21,
                        )
                      : const Icon(
                          Icons.grid_view,
                          size: 20,
                        ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
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
                  : (isGrid)
                      ? notificationListener(
                          GridView.builder(
                            itemCount: cubit.moviesList.length,
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: .62,
                            ),
                            itemBuilder: (context, index) {
                              return CustomGridView(
                                  index: index, model: cubit.moviesList[index]);
                            },
                          ),
                        )
                      : notificationListener(
                          ListView.separated(
                            padding: const EdgeInsets.all(15),
                            itemBuilder: (context, index) => CustomListViewItem(
                                model: cubit.moviesList[index], index: index),
                            separatorBuilder: (context, index) {
                              return const Column(
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                              );
                            },
                            itemCount: cubit.moviesList.length,
                          ),
                        ),
          bottomNavigationBar: bottomNafigationBar(),
        );
      },
    );
  }
}
