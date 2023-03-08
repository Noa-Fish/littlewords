import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/words_around.provider.dart';

class AppBarTitle extends ConsumerWidget {
  const AppBarTitle({Key? key , required this.title }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return GestureDetector(
      child: Text(title),
      onTap: () {
          ref.refresh(wordsAroundProvider);
        }
    );
  }
}