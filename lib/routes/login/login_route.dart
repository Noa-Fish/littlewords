import 'package:flutter/material.dart' ;
import 'package:littlewords/widgets/littlewords_logo.dart';

class LoginRoute extends StatelessWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children  : const [
          Spacer(),

          LittlewordsLogo(),

          Spacer(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              decoration: InputDecoration(
                  fillColor: Colors.red,
                  filled: true),
              ),
          ),
          ElevatedButton(
              onPressed: null,
              child: Text('Enregiistrer nom'))
        ]),
    );
  }
}
