class Joke {
  final String setup;
  final String punchline;
  
  bool isFavorite = false;


  Joke({required this.setup, required this.punchline});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json['setup'],
      punchline: json['punchline'],
    );
  }
}
