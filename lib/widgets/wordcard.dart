import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  const WordCard({Key? key}) : super(key: key);

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
                Text("Maman",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                Spacer(),
                Text("01/03/2023",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,)),
              ],
            ),
          Text("Je t'\aime mon fils",style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}