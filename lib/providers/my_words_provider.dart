import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/beans/dto/word.dto.dart';
import '../widgets/db/db.helper.dart';

final MyWordsProvider = FutureProvider<List<WordDTO>>((ref) async {
  final response = await DbHelper.findAll();

  for (var i = 0; i < response!.length; i++) {
    if (response[i] == null) {
      return Future.value([]);
    }
    return Future.value(response);
  }
  return Future.value([]);
  }
);
