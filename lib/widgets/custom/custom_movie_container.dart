import 'package:flutter/material.dart';
import 'package:moviez_app/screens/movie_details_screen.dart';

class CustomMovieContainer extends StatelessWidget {
  final String image;
  final String name;
  final int id;
  final String identifier;
  const CustomMovieContainer(
      {Key? key,
      required this.image,
      required this.name,
      required this.id,
      required this.identifier})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(MovieDetailsScreen.routeName,
            arguments: {'id': id, 'identifier': identifier});
      },
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: deviceSize.height * 0.2,
              width: deviceSize.width * 0.5,
              child: Image.network(
                'https://image.tmdb.org/t/p/original$image',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: deviceSize.height * 0.2,
            width: deviceSize.width * 0.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
            ),
          ),
          SizedBox(
            width: deviceSize.width * 0.5,
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
