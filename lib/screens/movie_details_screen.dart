import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviez_app/API/tmdb_allMovie_api.dart';
import 'package:moviez_app/API/tmdb_api.dart';
import 'package:moviez_app/widgets/genre_generator.dart';

class MovieDetailsScreen extends ConsumerStatefulWidget {
  const MovieDetailsScreen({super.key});
  static const routeName = '/movie-details-screen';

  @override
  ConsumerState<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends ConsumerState<MovieDetailsScreen> {
  late Map<String, dynamic> _data;
  Map<String, dynamic> _moviesDetails = {};
  @override
  void didChangeDependencies() {
    _data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _moviesDetails = _data['identifier'] == 'movie'
        ? ref.read(allMoviesProvider.notifier).findById(_data['id'])
        : ref.read(trendingMoviesProvider.notifier).findById(_data['id']);
    super.didChangeDependencies();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(7),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Image.network(
              'https://image.tmdb.org/t/p/original${_moviesDetails['poster_path']}' ??
                  'https://image.tmdb.org/t/p/original${_moviesDetails['backdrop_path']}',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.black54],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: deviceSize.width * 0.8,
                  child: Text(
                    _moviesDetails['title'] ?? _moviesDetails['name'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _moviesDetails['overview'] ?? 'No overview found',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _moviesDetails['release_date'] ?? 'No release date found',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star,
                      color: Theme.of(context).primaryColor,
                    ),
                    const Text('Rating: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        )),
                    Text(
                      '${_moviesDetails['vote_average'].toStringAsFixed(1)}/10' ??
                          'No rating found',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '(${_moviesDetails['vote_count']} votes)' ??
                          'No votes found',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      'Genres: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                        width: deviceSize.width * 0.6,
                        child: genreGenretor(context, _moviesDetails)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
