//Doit aller chercher le username dans le shared prefs
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final usernameProvider = FutureProvider<String?>((ref) async {
  final SharedPreferences prefs = await  SharedPreferences.getInstance();
  final key = 'username';
  final String? username = prefs.getString(key);
  return username;
});