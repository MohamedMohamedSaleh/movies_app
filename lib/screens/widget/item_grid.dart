part of '../movie/movies_home.dart';

class CustomGridView extends StatefulWidget {
  final MovieModel model;
  final int index;
  const CustomGridView({super.key, required this.model, required this.index});

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  double width = 0;
  bool isAnimation = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isAnimation = true;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, movieDetailsRoute,
          arguments: widget.model),
      child: AnimatedContainer(
        duration: Duration(
            milliseconds: widget.index <= 5 ? 400 + (widget.index * 250) : 300),
        curve: Curves.decelerate,
        transform: Matrix4.translationValues(isAnimation ? 0 : -width, 0, 100),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 10,
                offset: const Offset(3, 10))
          ],
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Hero(
                tag: widget.model.id,
                child: CachedNetworkImage(
                  height: 100,
                  width: double.infinity,
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.model.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Text(
                widget.model.overview,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // const SizedBox(
            //   height: 17,
            // ),
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
            ),
          ],
        ),
      ),
    );
  }
}
