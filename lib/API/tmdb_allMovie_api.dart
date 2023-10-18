// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

class AllMoviesNotifier extends StateNotifier<List<dynamic>> {
  AllMoviesNotifier() : super([]);
  List<dynamic> _allMovie = [];
  final String apikey = '3571895bb749fe1cf693ee4870688dcf';
  final readaccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNTcxODk1YmI3NDlmZTFjZjY5M2VlNDg3MDY4OGRjZiIsInN1YiI6IjY1MjNiZWE0MGNiMzM1MTZmNWM1YjY4YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QNUjlq98Rw_-utZA_l1V8w8-VtyGbFoMAOlaedJtNrw';
  Map<String, dynamic> findById(int id) {
    return _allMovie.firstWhere((element) => element['id'] == id);
  }

  Future<void> allMovies() async {
    try {
      TMDB tmdbWithCustomLogs = TMDB(
        ApiKeys(apikey, readaccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ),
      );
      final response =
          await tmdbWithCustomLogs.v3.tv.getTopRated(language: 'en-US');

      _allMovie = response['results'];
      state = _allMovie;
    } catch (e) {
      rethrow;
    }
  }
}

final allMoviesProvider =
    StateNotifierProvider<AllMoviesNotifier, List<dynamic>>(
        (ref) => AllMoviesNotifier());
