class CharQoutes {
  String? quote;

  CharQoutes.fromJson(Map<String, dynamic> json) {
    quote = json["quote"];
  }
}
