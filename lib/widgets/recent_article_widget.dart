import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../blocs/home_bloc.dart';
import '../utils/next_screen.dart';

class RecentArticle extends StatefulWidget{
  const RecentArticle({super.key});

  @override
  State<RecentArticle> createState(){
    return RecentArticleState();
  }
}
class RecentArticleState extends State<RecentArticle>{
  @override
  Widget build(BuildContext context){
    final scb = context.watch<PostProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
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
                  "Recent Articles".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          ListView.separated(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (_, int index) {
              if(index < scb.postsRecent.length){
                return InkWell(
                  onTap: (){
                    navigateToDetailsScreen(context, scb.postsRecent[index], 'recent$index');
                  },
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(.2),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                            child: Hero(
                              tag: 'recent$index',
                              child: CachedNetworkImage(
                                  imageUrl: scb.postsRecent[index].postImage,
                                  height: 140,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(color: Colors.grey[300]),
                                  errorWidget: (context, url, error) => Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.error),
                                  ),
                                  alignment: Alignment.center,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, top: 10),
                            child: Row(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.clock,
                                  color: Colors.grey,
                                  size: 13,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  DateFormat('dd MMMM yy').format(scb.postsRecent[index].postDate),
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, top: 2),
                            child: Text(
                              scb.postsRecent[index].postTitle,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, top: 2),
                            child: Text(
                              scb.postsRecent[index].postContent,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateToDetailsScreen(context, scb.postsRecent[index], 'recent$index');
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Read More',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 14,
                                  )
                                ],
                              ))
                        ],
                      )),
                );
              }
              if(scb.isLoading){
                return Opacity(
                    opacity: 1.0,
                    child: const Center(
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: CupertinoActivityIndicator(),
                      ),
                    )
                );
              }
              return Container();
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 12);
            },
            itemCount: scb.postsRecent.length + (scb.isLoading ? 1 : 0),
          ),
        ],
      ),
    );
  }
}