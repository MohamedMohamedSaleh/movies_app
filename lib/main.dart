import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vedio/app_routes.dart';
import 'package:test_vedio/constants/colors.dart';
import 'package:test_vedio/cubit/cubit/movies_cubit.dart';



void main() {
  runApp(MyApp(appRoute: AppRoute(),));
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
        ],
        child:MaterialApp(
          
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme:  AppBarTheme(
            backgroundColor: myBlackLight,
            centerTitle: true,
            titleTextStyle: TextStyle(fontSize: 18, color: mywhite),
          ),
         
        ),
        //home: const MovieHome(),
        onGenerateRoute: appRoute.generateRoute,
      ),
    );
  }
}
