import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sustain_planet_api_app/blocs/home_bloc.dart';
import '../utils/empty.dart';
import '../utils/next_screen.dart';
import '../utils/skeleton_loading.dart';

class FourthTab extends StatefulWidget{
  const FourthTab({super.key});

  @override
  State<FourthTab> createState() => FourthTabState();
}
class FourthTabState extends State<FourthTab>{
  @override
  void initState() {
    super.initState();
      context.read<PostProvider>().fetchBioArticle();
  }
  @override
  Widget build(BuildContext context){
    final hd = context.watch<PostProvider>();
    return RefreshIndicator(
      onRefresh: ()async{
        context.read<PostProvider>().onBioDataRefresh();
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[200],
        child: hd.hasBioData == false ?
        ListView(
          children: const [
            SizedBox(
                height: 300,
                child: Center(
                  child: EmptyPage(icon: Icons.article, message: 'No articles found', message1: ''),
                )
            ),
          ],
        ) :
        ListView.builder(
            padding: const EdgeInsets.all(0),
          itemBuilder: (context, index){
          if(hd.biodiversityArticle.length != 0){
            return InkWell(
              onTap: (){
                navigateToDetailsScreen(context, hd.biodiversityArticle[index], 'fourth${hd.biodiversityArticle[index]}');
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)
                ),
                margin: const EdgeInsets.only(left: 14,right: 14,top: 7,bottom: 7),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),bottomLeft: Radius.circular(12)),
                          child: Hero(
                            tag: 'fourth${hd.biodiversityArticle[index]}',
                            child: CachedNetworkImage(
                              imageUrl: hd.biodiversityArticle[index].postImage,
                              height: 120,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(color: Colors.grey[300]),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(FontAwesomeIcons.clock,size: 13,color: Colors.grey,),
                                      const SizedBox(width: 4,),
                                      Text(DateFormat('dd MMMM yy').format(hd.biodiversityArticle[index].postDate),
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13
                                        ),)
                                    ],
                                  ),
                                  Text(hd.biodiversityArticle[index].postTitle,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        height: 1.2,
                                        fontWeight: FontWeight.w500
                                    ),overflow: TextOverflow.ellipsis,maxLines: 2,
                                  ),
                                  Text(hd.biodiversityArticle[index].postContent,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(.8)
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ]
                            ),
                          )
                      )
                    ]
                ),
              ),
            );
          }
          if(hd.isBioLoading){
            return Opacity(
                opacity: 1.0,
                child: hd.bioOffset == 0 ?
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
          itemCount: hd.biodiversityArticle.length + (hd.isBioLoading ? 4 : 0),
        ),
      ),
    );
  }
}