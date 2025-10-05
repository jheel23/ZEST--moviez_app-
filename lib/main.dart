import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviez_app/screens/all_movie_tv_screen.dart';
import 'package:moviez_app/screens/all_trending_screen.dart';
import 'package:moviez_app/screens/home_screen.dart';
import 'package:moviez_app/screens/movie_details_screen.dart';
import 'package:moviez_app/theme/theme_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZEST',
      theme: mainTheme,
      home: const HomeScreen(),
      routes: {
        MovieDetailsScreen.routeName: (context) => const MovieDetailsScreen(),
        AllMoviesTvScreen.routeName: (context) => const AllMoviesTvScreen(),
        AllTrendingScreen.routeName: (context) => const AllTrendingScreen(),
      },
    );
  }
}
