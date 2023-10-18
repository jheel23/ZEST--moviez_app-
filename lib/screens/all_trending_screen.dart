import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviez_app/API/tmdb_api.dart';
import 'package:moviez_app/screens/movie_details_screen.dart';
import 'package:moviez_app/widgets/custom/custom_movie_card.dart';

class AllTrendingScreen extends ConsumerStatefulWidget {
  const AllTrendingScreen({super.key});
  static const routeName = '/all-trending';

  @override
  ConsumerState<AllTrendingScreen> createState() => _AllTrendingScreenState();
}

class _AllTrendingScreenState extends ConsumerState<AllTrendingScreen> {
  List<dynamic> _alltrendingMovie = [];
  final ScrollController _scrollController = ScrollController();
  int _count = 3;
//LAZY LOADING
  @override
  void initState() {
    _alltrendingMovie = ref.read(trendingMoviesProvider);
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
          if (_alltrendingMovie.length > _count) {
            _count += 1;
          } else {
            _count = _alltrendingMovie.length;
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
        title:
            const Text('All Trending', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
      ),
      body: CustomMovieCard(
        scrollController: _scrollController,
        list: _alltrendingMovie,
        count: _count,
        routeName: MovieDetailsScreen.routeName,
        identifier: 'trending',
      ),
    );
  }
}
