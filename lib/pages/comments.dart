import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../blocs/comment_bloc.dart';
import '../blocs/signin_bloc.dart';
import '../models/comment_model.dart';
import '../services/app_service.dart';
import '../utils/skeleton_loading.dart';
import '../utils/toast.dart';

// class Comments extends StatefulWidget{
//   final String? timestamp;
//
//   const Comments({super.key, required this.timestamp});
//   @override
//   State<Comments> createState()=> CommentsState();
// }
// class CommentsState extends State<Comments>{
//   final FirebaseFirestore fireStore = FirebaseFirestore.instance;
//   DocumentSnapshot? _lastVisible;
//   late bool _isLoading;
//   List<DocumentSnapshot> _snap = [];
//   List<Comment> _data = [];
//   bool? _hasData;
//   ScrollController? controller;
//   TextEditingController commentController = TextEditingController();
//   @override
//   void initState() {
//     controller = new ScrollController()..addListener(_scrollListner);
//     super.initState();
//     _isLoading = true;
//     getData();
//   }
//   Future<Null> getData() async {
//     QuerySnapshot data;
//     if(_lastVisible == null){
//       data = await fireStore.collection('contents/${widget.timestamp}/comments')
//           .orderBy('timestamp', descending: true).limit(12).get();
//     }else {
//       data = await fireStore.collection('contents/${widget.timestamp}/comments')
//           .orderBy('timestamp',descending: true).startAfter([_lastVisible!['timestamp']])
//           .limit(12).get();
//     }
//     if(data.docs.length > 0){
//       setState(() {
//         _hasData = true;
//       });
//       _lastVisible = data.docs[data.docs.length - 1];
//       if(mounted){
//         setState(() {
//           _isLoading = false;
//           _snap.addAll(data.docs);
//           _data = _snap.map((e) => Comment.fromFirestore(e)).toList();
//         });
//       }
//     }else {
//       if(_lastVisible == null){
//         setState(() {
//           _isLoading = false;
//           _hasData = false;
//           print('no item');
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
//   void dispose() {
//     controller!.removeListener(_scrollListner);
//     super.dispose();
//   }
//   void _scrollListner(){
//     if(!_isLoading){
//       if(controller!.position.pixels == controller!.position.maxScrollExtent){
//         setState(() {
//           _isLoading = true;
//           getData();
//         });
//       }
//     }
//   }
//   onRefreshData(){
//     setState(() {
//       _snap.clear();
//       _data.clear();
//       _isLoading = true;
//       _lastVisible = null;
//     });
//     getData();
//   }
//   Future handleSubmit()async {
//     final SignInBloc sb = context.read<SignInBloc>();
//     if(sb.isSignedIn == false){
//       showDialog(
//           context: context,
//           builder: (context){
//             return AlertDialog(
//               title: const Text('Sign in first to access this feature'),
//               content: const Text('You haven\'t signed in yet. \n Please sign in to unlock this feature'),
//               actions: [
//                 TextButton(
//                     onPressed: (){
//                       Navigator.pop(context);
//                     },
//                     child: const Text('OK')
//                 )
//               ],
//             );
//           });
//     }else {
//       if(commentController.text.isEmpty){
//         print('comment is empty');
//       }else {
//         await AppService().checkInternet().then((hasInternet){
//           if(hasInternet == false){
//             openToast(context, 'no internet');
//           }else{
//             context.read<CommentBloc>().saveNewComment(widget.timestamp!, commentController.text);
//             commentController.clear();
//             onRefreshData();
//             FocusScope.of(context).requestFocus(FocusNode());
//           }
//         });
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Comments',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: IconButton(
//                 onPressed: (){
//                   onRefreshData();
//                 },
//                 icon: const Icon(Icons.refresh,color: Colors.black,)
//             ),
//           )
//         ],
//       ),
//       body: Container(
//         color: Colors.grey[200],
//         child: Column(
//           children: [
//             Expanded(
//                 child: RefreshIndicator(
//                   onRefresh: ()async{
//                     onRefreshData();
//                   },
//                   child: _hasData == false ?
//                   const Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(20),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Icon(Icons.comment, size: 100, color: Colors.grey),
//                           SizedBox(height: 20,),
//                           Text('no comments found',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 19, fontWeight: FontWeight.w500,
//
//                             ),),
//                           SizedBox(height: 5,),
//                           Text('be the first to comment',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontSize: 15, fontWeight: FontWeight.w400,
//                                 color: Colors.grey
//                             ),)
//                         ],
//                       ),
//                     ),
//                   ) :
//                   ListView.separated(
//                       itemBuilder: (context, index){
//                         if(index < _data.length){
//                           return ListTile(
//                             leading: CircleAvatar(
//                               radius: 30,
//                               backgroundImage: CachedNetworkImageProvider(
//                                 _data[index].imageUrl!,
//                               ),
//                             ),
//                             title: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(4)
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(_data[index].name!,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
//                                       Text(_data[index].comment!,style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 2,),
//                                 Text(_data[index].date!,style: const TextStyle(fontSize: 12,color: Colors.grey),)
//                               ],
//                             ),
//                           );
//                         }
//                         if(_isLoading){
//                           return Opacity(
//                             opacity: 1.0,
//                             child: _lastVisible == null ?
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
//                               child: SkeletonLoading(height: 150, color: Colors.grey[300])
//                             ):
//                             const Center(
//                               child: SizedBox(
//                                   width: 32.0,
//                                   height: 32.0,
//                                   child: CupertinoActivityIndicator()),
//                             ),
//                           );
//                         }
//                         return null;
//                       },
//                       separatorBuilder: (context, index){
//                         return const SizedBox(height: 5,);
//                       },
//                       itemCount: _data.length != 0 ? _data.length +1 : 10),
//                 ),
//             ),
//             Divider(
//               height: 1,
//               color: Colors.grey[300],
//             ),
//             Container(
//               height: 65,
//               color: Colors.white,
//               padding: const EdgeInsets.only(top: 8,left: 14,right: 14),
//               child: TextField(
//                 controller: commentController,
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.symmetric(vertical: 14,horizontal: 14),
//                   hintText: "write a comment",
//                   hintStyle: const TextStyle(
//                     fontWeight: FontWeight.w400,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey.withOpacity(.2),
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.send,color: Colors.blueAccent,),
//                     onPressed: (){
//                       handleSubmit();
//                     },
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(50),
//                     borderSide: BorderSide(
//                       color: Colors.grey.withOpacity(.5),
//                     )
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(50),
//                       borderSide: BorderSide(
//                         color: Colors.grey.withOpacity(.5),
//                       )
//                   )
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }