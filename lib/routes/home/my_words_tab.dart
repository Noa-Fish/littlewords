import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/routes/home/my_words.dart';
import 'package:littlewords/routes/home/word_around.dart';

import '../../beans/dto/word.dto.dart';
import '../../providers/my_words_provider.dart';
import '../../providers/words_around.provider.dart';

class MyWordsTab extends ConsumerWidget {
  const MyWordsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(MyWordsProvider)
        .when(data: _whenData, error: _whenError, loading: _whenLoading);
  }
  Widget _whenData(List<WordDTO> words) {

    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        return MyWords(word: words[index]);
      },
    );

  }

  Widget _whenError(Object error, StackTrace? stackTrace) {
    return const Text('Error');
  }

  Widget _whenLoading() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
