import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_vedio/constants/colors.dart';
import 'package:test_vedio/data/model/movies_data_model.dart';

class MovieDetails extends StatelessWidget {
  final MovieModel model;
  const MovieDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlackDark,
      appBar: AppBar(
        title: const Text("Movie Details"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            model.title,
            style: TextStyle(
                fontSize: 21, color: mywhite, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(15),
            child: Hero(
              tag: model.id,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SizedBox(
                      height: 60,
                      child: Center(child: CircularProgressIndicator())),
                  imageUrl: model.posterPath,
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    size: 50,
                    color: Colors.red[700],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: myBlackLight),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.star,
                            color: myYellow,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                "${model.voteAverage}",
                                style: TextStyle(
                                    color: mywhite,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "/10",
                                style: TextStyle(
                                  color: mywhite,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "vote count",
                              style: TextStyle(
                                  color: mywhite,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${model.voteCount}",
                              style: TextStyle(
                                  color: mywhite,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'popularity',
                            style: TextStyle(
                              color: mywhite,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${model.popularity}",
                            style: TextStyle(
                                color: mywhite,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: myBlackLight,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "${model.overview}\nrelease date: ${model.releaseDate}",
                    style: TextStyle(color: mywhite, fontSize: 19),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(

                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SizedBox(
                        height: 60,
                        child: Center(child: CircularProgressIndicator())),
                    imageUrl: model.image,
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      size: 50,
                      color: Colors.red[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
