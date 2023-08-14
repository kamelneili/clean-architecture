import 'package:beautycentre/core/config/constants.dart';
import 'package:beautycentre/features/post/domain/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../config/size_config.dart';

class ProductInformation extends StatelessWidget {
  final Post product;
  const ProductInformation({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: kEncodeSansSemiBold.copyWith(
                        color: kDarkBrownColor,
                        fontSize: SizeConfig.blockSizeHorizontal! * 7)),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Product Information',
                    style: kEncodeSansRagular.copyWith(color: kBlackColor)),
                SizedBox(height: 5),
                // Text(
                //     'Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet,',
                //     style: kEncodeSansSemiBold),
                const ReadMoreText(
                  'Prepare yourself to swim with the sharks the right info at the right time to the right people, but open door policy big data, but groom the backlog. Ultimate measure of success upstream selling we ve got kpis for that, so this medium needs to be more dynamic. Quick-win make sure to include in your wheelhouse, but Q1, for copy and paste from stack overflow 4-blocker. We need to start advertising on social media highlights even dead cats bounce, yet paddle on both sides. We want to empower the team with the right tools and guidance to uplevel our craft and build better five-year strategic plan, yet code, and innovation is hot right now, and goalposts, but exposing new ways to evolve our design language, nor get six alpha pups in here for a focus group. Thought shower. Out of the loop pre launch, yet design thinking focus on the customer journey',
                  trimLines: 2,
                  trimCollapsedText: ' Read More...',
                  trimExpandedText: ' Show Less',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
    
    //
    
    
    
    
    
   