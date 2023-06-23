import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepo {
   Stream<SharedPreferences> _initSharedPreferences() {
    return Stream.fromFuture(SharedPreferences.getInstance());
  }

  Stream<String?> getString(String key) {
    return _initSharedPreferences().map((sharedPreferences) {
      return sharedPreferences.getString(key);
    });
  }

  Stream<bool> setString(String key, String value) {
    return _initSharedPreferences().flatMap((sharedPreferences) {
      return sharedPreferences.setString(key, value).asStream();
    });
  }
}

enum StorageKey {
  counter
}