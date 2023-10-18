import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviez_app/screens/search_screen.dart';
import 'package:moviez_app/widgets/core/trending_movie_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      maintainBottomViewPadding: true,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Z E S T',
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.w900, fontSize: 30),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 18,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const SearchScreen()));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 18,
              ),
            )
          ],
        ),
        body: const CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: TrendingMovieWidget(),
              ),
            ]),
      ),
    );
  }
}
