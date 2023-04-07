import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/beans/dto/word.dto.dart';

import '../providers/device_location.provider.dart';
import '../providers/dio.provider.dart';
import '../providers/words_around.provider.dart';
import 'db/db.helper.dart';

class WordCard extends StatelessWidget {
  const WordCard({Key? key, required this.word}) : super(key: key);

  final WordDTO word;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(word.author ?? "", style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
                const Spacer(),
                Text(word.uid.toString(), style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14,)),
              ],
            ),
            const SizedBox(height: 10),
            Text(word.content ?? "", style: const TextStyle(fontSize: 20),),
            const SizedBox(height: 10),
            //si le mot est deja dans la base de donnee locale,
            //print si le mot est deja dans la base de donnee locale
           ],
        ),
      ),
    );
  }
}
