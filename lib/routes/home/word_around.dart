import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/beans/dto/one_word.dto.dart';
import 'package:littlewords/widgets/wordcard.dart';

import '../../beans/dto/word.dto.dart';
import '../../providers/dio.provider.dart';
import '../../providers/words_around.provider.dart';
import '../../widgets/db/db.helper.dart';

class WordAround extends ConsumerWidget {
  const WordAround({Key? key ,required this.word}) : super(key: key);

  final WordDTO word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return GestureDetector(
      onTap: () {
        final Dio dio = ref.read(dioProvider);
        var url = '/word?uid=${word.uid}&latitude=${word.latitude}&longitude=${word.longitude}';

        dio.get(url).then((response) {
          var jsonAsString = response.toString();
          var json = jsonDecode(jsonAsString);

          final OneWordDTO oneWordDTO = OneWordDTO.fromJson(json);

          if (oneWordDTO.data != null) {
            DbHelper.insert(oneWordDTO.data!);
            SnackBar snackBar = const SnackBar(content: Text('Mot ajouté'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          else{
            SnackBar snackBar = const SnackBar(content: Text('Mot déjà ramassé'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          ref.refresh(wordsAroundProvider);
        });
      },
      child: WordCard(word: word),
    );
  }
}