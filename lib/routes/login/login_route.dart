import 'package:flutter/material.dart' ;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/widgets/littlewords_logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/username.provider.dart';

class LoginRoute extends StatelessWidget {
  LoginRoute({Key? key}) : super(key: key);

  final TextEditingController _txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children  :  [
          Spacer(),

          LittlewordsLogo(),

          Spacer(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8 , vertical: 16),
            child: TextField(
              controller: _txtController,
              decoration: InputDecoration(
                  fillColor: Colors.red,
                  filled: true),
              ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
            child :SaveUsernameButton(
              controller: _txtController,
            ),
          )
        ]),
    );
  }
}

class SaveUsernameButton extends ConsumerWidget {
  const SaveUsernameButton({Key? key,required this.controller }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () => _onPressed(ref),
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(48),
    ),
        child: const Text('Enregistrer Nom'),
    );
  }

  void _onPressed(WidgetRef ref){
    var text = controller.text;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('username', text);
      ref.refresh(usernameProvider);
    });
  }
}