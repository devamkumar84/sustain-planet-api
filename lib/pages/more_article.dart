import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';
import '../utils/next_screen.dart';
import '../utils/skeleton_loading.dart';
import '../widgets/html_body.dart';

class MoreArticle extends StatefulWidget{
  final String title;

  const MoreArticle({super.key, required this.title});
  @override
  State<MoreArticle> createState()=> MoreArticleState();
}
class MoreArticleState extends State<MoreArticle>{
  // DocumentSnapshot? _lastVisible;
  // bool _isLoading = false;
  // final List<DocumentSnapshot> _snap = [];
  // List<Article> data = [];
  // ScrollController? controller;
  // bool get isLoading => _isLoading;
  // Future<Null> getData()async {
  //   QuerySnapshot rawData;
  //   if(_lastVisible == null){
  //     rawData = await FirebaseFirestore.instance.collection('contents')
  //         .orderBy('loves',descending: true).limit(4).get();
  //   }else {
  //     rawData = await FirebaseFirestore.instance.collection('contents')
  //         .orderBy('loves',descending: true).startAfter([_lastVisible!['loves']]).limit(4).get();
  //   }
  //   if(rawData.docs.length > 0){
  //     _lastVisible = rawData.docs[rawData.docs.length - 1];
  //     if(mounted){
  //       setState(() {
  //         _isLoading = false;
  //         _snap.addAll(rawData.docs);
  //         data = _snap.map((e) => Article.fromFirestore(e)).toList();
  //       });
  //     }
  //   }else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  //   return null;
  // }
  // @override
  // void initState() {
  //   controller = ScrollController()..addListener(_scrollListner);
  //   super.initState();
  //   _isLoading = true;
  //   getData();
  // }
  // void _scrollListner(){
  //   if(controller!.position.pixels == controller!.position.maxScrollExtent){
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     getData();
  //   }
  // }
  // onRefresh(){
  //   setState(() {
  //     _snap.clear();
  //     data.clear();
  //     _isLoading = true;
  //     _lastVisible = null;
  //   });
  //   getData();
  // }
  // @override
  // void dispose() {
  //   controller!.removeListener(_scrollListner);
  //   super.dispose();
  // }


