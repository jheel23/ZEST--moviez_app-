import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviez_app/API/tmdb_allMovie_api.dart';
import 'package:moviez_app/API/tmdb_api.dart';
import 'package:moviez_app/screens/all_movie_tv_screen.dart';
import 'package:moviez_app/screens/all_trending_screen.dart';
import 'package:moviez_app/screens/movie_details_screen.dart';
import 'package:moviez_app/widgets/all_movies_widget.dart';
import 'package:moviez_app/widgets/all_trending_movie_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TrendingMovieWidget extends ConsumerStatefulWidget {
  const TrendingMovieWidget({super.key});

  @override
  ConsumerState<TrendingMovieWidget> createState() =>
      _TrendingMovieWidgetState();
}

class _TrendingMovieWidgetState extends ConsumerState<TrendingMovieWidget> {
  final PageController pageController = PageController();
  List<dynamic> trendingMovies = [];
  List<dynamic> allMovies = [];
  @override
  void initState() {
    ref.read(trendingMoviesProvider.notifier).trendingMovies();
    ref.read(allMoviesProvider.notifier).allMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(trendingMoviesProvider);
    ref.watch(allMoviesProvider);
    trendingMovies = ref.watch(trendingMoviesProvider);
    allMovies = ref.watch(allMoviesProvider);
    final devicesize = MediaQuery.of(context).size;
    return trendingMovies.isEmpty
        ? SizedBox(
            height: devicesize.height * 0.5,
            child: CupertinoActivityIndicator(
              radius: 15,
              animating: true,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  SizedBox(
                    height: devicesize.height * 0.6,
                    child: PageView.builder(
                        controller: pageController,
                        physics: const ClampingScrollPhysics(),
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  MovieDetailsScreen.routeName,
                                  arguments: {
                                    'id': trendingMovies[index]['id'],
                                    'identifier': 'trending'
                                  });
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: devicesize.width,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/original${trendingMovies[index]['poster_path']}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Colors.black,
                                        Colors.black54
                                      ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter)),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: devicesize.width * 0.7,
                                        child: Text(
                                            trendingMovies[index]['title'] ??
                                                trendingMovies[index]['name'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '⭐ ${trendingMovies[index]['vote_average'].toStringAsFixed(1)} / 10',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: SmoothPageIndicator(
                        controller: pageController,
                        count: 5,
                        effect: ExpandingDotsEffect(
                            dotColor: Colors.grey.shade800,
                            activeDotColor: Colors.green,
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 10)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  headerText('Trending 🔥'),
                  const Spacer(),
                  navigatorButton(AllTrendingScreen.routeName, 'trending'),
                ],
              ),
              AllTrendingMoviesWidget(trendingMovie: trendingMovies),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  headerText('English Movies &\nTV Shows'),
                  const Spacer(),
                  navigatorButton(AllMoviesTvScreen.routeName, 'movie')
                ],
              ),
              AllMoviesWidget(allMovie: allMovies),
            ],
          );
  }

  Align navigatorButton(String routeName, String identifier) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton.icon(
        onPressed: () {
          Navigator.of(context).pushNamed(routeName, arguments: identifier);
        },
        icon: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 12,
        ),
        style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
        label: const Text(
          'View All',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
    );
  }

  Padding headerText(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Text(
        text,
        maxLines: 2,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
