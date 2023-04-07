import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/beans/dto/word.dto.dart';
import 'package:littlewords/beans/dto/words.dto.dart';
import 'package:littlewords/providers/device_location.provider.dart';
import 'package:littlewords/providers/dio.provider.dart';

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
