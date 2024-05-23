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

class FifthTab extends StatefulWidget{
  const FifthTab({super.key});

  @override
  State<FifthTab> createState() => FifthTabState();
}
class FifthTabState extends State<FifthTab>{
  @override
  void initState() {
    super.initState();
      context.read<PostProvider>().fetchOceanArticle();
  }
  @override
  Widget build(BuildContext context){
    final hd = context.watch<PostProvider>();
    return RefreshIndicator(
      onRefresh: ()async{
        context.read<PostProvider>().onRefreshOceanData();
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[200],
        child: hd.hasOceanData == false ?
        ListView(
          children: const [
            SizedBox(
                height: 300,
                child: EmptyPage(icon: Icons.article, message: 'No articles found', message1: ''),
            ),
          ],
        ) :
        ListView.builder(
            padding: const EdgeInsets.all(0),
          itemBuilder: (context, index){
          if(hd.oceanArticle.length != 0){
            return InkWell(
              onTap: (){
                navigateToDetailsScreen(context, hd.oceanArticle[index], 'fifth${hd.oceanArticle[index]}');
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: .5,color: Colors.grey.withOpacity(.5)))
                  ),
                  padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                  // margin: EdgeInsets.only(top: 6,bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(hd.oceanArticle[index].postTitle,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 4,),
                            Text(hd.oceanArticle[index].postContent,
                              style: TextStyle(fontSize: 13,color: Colors.black.withOpacity(.9)),
                              overflow: TextOverflow.ellipsis,maxLines: 2,),
                            const SizedBox(height: 6,),
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.clock,size: 15,color: Colors.black.withOpacity(.5)),
                                const SizedBox(width: 6,),
                                Text(DateFormat('dd MMMM yy').format(hd.oceanArticle[index].postDate),
                                  style: TextStyle(
                                      fontSize: 13,color: Colors.black.withOpacity(.5),
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 6,),
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Hero(
                            tag: 'fifth${hd.oceanArticle[index]}',
                            child: CachedNetworkImage(
                              imageUrl: hd.oceanArticle[index].postImage,
                              fit: BoxFit.cover,
                              height: 104,
                              placeholder: (context, url) => Container(color: Colors.grey[300]),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            );
          }
          if(hd.isOceanLoading){
            return Opacity(
                opacity: 1.0,
                child: hd.oceanOffset == 0 ?
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
          itemCount: hd.oceanArticle.length + (hd.isOceanLoading ? 4 : 0),
        ),
      ),
    );
  }
}