import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import '../blocs/home_bloc.dart';
import '../utils/empty.dart';
import '../utils/next_screen.dart';
import '../utils/skeleton_loading.dart';

class SecondTab extends StatefulWidget{
  const SecondTab({super.key});

  @override
  State<SecondTab> createState() => SecondTabState();
}
class SecondTabState extends State<SecondTab>{
  @override
  void initState() {
    super.initState();
      // context.read<PostProvider>().healthArticle.isNotEmpty ? debugPrint('data already loaded'):
      context.read<PostProvider>().fetchHealthArticle();
  }
  @override
  Widget build(BuildContext context){
    final hd = context.watch<PostProvider>();
    return RefreshIndicator(
      onRefresh: ()async {
        context.read<PostProvider>().onHealthDataRefresh();
      },
      child: Container(
        width:MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[200],
        child: hd.hasHealthData == false ?
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
          itemBuilder: (context, index) {
            if(hd.healthArticle.length != 0){
              return InkWell(
                onTap: (){
                  navigateToDetailsScreen(context, hd.healthArticle[index], 'second${hd.healthArticle[index]}');
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 17, right: 17, top: 17, bottom: 17),
                  margin: const EdgeInsets.only(left: 14, right: 14, top: 7, bottom: 7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              hd.healthArticle[index].postTitle,
                              style: const TextStyle(
                                fontSize: 19,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              child: Hero(
                                tag: 'second${hd.healthArticle[index]}',
                                child: CachedNetworkImage(
                                  imageUrl: hd.healthArticle[index].postImage,
                                  fit: BoxFit.cover,
                                  height: 70,
                                  placeholder: (context, url) => Container(color: Colors.grey[300]),
                                  errorWidget: (context, url, error) => Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              hd.healthArticle[index].postContent,
                              style: TextStyle(
                                color: Colors.black.withOpacity(.5),
                                height: 1.5,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            if(hd.isHealthLoading){
              return Opacity(
                  opacity: 1.0,
                  child: hd.healthOffset == 0 ?
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
          itemCount: hd.healthArticle.length + (hd.isHealthLoading ? 4 : 0),
        ),
      ),
    );
  }
}