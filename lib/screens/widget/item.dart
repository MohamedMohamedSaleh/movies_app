part of '../movie/movies_home.dart';


class _Item extends StatelessWidget {
  final MovieModel model;
  const _Item({required this.model});
  
    
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, movieDetailsRoute, arguments: model),
      child: Container(
          
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:  myBlackLight,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Hero(
                tag: model.id,
                child: CachedNetworkImage(
                  height: 180,
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
            Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        model.title,
                        style: TextStyle(fontSize: 20, color: mywhite),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Text(
                        model.overview,
                        style: TextStyle(
                            fontSize: 15,
                            color: mywhite,
                            fontWeight: FontWeight.w400),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                          Text(model.voteAverage.toString(), style: TextStyle(color: mywhite),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
