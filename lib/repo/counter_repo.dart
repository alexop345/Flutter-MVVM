import 'dart:convert';

import 'package:mvvm_practice/models/counter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterRepo {
  Stream<SharedPreferences> _initSharedPreferences() {
    return Stream.fromFuture(SharedPreferences.getInstance());
  }

  Stream<String?> _getString(String key) {
    return _initSharedPreferences().map((sharedPreferences) {
      return sharedPreferences.getString(key);
    });
  }

  Stream<bool> _setString(String key, String value) {
    return _initSharedPreferences().flatMap((sharedPreferences) {
      return sharedPreferences.setString(key, value).asStream();
    });
  }

  Stream<Counter> setCounter(Counter counter) {
    return _setString('counter', jsonEncode(counter.toJson())).flatMap((value) => Stream.value(counter));
  }

  Stream<Counter> getCounter() {
    return _getString('counter').flatMap((value) => value != null ? Stream.value(Counter.fromJson(jsonDecode(value))) : Stream.value(Counter()));
  }
}