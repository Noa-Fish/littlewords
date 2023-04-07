import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/providers/my_words_provider.dart';
import 'package:littlewords/widgets/wordcard.dart';
import '../../beans/dto/word.dto.dart';
import '../../providers/device_location.provider.dart';
import '../../providers/dio.provider.dart';
import '../../widgets/db/db.helper.dart';

class MyWords extends ConsumerWidget {
  const MyWords({Key? key, required this.word}) : super(key: key);

  final WordDTO word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.refresh(MyWordsProvider);
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Supprimer'),
                    onTap: () {
                      // Supprime le mot de la base de données locale
                      DbHelper.delete(word.uid.toString());
                      Navigator.of(context).pop();
                      ref.refresh(MyWordsProvider);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.send),
                    title: Text('Envoyer au serveur'),
                    onTap: () {
                      // Envoie le mot au serveur
                      _Btn(word: word,);
                      ///DbHelper.delete(word.uid.toString());
                      // Affiche une notification en cas de succès
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Mot envoyé avec succès!'),
                        ),
                      );
                      Navigator.of(context).pop();
                      ref.refresh(MyWordsProvider);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: WordCard(word: word),
    );
  }
}


class _Btn extends ConsumerWidget {
  const _Btn({Key? key , required this.word}) : super(key: key);

  final word;

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
    final double latitude = data.latitude;
    final double longitude = data.longitude;
    var dio = ref.read(dioProvider);
    dio
        .post('/word',data:WordDTO(null,author,content,latitude,longitude))
        .then((value) => Navigator.of(context).pop());
    ref.refresh(MyWordsProvider);
  }
}
