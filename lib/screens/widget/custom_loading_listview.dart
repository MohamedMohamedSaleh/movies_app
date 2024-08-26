
import 'package:flutter/material.dart';

class CustomLoadingListView extends StatelessWidget {
  const CustomLoadingListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding:
            const EdgeInsets.only(right: 16, left: 16, bottom: 28, top: 16),
        separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
        itemCount: 20,
        itemBuilder: (context, index) => Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20)),
            ));
  }
}
