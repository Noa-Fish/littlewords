import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littlewords/beans/dto/word.dto.dart';

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
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(word.author ?? "",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                Spacer(),
                Text(word.uid.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,)),
              ],
            ),
          Text(word.content ?? "",style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}