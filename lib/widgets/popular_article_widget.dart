import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../blocs/home_bloc.dart';
import '../pages/more_article.dart';
import '../utils/next_screen.dart';
import '../utils/skeleton_loading.dart';


class PopularArticle extends StatefulWidget{
  const PopularArticle({super.key});

  @override
  State<StatefulWidget> createState() {
    return PopularArticleState();
  }
}
class PopularArticleState extends State<PopularArticle>{
  @override
  Widget build(BuildContext context){
    final rb = context.watch<PostProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 24,
                decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          width: 4, color: Colors.deepPurple),
                    )),
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Popular Article".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                  onPressed: () {
                    nextScreen(context, const MoreArticle(title: "Popular Article"));
                  },
                  child: const Row(
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 14,
                      )
                    ],
                  )
              )
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          rb.posts.isEmpty? Column(
            children: [
              SkeletonLoading(height: 110, color: Colors.grey[300]),
              const SizedBox(height: 10,),
              SkeletonLoading(height: 110, color: Colors.grey[300])
            ],
          ) : ListView.separated(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index){
                final post = rb.posts[index];
                return InkWell(
                  onTap: (){
                    navigateToDetailsScreen(context, post, 'popular$index');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Text(
                                post.postTitle,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Html(
                                data: post.postContent,
                                style: {
                                  "body": Style(
                                    margin: Margins.zero,
                                    height: Height(40),
                                    padding: HtmlPaddings.zero,
                                    fontSize: FontSize(14),
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    maxLines: 2,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                  "p,h1,h2,h3,h4,h5,h6": Style(margin: Margins.all(0)),
                                },
                              ),
                              // const SizedBox(
                              //   height: 4,
                              // ),
                              // Row(
                              //   children: [
                              //     const FaIcon(
                              //       FontAwesomeIcons.clock,
                              //       size: 13,
                              //       color: Colors.grey,
                              //     ),
                              //     const SizedBox(width: 6),
                              //     Text(
                              //       DateFormat('dd MMMM yy').format(post.postDate),
                              //       style: const TextStyle(
                              //         fontSize: 13,
                              //         color: Colors.grey,
                              //       ),
                              //     ),
                              //   ],
                              // )
                            ],
                          )),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                          flex: 4,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Hero(
                                tag: 'popular$index',
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(color: Colors.grey[300]),
                                  errorWidget: (context, url, error) => Container(
                                    color: Colors.grey[300],
                                    height: 100,
                                    child: const Icon(Icons.error),
                                  ),
                                  imageUrl: post.postImage,
                                ),
                              )))
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index){
                return Divider(thickness: 1,color: Colors.grey[300],height: 24,);
              },
              itemCount: rb.posts.length
          ),
          const SizedBox(
            height: 14,
          ),
        ],
      ),
    );
  }
}