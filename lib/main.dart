import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vedio/core/my_theme.dart';
import 'package:test_vedio/cubit/themes/my_theme_cubit.dart';
import 'app_routes.dart';
import 'constants/colors.dart';
import 'cubit/cubit/movies_cubit.dart';

void main() {
  runApp(MyApp(
    appRoute: AppRoute(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRoute appRoute;
  const MyApp({super.key, required this.appRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoviesCubit()..getData(),
        ),
        BlocProvider(
          create: (context) => MyThemeCubit(),
        ),
      ],
      child: BlocBuilder<MyThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: MyTheme.lightTheme,
              darkTheme: MyTheme.darkTheme,
              themeMode: state,
              //home: const MovieHome(),
              onGenerateRoute: appRoute.generateRoute,
            );
        },
      ),
    );
  }
}
