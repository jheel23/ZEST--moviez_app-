import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TmdbMovies extends StateNotifier<List<dynamic>> {
  TmdbMovies() : super([]);
  List<dynamic> movie = [];
  final String apikey = dotenv.env['API_KEY'] ?? "";
  final readaccessToken = dotenv.env['READ_ACCESS_TOKEN'] ?? "";
  void initState() {
    trendingMovies();
  }

  Map<String, dynamic> findById(int id) {
    return movie.firstWhere((element) => element['id'] == id);
  }

  Future<void> trendingMovies() async {
    try {
      TMDB tmdbWithCustomLogs = TMDB(
        ApiKeys(apikey, readaccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ),
      );
      final response = await tmdbWithCustomLogs.v3.trending
          .getTrending(mediaType: MediaType.all, timeWindow: TimeWindow.week);
      movie = response['results'];
      state = movie;
    } catch (e) {
      rethrow;
    }
  }
}

final trendingMoviesProvider =
    StateNotifierProvider<TmdbMovies, List<dynamic>>((ref) => TmdbMovies());
