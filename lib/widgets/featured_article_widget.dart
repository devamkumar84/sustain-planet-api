import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../blocs/home_bloc.dart';
import '../utils/next_screen.dart';
import '../utils/skeleton_loading.dart';



class FeaturedArticle extends StatefulWidget{
  const FeaturedArticle({super.key});

  @override
  State<StatefulWidget> createState() {
    return FeaturedFeaturedArticleState();
  }
}
class FeaturedFeaturedArticleState extends State<FeaturedArticle>{
  int _currentArrow = 0;
  @override
  Widget build(BuildContext context){
    final fb = context.watch<PostProvider>();
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              viewportFraction: .75,
              height: 190,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration:
              const Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentArrow = index;
                });
              }),
          items: fb.posts.isEmpty
              ? [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SkeletonLoading(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.grey[300])
            )
          ]
              : fb.posts.take(6).map((e) {
            return InkWell(
              onTap: (){
                navigateToDetailsScreen(context, e, null);
                },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: e.postImage,
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                        height: 190,
                        width: MediaQuery.of(context).size.width,
                        placeholder: (context, url) => Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.55),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Positioned(
                      left: 8,
                      right: 8,
                      top: 8,
                      child: Text(
                        e.postTitle,
                        style: const TextStyle(
                            fontSize: 22,
                            height: 1.15,
                            color: Colors.white,
                            fontFamily: "logo"),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Positioned(
                        left: 8,
                        right: 8,
                        bottom: 6,
                        child: Html(
                          data: e.postContent,
                          style: {
                            "body": Style(
                              margin: Margins.zero,
                              height: Height(76),
                              padding: HtmlPaddings.zero,
                              fontSize: FontSize(14),
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              maxLines: 3,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          },
                        ),
                        // Text(
                        //   e.postContent,
                        //   style: const TextStyle(
                        //       fontSize: 14,
                        //       color: Colors.white,
                        //       height: 1.2),
                        //   overflow: TextOverflow.ellipsis,
                        //   maxLines: 3,
                        // )
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: fb.posts.asMap().entries.take(6).map((e) {
            return GestureDetector(
              child: Container(
                width: 7,
                height: 7,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: _currentArrow == e.key
                      ? Colors.deepPurple
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }
}