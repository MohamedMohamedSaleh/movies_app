import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

enum MessageType { success, faild }

void showMyAnimatedDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String actionText,
  required Function(bool) negativeButtonAction,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
          scale: Tween<double>(begin: 05, end: 1.0).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: AlertDialog(
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: Text(
                content,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
              actions: [
                TextButton(
                  child: const Text(
                    'cancel',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    negativeButtonAction(false);
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    actionText,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    negativeButtonAction(true);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ));
    },
  );
}

void navigateTo({required Widget toPage, bool dontRemove = true, setState}) {
  Navigator.pushAndRemoveUntil(
    navigatorKey.currentContext!,
    MaterialPageRoute(
      builder: (context) => toPage,
    ),
    (route) => dontRemove,
  ).then((value) {
    setState;
  });
}
