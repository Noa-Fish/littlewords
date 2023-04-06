import 'package:flutter/material.dart' ;
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/beans/dto/word.dto.dart';
import 'package:littlewords/routes/home/appbartitle.dart';
import 'package:littlewords/routes/home/words_around_tab.dart';
import 'package:littlewords/widgets/db/db.helper.dart';
import 'package:littlewords/widgets/wordcard.dart';

import 'create_word_modal_content.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  State<HomeRoute> createState() => _HomeRouteState();

}

class _HomeRouteState extends State<HomeRoute> {

  int bottomNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {

    final bodies = <Widget>[
      const WordsAroundTab(),
      const _PageB(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title : 'LittleWords'),
      ),
      body: bodies[bottomNavigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationIndex,
        onTap: (int index) {
          setState(() {
            bottomNavigationIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'A',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.dangerous),
            label: 'B',
          ),
        ],
      ),

        floatingActionButton: bottomNavigationIndex == 0 ? Consumer(
          builder: (context,ref,child){
            return FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context){
                  return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: CreateWordModalContent()
                  );
                });

              },
              child: const Icon(Icons.add),
            );
          },
        ) : null,
    );
  }
}




class _PageB extends StatelessWidget {
  const _PageB({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future : DbHelper.findAll(),
        builder:(context,snapshot){
          if (!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          final List<WordDTO>? data = snapshot.data;
          if (data == null || data.isEmpty){
            return const Text('Aucun mot ramassé');
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder:(context,index){
              return WordCard(word: data[index]);
            }
          );
        }
      ),
    );
  }
}

