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
            //print si le mot est deja dans la base de donnee locale,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              title: const Text('Confirmation'),
                              content: const Text(
                                  'Voulez-vous vraiment supprimer ce mot?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Non'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    DbHelper.delete(word.uid.toString());
                                  },
                                  child: const Text('Oui'),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ],
              ),
           ],
        ),
      ),
    );
  }
}

class _Btn extends ConsumerWidget {
  const _Btn({Key? key , required this.word}) : super(key: key);

  final word ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ref.watch(deviceLocationProvider).when(data: (data) => _whenData(context, data, ref), error: error, loading: loading);
  }

  Widget _whenData(context, data, ref){
    return _sendWordOnServer(ref, context, data);
  }

  Widget error(error, stackTrace) {
    return const Text('error');
  }

  Widget loading() {
    return const Text('loading');
  }

  _sendWordOnServer(final WidgetRef ref , BuildContext context, LatLng data) async {
    final String? author =  word.author;
    final String content = word.content;
    final double latitude =  data.latitude;
    final double longitude = data.longitude;
    var dio = ref.read(dioProvider);
    dio
        .post('/word',data:WordDTO(word.uid ,author,content,latitude,longitude))
        .then((value) => Navigator.of(context).pop())
        .catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: Text('Erreur lors du jet du mot : $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    });
    ref.refresh(wordsAroundProvider);
  }

}
