class Counter {
  int value;

  Counter({value}) : value = value ?? 0;

  factory Counter.fromJson(Map<String, dynamic> json) {
    return Counter(value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}
