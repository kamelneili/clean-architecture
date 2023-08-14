import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../core/config/constants.dart';
import '../../../domain/entities/post.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 23,
      itemCount: posts.length,
      padding: EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              '/ProductDetails',
              arguments: posts[index],
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Positioned(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        child: Image(
                          height: 124,
                          width: 161,
                          fit: BoxFit.cover,
                          image: NetworkImage(posts[index].imageUrl),
                        )),
                  ),
                  Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                          // onTap: () {},
                          // child: const Image(
                          //   height: 20,
                          //   width: 20,
                          //   image: AssetImage(
                          //       'assets/images/unselected_favourite.png'),
                          // ),
                          ))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text("${posts[index].name}",
                  style: kEncodeSansCondensedThin.copyWith(
                    color: kDarkBrownColor,
                    fontSize: 16,
                  )),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("\$${posts[index].price}",
                      style: kEncodeSansSemiBold.copyWith(
                        color: kBlackColor,
                        fontSize: 12,
                        //SizeConfig.blockSizeHorizontal! * 3.5,
                      )),
                  Row(
                    children: [
                      const Icon(Icons.start, color: kYellowColor, size: 16),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("5.0%",
                          style: kEncodeSansRagular.copyWith(
                            color: kDarkBrownColor,
                            fontSize: 12,
                            //SizeConfig.blockSizeHorizontal! * 3,
                          )),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
