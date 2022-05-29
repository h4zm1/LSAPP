class User {
  late int usage;
  late int score;

  User(this.usage, this.score);
  User.fromMap(Map map) {
    usage = map[usage];
    score = map[score];
  }

  Map<String, dynamic> toMap() => {
        "usage": usage,
        "score": score,
      };
}
