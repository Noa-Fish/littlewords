import 'package:flutter/material.dart' ;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/providers/device_location.provider.dart';
import 'package:littlewords/providers/dio.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../beans/dto/word.dto.dart';

class CreateWordModalContent extends StatefulWidget {
  const CreateWordModalContent({Key? key}) : super(key: key);

  @override
  State<CreateWordModalContent> createState() => _CreateWordModalContentState();
}

class _CreateWordModalContentState extends State<CreateWordModalContent> {
  TextEditingController ? txtController;

  @override
  void initState() {
    super.initState();
    txtController = TextEditingController();
    txtController!.addListener(() {
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: txtController,
            scrollPadding: const EdgeInsets.all(20),
            decoration: const InputDecoration(
              hintText: 'Entrez votre mot',
            ),
          ),
          _Btn(txtController: txtController)

        ],
      )
    );
  }

}

class _Btn extends ConsumerWidget {
  const _Btn({Key? key , required this.txtController}) : super(key: key);

  final txtController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ref.watch(deviceLocationProvider).when(data: (data) => _whenData(context, data, ref), error: error, loading: loading);
  }

  Widget _whenData(context, data, ref){
    return ElevatedButton(
      onPressed: _isTextBlank() ? null : () => _sendWordOnServer(ref, context, data),
      child: Text(_isTextBlank() ? 'Écris ton message ' : 'Déposer un message'),
    );
  }

  Widget error(error, stackTrace) {
    return const Text('error');
  }

  Widget loading() {
    return const Text('loading');
  }

  _isTextBlank() {
    return txtController!.text.trim().isEmpty;
  }

  _sendWordOnServer(final WidgetRef ref , BuildContext context, LatLng data) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    final String? author =  username;
    final String content = txtController!.text;
    final double latitude = data.latitude;
    final double longitude = data.longitude;
    var dio = ref.read(dioProvider);
    dio
        .post('/word',data:WordDTO(null,author,content,latitude,longitude))
        .then((value) => Navigator.of(context).pop());
  }
}
