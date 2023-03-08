import 'package:flutter/material.dart';
import 'package:littlewords/widgets/db/db.helper.dart';

import 'app.dart';

void main() {

  //Initialize the database
  WidgetsFlutterBinding.ensureInitialized();
  DbHelper.initDb();

  runApp(const LittleWordsApp());
}

