import 'package:dio/dio.dart';
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
                    leading: const Icon(Icons.delete),
                    title: const Text('Mot supprimer'),
                    onTap: () {
                      // Supprime le mot de la base de données locale
                      DbHelper.delete(word.uid.toString());
                      Navigator.of(context).pop();
                      ref.refresh(MyWordsProvider);
                    },
                  ),
                  _Btn(word: word)
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
    return ListTile(
      leading: const Icon(Icons.send),
      title: const Text('Envoyer au serveur'),
      onTap: () {
        try {
          _sendWordOnServer(ref, context, data);
          DbHelper.delete(word.uid.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Mot envoyé avec succès!'),
            ),
          );
          Navigator.of(context).pop();
          ref.refresh(MyWordsProvider);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erreur lors de l\'envoi du mot!'),
            ),
          );
        }
      },
    );
  }

  Widget error(error, stackTrace) {
    print(error.toString());
    return const Text('error');
  }

  Widget loading() {
    print('loading');
    return const Text('loading');
  }


  _sendWordOnServer(final WidgetRef ref , BuildContext context, LatLng data) async {

    final int uid = word.uid;
    final String? author =  word.author;
    final String content = word.content;
    final double latitude = data.latitude;
    final double longitude = data.longitude;
    print("uid" + uid.toString() + "author" + author.toString() + "content" + content + "latitude" + latitude.toString() + "longitude" + longitude.toString());
    try{
      final dio = ref.read(dioProvider);
      await dio.put('/word/$uid',data:WordDTO(uid,author,content,latitude,longitude));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
  }
}
