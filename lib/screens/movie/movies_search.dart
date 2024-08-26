import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vedio/constants/string.dart';
import 'package:test_vedio/cubit/get_movies/movies_cubit.dart';
import 'package:test_vedio/cubit/search_movies/search_movies_cubit.dart';
import 'package:test_vedio/screens/movie/movies_home.dart';

import '../../cubit/themes/my_theme_cubit.dart';
import '../../data/model/movies_data_model.dart';
import '../widget/custom_loading_gridview.dart';
import '../widget/custom_loading_listview.dart';

class SearchMoviesView extends StatefulWidget {
  const SearchMoviesView({super.key, required this.list});
  final List<MovieModel> list;

  @override
  State<SearchMoviesView> createState() => _SearchMoviesViewState();
}

class _SearchMoviesViewState extends State<SearchMoviesView> {
  bool isSearch = false;
  final controller = TextEditingController();
  late bool isGrid;
  @override
  void initState() {
    isGrid = context.read<MoviesCubit>().isGridView;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchMoviesCubit>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            Navigator.pushReplacementNamed(context, moviesRoute);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, moviesRoute);
                    },
                    child: const Icon(Icons.arrow_back_ios)),
                const SizedBox(
                  width: 8,
                ),
                const Text("Search Now"),
              ],
            ),
            actions: [
              StatefulBuilder(builder: (context, setState) {
                var cubit = context.read<MyThemeCubit>();
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
                    context.read<MoviesCubit>().isGridView = isGrid;
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
          body: SafeArea(
            child: BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: controller,
                        autofocus: true,
                        onChanged: (value) {
                          if (!mounted) return;
                          if (value.isNotEmpty) {
                            isSearch = true;
                            context
                                .read<SearchMoviesCubit>()
                                .searchMovies(query: value);
                            setState(() {});
                          } else {
                            isSearch = false;
                            setState(() {});
                          }
                        },
                        cursorColor:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                        decoration: InputDecoration(
                          hintText: "Search",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          suffixIcon: isSearch
                              ? InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    isSearch = false;
                                    controller.clear();
                                    setState(() {});
                                    // context
                                    //     .read<SearchMoviesCubit>()
                                    //     .searchMovies(query: '');
                                  },
                                  child: const Icon(
                                    Icons.clear_rounded,
                                    color: Colors.red,
                                  ),
                                )
                              : null,
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 20,
                          ),
                          fillColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(11),
                            // borderSide: const BorderSide(width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    !isSearch
                        ? !isGrid
                            ? Expanded(
                                child: ListView.separated(
                                  padding: const EdgeInsets.only(
                                      right: 16, left: 16, bottom: 28, top: 16),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 16,
                                  ),
                                  itemCount: widget.list.length,
                                  itemBuilder: (context, index) =>
                                      CustomListViewItem(
                                    // isSearch: true,
                                    model: widget.list[index],
                                    index: index,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: GridView.builder(
                                  itemCount: widget.list.length,
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
                                        // isSearch: true,
                                        index: index,
                                        model: widget.list[index]);
                                  },
                                ),
                              )
                        : !isGrid
                            ? state is SearchMoviesLoading
                                ? const Expanded(
                                    child: CustomLoadingListView(),
                                  )
                                : cubit.searchMoviesList.isEmpty
                                    ? const Column(
                                        children: [
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Text(
                                            "Not Found Movie!",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      )
                                    : Expanded(
                                        child: ListView.separated(
                                          padding: const EdgeInsets.only(
                                              right: 16,
                                              left: 16,
                                              bottom: 28,
                                              top: 16),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                            height: 16,
                                          ),
                                          itemCount:
                                              cubit.searchMoviesList.length,
                                          itemBuilder: (context, index) =>
                                              CustomListViewItem(
                                            model:
                                                cubit.searchMoviesList[index],
                                            index: index,
                                          ),
                                        ),
                                      )
                            : state is SearchMoviesLoading
                                ? const Expanded(
                                    child: CustomLoadingGridView(),
                                  )
                                : cubit.searchMoviesList.isEmpty
                                    ? const Column(
                                        children: [
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Text(
                                            "Not Found Movie!",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    : Expanded(
                                        child: GridView.builder(
                                          itemCount:
                                              cubit.searchMoviesList.length,
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
                                                model: cubit
                                                    .searchMoviesList[index]);
                                          },
                                        ),
                                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
