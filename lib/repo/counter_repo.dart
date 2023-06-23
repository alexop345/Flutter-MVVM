import 'dart:convert';

import 'package:mvvm_practice/models/counter.dart';
import 'package:mvvm_practice/repo/shared_pref_repo.dart';
import 'package:rxdart/rxdart.dart';

class CounterRepo {
  final SharedPrefRepo _sharedPrefRepo = SharedPrefRepo();

  Stream<Counter> setCounter(Counter counter) {
    return _sharedPrefRepo.setString(StorageKey.counter.name, jsonEncode(counter.toJson())).flatMap((value) => Stream.value(counter));
  }

  Stream<Counter> getCounter() {
    return _sharedPrefRepo.getString(StorageKey.counter.name).flatMap((value) => value != null ? Stream.value(Counter.fromJson(jsonDecode(value))) : Stream.value(Counter()));
  }
}
