import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../blocs/home_bloc.dart';
import '../utils/empty.dart';
import '../utils/next_screen.dart';
import '../utils/skeleton_loading.dart';

class ThirdTab extends StatefulWidget{
  const ThirdTab({super.key});

  @override
  State<ThirdTab> createState() => ThirdTabState();
}
class ThirdTabState extends State<ThirdTab>{
  @override
  void initState() {
    super.initState();
      context.read<PostProvider>().fetchFoodArticle();
  }
  @override
  Widget build(BuildContext context){
    final hd = context.watch<PostProvider>();
    return RefreshIndicator(
      onRefresh: ()async{
        context.read<PostProvider>().onFoodDataRefresh();
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[200],
        child: hd.hasFoodData == false ?
        ListView(
          children: const [
            SizedBox(
              height: 300,
              child: Center(
                child: EmptyPage(icon: Icons.article, message: 'No articles found', message1: ''),
              ),
            ),
          ],
        ):
        ListView.builder(
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index){
            if(hd.foodArticle.length > 0){
              return InkWell(
                onTap: (){
                  navigateToDetailsScreen(context, hd.foodArticle[index], 'third${hd.foodArticle[index]}');
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6,top: 6),
                  padding: const EdgeInsets.only(left: 14,right: 14,top: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.3),
                              blurRadius: 4,
                              spreadRadius: 1
                          )
                        ],
                        borderRadius: BorderRadius.circular(14)
                    ),
                    child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                            ),
                            child: Hero(
                              tag: 'third${hd.foodArticle[index]}',
                              child: CachedNetworkImage(
                                imageUrl: hd.foodArticle[index].postImage,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150,
                                placeholder: (context, url) => Container(color: Colors.grey[300]),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(FontAwesomeIcons.clock,size: 13,color: Colors.grey,),
                                    const SizedBox(width: 6,),
                                    Text(DateFormat('dd MMMM yyy').format(hd.foodArticle[index].postDate),style: const TextStyle(color: Colors.grey,fontSize: 13,
                                        fontWeight: FontWeight.w500),)
                                  ],
                                ),
                                Text(hd.foodArticle[index].postTitle,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                Text(hd.foodArticle[index].postContent,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black.withOpacity(.8)
                                  ),overflow: TextOverflow.ellipsis,maxLines: 1,
                                ),
                                const SizedBox(height: 6,),
                                const Row(
                                  children: [
                                    Text('Read More',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.deepPurple),),
                                    Icon(FontAwesomeIcons.angleRight,size: 13,color: Colors.deepPurple,)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ]
                    ),
                  ),
                ),
              );
            }
            if(hd.isFoodLoading){
              return Opacity(
                  opacity: 1.0,
                  child: hd.foodOffset == 0 ?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                    child: SkeletonLoading(height: 150, color: Colors.grey[300]),
                  ): const Center(
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
          itemCount: hd.foodArticle.length + (hd.isFoodLoading ? 4 : 0),
        ),
      ),
    );
  }
}