  // Http API
  void _postData() async {
    try {
      var url = Uri.parse('https://sustainplanet.org/sp_app/public/register');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': 'Rohit Kumar',
          'email': 'rohit25022@gmail.com',
          'password': 'Roh',
        }),
      );

      if (response.statusCode == 200) {
        // Parse the JSON response as a Map
        var responseData = jsonDecode(response.body) as Map<String, dynamic>;

        if (responseData['message'] == 'User created successfully') {
          print('Success: User created successfully');
          // Redirect or show success message in Flutter
        } else {
          print('Error: ${responseData['message']}');
          // Show error message in Flutter
        }
      } else {
        print('Error: Status code - ${response.statusCode}');
        // Show error message in Flutter
      }
    } catch (e) {
      print('Exception: $e');
      // Handle exception and show error message in Flutter
    }
  }












  List<dynamic> users = [];
  void fetchUser() async{
    const url = 'https://sustainplanet.org/sp_app/public/blog/data';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json;
    });
    print('fetch user completed');
  }
  @override
  void initState() {
    fetchUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
          // onRefresh();
        },
        child: CustomScrollView(
          // controller: controller,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              backgroundColor: Colors.amber,
              expandedHeight: MediaQuery.of(context).size.height*.15,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.title,style: const TextStyle(fontSize: 20),),
                titlePadding: const EdgeInsets.only(left: 20, bottom: 15, right: 20),
                background: Container(
                  color: Colors.amber,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate((context, index){
                return InkWell(
                  onTap: () async {
                    _postData();
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
                            // ClipRRect(
                            //   borderRadius: const BorderRadius.only(
                            //     topLeft: Radius.circular(14),
                            //     topRight: Radius.circular(14),
                            //   ),
                            //   child: CachedNetworkImage(
                            //     imageUrl: users[index]['picture']['large'],
                            //     fit: BoxFit.cover,
                            //     width: double.infinity,
                            //     height: 150,
                            //     placeholder: (context, url) => Container(color: Colors.grey[300]),
                            //     errorWidget: (context, url, error) => Container(
                            //       color: Colors.grey[300],
                            //       child: const Icon(Icons.error),
                            //     ),
                            //   ),
                            // ),
                            Container(
                              padding: const EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(FontAwesomeIcons.clock,size: 13,color: Colors.grey,),
                                      const SizedBox(width: 6,),
                                      Text(users[index]['post_date'],style: const TextStyle(color: Colors.grey,fontSize: 13,
                                          fontWeight: FontWeight.w500),)
                                    ],
                                  ),
                                  Text(users[index]['post_title'],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                  // Text(users[index]['post_content'],
                                  //   style: TextStyle(
                                  //       fontSize: 13,
                                  //       color: Colors.black.withOpacity(.8)
                                  //   ),
                                  //   // overflow: TextOverflow.ellipsis,maxLines: 9,
                                  // ),
                                  HtmlBodyWidget(
                                    content: users[index]['post_content'],
                                    isIframeVideoEnabled: true,
                                    isVideoEnabled: true,
                                    isimageEnabled: true,
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
              },childCount: users.length),
            )

            // SliverList(
            //     delegate: SliverChildBuilderDelegate((context, index){
            //       if(data.length > index){
            //         return InkWell(
            //           onTap: (){
            //             navigateToDetailsScreen(context, data[index], 'moreArticle${data[index].timestamp}');
            //           },
            //           child: Container(
            //             margin: const EdgeInsets.only(bottom: 6,top: 6),
            //             padding: const EdgeInsets.only(left: 14,right: 14,top: 5),
            //             child: Container(
            //               decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   boxShadow: [
            //                     BoxShadow(
            //                         color: Colors.grey.withOpacity(.3),
            //                         blurRadius: 4,
            //                         spreadRadius: 1
            //                     )
            //                   ],
            //                   borderRadius: BorderRadius.circular(14)
            //               ),
            //               child: Column(
            //                   children: [
            //                     ClipRRect(
            //                       borderRadius: const BorderRadius.only(
            //                         topLeft: Radius.circular(14),
            //                         topRight: Radius.circular(14),
            //                       ),
            //                       child: Hero(
            //                         tag: 'moreArticle${data[index].timestamp}',
            //                         child: CachedNetworkImage(
            //                           imageUrl: data[index].thumbnailImagelUrl!,
            //                           fit: BoxFit.cover,
            //                           width: double.infinity,
            //                           height: 150,
            //                           placeholder: (context, url) => Container(color: Colors.grey[300]),
            //                           errorWidget: (context, url, error) => Container(
            //                             color: Colors.grey[300],
            //                             child: const Icon(Icons.error),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Container(
            //                       padding: const EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 12),
            //                       child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Row(
            //                             children: [
            //                               const Icon(FontAwesomeIcons.clock,size: 13,color: Colors.grey,),
            //                               const SizedBox(width: 6,),
            //                               Text(data[index].date!,style: const TextStyle(color: Colors.grey,fontSize: 13,
            //                                   fontWeight: FontWeight.w500),)
            //                             ],
            //                           ),
            //                           Text(data[index].title!,
            //                             style: const TextStyle(
            //                                 fontSize: 16,
            //                                 fontWeight: FontWeight.w500
            //                             ),overflow: TextOverflow.ellipsis,maxLines: 2,),
            //                           Text(data[index].description!,
            //                             style: TextStyle(
            //                                 fontSize: 13,
            //                                 color: Colors.black.withOpacity(.8)
            //                             ),overflow: TextOverflow.ellipsis,maxLines: 1,
            //                           ),
            //                           const SizedBox(height: 6,),
            //                           const Row(
            //                             children: [
            //                               Text('Read More',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.deepPurple),),
            //                               Icon(FontAwesomeIcons.angleRight,size: 13,color: Colors.deepPurple,)
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     )
            //                   ]
            //               ),
            //             ),
            //           ),
            //         );
            //       }
            //       if(_isLoading){
            //         if(_lastVisible == null){
            //           return Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
            //             child: SkeletonLoading(height: 220, color: Colors.grey[300]),
            //           );
            //         }else {
            //           return const Center(
            //             child: SizedBox(
            //               width: 32,
            //               height: 32,
            //               child: CupertinoActivityIndicator(),
            //             ),
            //           );
            //         }
            //       }else {
            //         return Container();
            //       }
            //     },childCount: data.length != 0 ? data.length + 1 : 6),
            // )
          ],
        ),
      ),
    );
  }
}