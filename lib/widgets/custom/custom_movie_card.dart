import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moviez_app/screens/movie_details_screen.dart';
import 'package:moviez_app/widgets/genre_generator.dart';

class CustomMovieCard extends StatelessWidget {
  final ScrollController? scrollController;
  final List<dynamic> list;
  final int count;
  final String routeName;
  final String identifier;
  const CustomMovieCard(
      {Key? key,
      required this.scrollController,
      required this.list,
      required this.count,
      required this.routeName,
      required this.identifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
        controller: scrollController,
        itemCount: count,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(MovieDetailsScreen.routeName,
                  arguments: {
                    'id': list[index]['id'],
                    'identifier': identifier
                  });
            },
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(10),
                height: deviceSize.height * 0.5,
                width: deviceSize.width * 0.9,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: deviceSize.height * 0.5,
                      width: deviceSize.width * 0.9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/original${list[index]['poster_path']}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: SizedBox(
                              height: deviceSize.height * 0.2,
                              width: deviceSize.width * 0.9,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                          Colors.black26,
                                          Colors.black26
                                        ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FittedBox(
                                      child: SizedBox(
                                        width: deviceSize.width * 0.7,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: deviceSize.width * 0.6,
                                              child: Text(
                                                list[index]['title'] ??
                                                    list[index]['name'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            genreGenretor(context, list[index],
                                                all: true),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                'Origin Country: ${list[index]['origin_country'] ?? 'N/A'}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -30,
                          right: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                height: 90,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(children: [
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.3),
                                    child: Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${list[index]['vote_average'].toStringAsFixed(1)}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
