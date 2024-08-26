part of '../movie/movies_home.dart';

class CustomListViewItem extends StatefulWidget {
  final MovieModel model;
  final int index;
  const CustomListViewItem(
      {super.key, required this.model, required this.index});

  @override
  State<CustomListViewItem> createState() => _CustomListViewItemState();
}

class _CustomListViewItemState extends State<CustomListViewItem> {
  double width = 0;
  bool isAnimation = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isAnimation = true;
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, movieDetailsRoute,
            arguments: widget.model);
      },
      child: AnimatedContainer(
        duration: Duration(
            milliseconds: widget.index <= 5 ? 400 + (widget.index * 250) : 300),
        curve: Curves.decelerate,
        transform: Matrix4.translationValues(isAnimation ? 0 : width, 0, 0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 10,
                offset: const Offset(3, 10))
          ],
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Hero(
                tag: widget.model.id,
                child: CachedNetworkImage(
                  height: 130,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                      child: Text(
                    'Loading...',
                    style: TextStyle(color: Colors.grey),
                  )),
                  imageUrl: widget.model.posterPath,
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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Text(
                        widget.model.title,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Text(
                        widget.model.overview,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
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
                          Text(
                            widget.model.voteAverage.toString(),
                          ),
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
