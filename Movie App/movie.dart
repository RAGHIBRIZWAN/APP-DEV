import 'package:flutter/cupertino.dart';

class Movie {
  late final String title;
  late final String backDropPath;

  Movie({
    required this.title,
    required this.backDropPath,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      backDropPath: map['backdrop_path'], // Corrected 'backDropPath' to 'backdrop_path'
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backdrop_path': backDropPath, // Corrected 'backDropPath' to 'backdrop_path'
    };
  }
}
