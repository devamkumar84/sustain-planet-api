// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/article_model.dart';
import 'article_detail.dart';

// class PostNotificationDetails extends StatefulWidget {
//
//   final String postID;
//   PostNotificationDetails({Key? key, required this.postID}) : super(key: key);
//
//   @override
//   _PostNotificationDetailsState createState() => _PostNotificationDetailsState();
// }
//
// class _PostNotificationDetailsState extends State<PostNotificationDetails> {
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   late Future _fetchData;
//
//
//
//   Future<Article> fetchPostByPostId() async {
//     Article? article;
//     final docRef = _firestore.collection('contents').doc(widget.postID);
//     await docRef.get().then((DocumentSnapshot snap){
//       article = Article.fromFirestore(snap);
//     });
//     return article!;
//   }
//
//
//   @override
//   void initState() {
//     _fetchData = fetchPostByPostId();
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _fetchData,
//       builder: (context, AsyncSnapshot snap){
//         if(snap.connectionState == ConnectionState.active || snap.connectionState == ConnectionState.waiting){
//           return Scaffold(
//             appBar: AppBar(),
//             body: Center(child: Container(
//               height: 32,
//               width: 32,
//               child: CupertinoActivityIndicator(),
//             )),
//           );
//         }else if (snap.hasError){
//           //print(snap.error);
//           return Scaffold(
//             appBar: AppBar(),
//             body: const Center(child: Text('Something is wrong. Please try again!'),),
//           );
//         }else{
//           Article article = snap.data;
//           //print('article: ${article.title}');
//           if (article.contentType == 'image'){
//             return ArticleDetail(data: article, tag: null,);
//           }else {
//             return Scaffold(
//             appBar: AppBar(),
//             body: const Center(child: Text('Something is wrong1. Please try again!'),),
//           );
//           }
//         }
//       },
//     );
//   }
// }

