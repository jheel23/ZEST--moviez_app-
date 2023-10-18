import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviez_app/API/tmdb_allMovie_api.dart';
import 'package:moviez_app/screens/movie_details_screen.dart';
import 'package:moviez_app/widgets/custom/custom_movie_card.dart';

class AllMoviesTvScreen extends ConsumerStatefulWidget {
  const AllMoviesTvScreen({super.key});
  static const routeName = '/all-tv-movies';

  @override
  ConsumerState<AllMoviesTvScreen> createState() => _AllMoviesTvScreenState();
}

class _AllMoviesTvScreenState extends ConsumerState<AllMoviesTvScreen> {
  List<dynamic> _allMovieTVshows = [];
  final ScrollController _scrollController = ScrollController();
  int _count = 3;
//LAZY LOADING
  @override
  void initState() {
    _allMovieTVshows = ref.read(allMoviesProvider);
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Loading...'),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 1),
        ));
        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          if (_allMovieTVshows.length > _count) {
            _count += 1;
          } else {
            _count = _allMovieTVshows.length;
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text('All Movie & TV Shows',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
      ),
      body: CustomMovieCard(
        scrollController: _scrollController,
        list: _allMovieTVshows,
        count: _count,
        routeName: MovieDetailsScreen.routeName,
        identifier: 'movie',
      ),
    );
  }
}
