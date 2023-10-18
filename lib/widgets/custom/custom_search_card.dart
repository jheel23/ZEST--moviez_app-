import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moviez_app/widgets/genre_generator.dart';

class CustomSearchCard extends StatelessWidget {
  final Map<String, dynamic> movie;
  const CustomSearchCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      height: deviceSize.height * 0.1,
      width: deviceSize.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/original${movie['backdrop_path']}' ??
                      'https://picsum.photos/200/300'),
              fit: BoxFit.fill,
              opacity: 0.8,
              filterQuality: FilterQuality.high)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Row(
            children: [
              SizedBox(
                  height: deviceSize.height * 0.2,
                  width: deviceSize.width * 0.2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original${movie['poster_path']}' ??
                          'https://picsum.photos/200/300',
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(
                height: deviceSize.height * 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: deviceSize.width * 0.7,
                        child: Text(
                          movie['original_title'] ?? 'No Title',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Realease Date: ${movie['release_date']}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      FittedBox(
                        child: SizedBox(
                            width: deviceSize.width * 0.7,
                            child: genreGenretor(context, movie,
                                all: true, size: 10)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
