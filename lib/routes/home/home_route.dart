import 'package:flutter/material.dart' ;
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/widgets/db/db.helper.dart';
import 'package:littlewords/widgets/wordcard.dart';

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
      _PageA(),
      _PageB(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('LittleWords'),
      ),
      body: bodies[bottomNavigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationIndex,
        onTap: (int index) {
          setState(() {
            bottomNavigationIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'A',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dangerous),
            label: 'B',
          ),
        ],
      ),

        floatingActionButton: bottomNavigationIndex == 0 ? Consumer(
          builder: (context,ref,child){
            return FloatingActionButton(
              onPressed: () {
              },
              child: const Icon(Icons.arrow_back),
            );
          },
        ) : null,
    );
  }
}



class _PageA extends StatelessWidget {
  _PageA({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:WordCard(),

      ),
    );
  }
}



class _PageB extends StatelessWidget {
  _PageB({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future : DbHelper.findAll(),
        builder:(context,snapshot){
          return Placeholder();
        }
      ),
    );
  }
}

