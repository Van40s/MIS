class JokeType {
  final String name;

  JokeType(this.name);

  factory JokeType.fromJson(String json) => JokeType(json);
}
