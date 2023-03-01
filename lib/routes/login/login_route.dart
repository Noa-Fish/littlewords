import 'package:flutter/material.dart' ;
import 'package:littlewords/widgets/littlewords_logo.dart';

class LoginRoute extends StatelessWidget {
  LoginRoute({Key? key}) : super(key: key);

  final _txtController = TextEditingController();

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
            child: ElevatedButton(
                onPressed: _onPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize:Size.fromHeight(48)
                ),
                child :Text('Enregistrer nom')
            ),
          )
        ]),
    );
  }

  void _onPressed() {
    var text = _txtController.text;
    print('Text: $text');
  }
}
