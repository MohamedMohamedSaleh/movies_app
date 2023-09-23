import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit/movies_cubit.dart';

Widget notificationListener(Widget listview) {
  return Builder(
    builder: (context) => NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent &&
            notification is ScrollUpdateNotification) {
          MoviesCubit getDat = BlocProvider.of(context);
          getDat.getData(fromPagination: true);
        }
        return true;
      },
      child: listview,
    ),
  );
}
