import 'package:chat_app/models/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesController {
  static final AppPreferencesController _instance =
      AppPreferencesController._internal();
  late SharedPreferences _sharedPreferences;

  factory AppPreferencesController() {
    return _instance;
  }

  AppPreferencesController._internal();

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required Account account}) async {
    await _sharedPreferences.setBool('logged_in', true);
    await _sharedPreferences.setString('email', account.email);
    await _sharedPreferences.setString('username', account.username);
  }

  Account get account {
    Account account = Account();
    account.username = _sharedPreferences.getString('username') ?? '';
    account.email = _sharedPreferences.getString('email') ?? '';
    return account;
  }

  bool get loggedIn => _sharedPreferences.getBool('logged_in') ?? false;

  Future<bool> logout() async {
    return await _sharedPreferences.clear();
  }
}
