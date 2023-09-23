part of '../movie/movies_home.dart';

class _ItemGrid extends StatelessWidget {
  final MovieModel model;
  const _ItemGrid({required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, movieDetailsRoute, arguments: model),
      child: Container(
       
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: myBlackLight,
        ),
        child: Column(
          children: [
            CachedNetworkImage(
            //   height: 180,
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                model.title,
                style: TextStyle(fontSize: 20, color: mywhite),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                model.overview,
                style: TextStyle(
                    fontSize: 15,
                    color: mywhite,
                    fontWeight: FontWeight.w400),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: myYellow,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  model.voteAverage.toString(),
                  style: TextStyle(color: mywhite),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
