import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../blocs/signin_bloc.dart';
import '../utils/empty.dart';
import '../blocs/home_bloc.dart';
import '../utils/next_screen.dart';
import '../utils/skeleton_loading.dart';

class BookmarkList extends StatefulWidget{
  @override
  State<BookmarkList> createState()=> BookmarkListState();
}
class BookmarkListState extends State<BookmarkList>{
  @override
  Widget build(BuildContext context){
    return Container();
    // final sb = context.watch<SignInBloc>();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Bookmark List',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
    //   ),
    //   body: sb.isSignedIn == false
    //       ? const EmptyPage(
    //     icon: FontAwesomeIcons.userPlus,
    //     message: 'sign in first',
    //     message1: "sign in to save your favourite articles here",
    //   )
    //       : Container(
    //     color: Colors.grey[200],
    //     child: FutureBuilder(
    //         future: context.watch<HomeBloc>().getBookmarkArticles(),
    //         builder: (BuildContext context, AsyncSnapshot snapshot){
    //           switch (snapshot.connectionState) {
    //             case ConnectionState.none:
    //             case ConnectionState.active:
    //             case ConnectionState.waiting:
    //               return ListView.builder(
    //                 itemCount: 6,
    //                   itemBuilder: (context, index){
    //                   return Padding(
    //                     padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
    //                     child: SkeletonLoading(height: 150, color: Colors.grey[300])
    //                   );
    //                   }
    //               );
    //             case ConnectionState.done:
    //             default:
    //               if (snapshot.hasError || snapshot.data == null) {
    //                 return const EmptyPage(icon: Icons.bookmark, message: 'No articles found', message1: 'save your favourite articles here');
    //               } else if (snapshot.data.isEmpty) {
    //                 return const EmptyPage(icon: Icons.bookmark, message: 'No articles found', message1: 'save your favourite articles here');
    //               }
    //
    //               return ListView.builder(
    //                 itemBuilder: (BuildContext context, index){
    //                   return InkWell(
    //                     onTap: (){
    //                       navigateToDetailsScreen(context, snapshot.data[index], 'bookmark${snapshot.data[index].timestamp}');
    //                       // Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleDetail(data: snapshot.data[index],tag: 'bookmark${snapshot.data[index].timestamp}',)));
    //                     },
    //                     child: Container(
    //                       margin: const EdgeInsets.only(bottom: 6,top: 6),
    //                       padding: const EdgeInsets.only(left: 14,right: 14,top: 5),
    //                       child: Container(
    //                         decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             boxShadow: [
    //                               BoxShadow(
    //                                   color: Colors.grey.withOpacity(.3),
    //                                   blurRadius: 4,
    //                                   spreadRadius: 1
    //                               )
    //                             ],
    //                             borderRadius: BorderRadius.circular(14)
    //                         ),
    //                         child: Column(
    //                             children: [
    //                               ClipRRect(
    //                                 borderRadius: const BorderRadius.only(
    //                                   topLeft: Radius.circular(14),
    //                                   topRight: Radius.circular(14),
    //                                 ),
    //                                 child: Hero(
    //                                   tag: 'bookmark${snapshot.data[index].timestamp}',
    //                                   child: CachedNetworkImage(
    //                                     imageUrl: snapshot.data[index].thumbnailImagelUrl,
    //                                     fit: BoxFit.cover,
    //                                     width: MediaQuery.of(context).size.width,
    //                                     height: 150,
    //                                     placeholder: (context, url) => Container(color: Colors.grey[300]),
    //                                     errorWidget: (context, url, error) => Container(
    //                                       color: Colors.grey[300],
    //                                       child: const Icon(Icons.error),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                               Container(
    //                                 padding: const EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 12),
    //                                 child: Column(
    //                                   crossAxisAlignment: CrossAxisAlignment.start,
    //                                   children: [
    //                                     Row(
    //                                       children: [
    //                                         const Icon(FontAwesomeIcons.clock,size: 13,color: Colors.grey,),
    //                                         const SizedBox(width: 6,),
    //                                         Text(snapshot.data[index].date,style: const TextStyle(color: Colors.grey,fontSize: 13,
    //                                             fontWeight: FontWeight.w500),)
    //                                       ],
    //                                     ),
    //                                     Text(snapshot.data[index].title,
    //                                       style: const TextStyle(
    //                                           fontSize: 16,
    //                                           fontWeight: FontWeight.w500
    //                                       ),),
    //                                     Text(snapshot.data[index].description,
    //                                       style: TextStyle(
    //                                           fontSize: 13,
    //                                           color: Colors.black.withOpacity(.8)
    //                                       ),overflow: TextOverflow.ellipsis,maxLines: 1,
    //                                     ),
    //                                     const SizedBox(height: 6,),
    //                                     const Row(
    //                                       children: [
    //                                         Text('Read More',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.deepPurple),),
    //                                         Icon(FontAwesomeIcons.angleRight,size: 13,color: Colors.deepPurple,)
    //                                       ],
    //                                     ),
    //                                   ],
    //                                 ),
    //                               )
    //                             ]
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //                 itemCount:snapshot.data.length,);
    //           }
    //         }
    //     ),
    //   ),
    // );
  }
}