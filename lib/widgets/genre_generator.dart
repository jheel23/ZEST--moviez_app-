import 'package:flutter/material.dart';
import 'package:moviez_app/model/genre_list.dart';

Wrap genreGenretor(BuildContext context, Map<String, dynamic> movieDetails,
    {bool all = false, double size = 15}) {
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    alignment: WrapAlignment.start,
    children: List.generate(
        movieDetails['genre_ids'].length,
        (index) => all
            ? Text(
                '${findGenre(movieDetails['genre_ids'][index])} . ',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size,
                ),
              )
            : Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  findGenre(movieDetails['genre_ids'][index]),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
              )),
  );
}
