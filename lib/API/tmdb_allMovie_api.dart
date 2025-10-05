// ignore_for_file: file_names

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

class AllMoviesNotifier extends StateNotifier<List<dynamic>> {
  AllMoviesNotifier() : super([]);
  List<dynamic> _allMovie = [];
  final String apikey = dotenv.env['API_KEY'] ?? "";
  final readaccessToken = dotenv.env['READ_ACCESS_TOKEN'] ?? "";
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
