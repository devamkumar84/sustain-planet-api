import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/article_model.dart';
import '../utils/empty.dart';
import '../utils/next_screen.dart';
import '../utils/skeleton_loading.dart';

// class CategoryDetail extends StatefulWidget{
//   final String? category;
//   final String? categoryImage;
//   final String? tag;
//
//
//   const CategoryDetail({super.key, required this.category, required this.categoryImage, required this.tag});
//
//   @override
//   State<CategoryDetail> createState()=> CategoryDetailState();
// }
// class CategoryDetailState extends State<CategoryDetail>{
//   bool? _hasData;
//   DocumentSnapshot? _lastVisible;
//   late bool _isLoading;
//   ScrollController? controller;
//   bool get isLoading => _isLoading;
//   List<DocumentSnapshot> _snap = [];
//   List<Article> _data = [];
//   @override
//   void initState() {
//     controller = new ScrollController()..addListener(_scrollController);
//     super.initState();
//     _isLoading = true;
//     getData();
//   }
//   onRefresh(){
//     setState(() {
//       _snap.clear();
//       _data.clear();
//       _isLoading = true;
//       _lastVisible = null;
//     });
//     getData();
//   }
//   @override
//   void dispose() {
//     controller!.removeListener(_scrollController);
//     super.dispose();
//   }
//   void _scrollController(){
//     if(!_isLoading){
//       if(controller!.position.pixels == controller!.position.maxScrollExtent){
//         setState(() {
//           _isLoading = true;
//         });
//         getData();
//       }
//     }
//   }
//   Future<Null> getData()async {
//     setState(() {
//       _hasData = true;
//     });
//     QuerySnapshot rawData;
//     if(_lastVisible == null){
//       rawData = await FirebaseFirestore.instance.collection('contents')
//           .where('category', isEqualTo: widget.category).orderBy('timestamp', descending: true)
//           .limit(3).get();
//     }else {
//       rawData = await FirebaseFirestore.instance.collection('contents')
//           .where('category', isEqualTo: widget.category).orderBy('timestamp',descending: true)
//           .startAfter([_lastVisible!['timestamp']]).limit(3).get();
//     }
//     if(rawData.docs.length > 0){
//       _lastVisible = rawData.docs[rawData.docs.length - 1];
//       if(mounted){
//         setState(() {
//           _isLoading = false;
//           _snap.addAll(rawData.docs);
//           _data = _snap.map((e) => Article.fromFirestore(e)).toList();
//         });
//       }
//     }else {
//       if(_lastVisible == null){
//         setState(() {
//           _isLoading = false;
//           _hasData = false;
//           print('no items');
//         });
//       }else {
//         setState(() {
//           _isLoading = false;
//           _hasData = true;
//           print('no more items');
//         });
//       }
//     }
//     return null;
//   }
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: ()async{
//           onRefresh();
//         },
//         child: CustomScrollView(
//           controller: controller,
//           slivers: <Widget>[
//             SliverAppBar(
//               automaticallyImplyLeading: false,
//               backgroundColor: Colors.deepPurple,
//               pinned: true,
//               actions: <Widget>[
//                 IconButton(
//                   icon: const Icon(
//                     Icons.keyboard_arrow_left,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 )
//               ],
//               expandedHeight: MediaQuery.of(context).size.height * 0.20,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: Text(widget.category!),
//                 titlePadding: const EdgeInsets.only(left: 20, bottom: 15, right: 20),
//                 background: Stack(
//                   children: [
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height,
//                       width: MediaQuery.of(context).size.width,
//                       child: Hero(
//                         tag: widget.tag!,
//                         child: CachedNetworkImage(
//                           imageUrl: widget.categoryImage!,
//                           fit: BoxFit.cover,
//                           height: MediaQuery.of(context).size.height,
//                           placeholder: (context, url) => Container(color: Colors.grey[300]),
//                           errorWidget: (context, url, error) => Container(
//                             color: Colors.grey[300],
//                             child: const Icon(Icons.error),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     Container(
//                       height: MediaQuery.of(context).size.height,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                             Color(0x00000000),
//                             Color(0x00000000),
//                             Color(0x00000000),
//                             Color(0xcc000000),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             _hasData == false ?
//             const SliverFillRemaining(
//               child: EmptyPage(icon: FontAwesomeIcons.clipboard, message: 'No articles found', message1: ''),
//             ) :
//             SliverPadding(
//                 padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
//                 sliver: SliverList(
//                   delegate: SliverChildBuilderDelegate((context, index){
//                     if(_data.length > index){
//                       return InkWell(
//                         onTap: (){
//                           navigateToDetailsScreen(context, _data[index], 'cateDetail${_data[index].timestamp}');
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.only(bottom: 6,top: 6),
//                           padding: const EdgeInsets.only(left: 14,right: 14,top: 5),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.withOpacity(.3),
//                                       blurRadius: 4,
//                                       spreadRadius: 1
//                                   )
//                                 ],
//                                 borderRadius: BorderRadius.circular(14)
//                             ),
//                             child: Column(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(14),
//                                       topRight: Radius.circular(14),
//                                     ),
//                                     child: Hero(
//                                       tag: 'cateDetail${_data[index].timestamp}',
//                                       child: CachedNetworkImage(
//                                         imageUrl: _data[index].thumbnailImagelUrl!,
//                                         fit: BoxFit.cover,
//                                         width: double.infinity,
//                                         height: 150,
//                                         placeholder: (context, url) => Container(color: Colors.grey[300]),
//                                         errorWidget: (context, url, error) => Container(
//                                           color: Colors.grey[300],
//                                           child: const Icon(Icons.error),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 12),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             const Icon(FontAwesomeIcons.clock,size: 13,color: Colors.grey,),
//                                             const SizedBox(width: 6,),
//                                             Text(_data[index].date!,style: const TextStyle(color: Colors.grey,fontSize: 13,
//                                                 fontWeight: FontWeight.w500),)
//                                           ],
//                                         ),
//                                         Text(_data[index].title!,
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w500
//                                           ),overflow: TextOverflow.ellipsis,maxLines: 2,),
//                                         Text(_data[index].description!,
//                                           style: TextStyle(
//                                               fontSize: 13,
//                                               color: Colors.black.withOpacity(.8)
//                                           ),overflow: TextOverflow.ellipsis,maxLines: 1,
//                                         ),
//                                         const SizedBox(height: 6,),
//                                         const Row(
//                                           children: [
//                                             Text('Read More',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.deepPurple),),
//                                             Icon(FontAwesomeIcons.angleRight,size: 13,color: Colors.deepPurple,)
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ]
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                     if(_isLoading == true){
//                       if(_lastVisible == null){
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
//                           child: SkeletonLoading(height: 150, color: Colors.grey[300])
//                         );
//                       }else {
//                         return const Center(
//                           child: SizedBox(
//                             width: 32,
//                             height: 32,
//                             child: CupertinoActivityIndicator(),
//                           ),
//                         );
//                       }
//                     }
//                     return Container();
//                   },
//                   childCount: _data.length != 0 ? _data.length + 1 : 5),
//                 ),
//             )
//           ],
//         ),
//       )
//     );
//   }
// }