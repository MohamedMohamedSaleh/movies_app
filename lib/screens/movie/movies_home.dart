import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vedio/core/helper_methods.dart';
import 'package:test_vedio/cubit/get_movies/movies_cubit.dart';
import 'package:test_vedio/cubit/themes/my_theme_cubit.dart';
import 'package:test_vedio/screens/movie/movies_search.dart';
import 'package:test_vedio/screens/widget/custom_loading_gridview.dart';
import 'package:test_vedio/screens/widget/custom_loading_listview.dart';
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
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            showMyAnimatedDialog(
              context,
              title: 'Final Exit',
              content: "Are you sure you want to exit?",
              actionText: "Exit",
              negativeButtonAction: (value) {
                if (value) {
                  SystemNavigator.pop();
                }
              },
            );
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Movies",
              ),
              actions: [
                CircleAvatar(
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SearchMoviesView(
                            list: cubit.moviesList,
                          ),
                        ));
                      },
                      icon: const Icon(Icons.search_rounded)),
                ),
                const SizedBox(
                  width: 8,
                ),
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
                      cubit.isGridView = !cubit.isGridView;
                      setState(() {});
                    },
                    icon: (cubit.isGridView)
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
                ? (cubit.isGridView)
                    ? const CustomLoadingGridView()
                    : const CustomLoadingListView()
                : (state is MoviesLoadingFaildState)
                    ? Center(
                        child: Text(state.message),
                      )
                    : (cubit.isGridView)
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
                                    index: index,
                                    model: cubit.moviesList[index]);
                              },
                            ),
                          )
                        : notificationListener(
                            ListView.separated(
                              padding: const EdgeInsets.all(15),
                              itemBuilder: (context, index) =>
                                  CustomListViewItem(
                                      model: cubit.moviesList[index],
                                      index: index),
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
          ),
        );
      },
    );
  }
}
