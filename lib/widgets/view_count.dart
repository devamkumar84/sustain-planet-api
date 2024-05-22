// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/article_model.dart';

// class ViewCount extends StatefulWidget{
//   final Article article;
//
//   const ViewCount({super.key, required this.article});
//   @override
//   State<ViewCount> createState()=> ViewCountState();
// }
// class ViewCountState extends State<ViewCount>{
//
//   _viewIncrement() async {
//     final DocumentReference ref = FirebaseFirestore.instance.collection('contents').doc(widget.article.timestamp);
//     Future.delayed(const Duration(seconds: 10)).then((value)async{
//       await getLatestCount().then((int latestCount) async{
//         await ref.update({
//           'views': latestCount+ 1,
//         });
//       });
//     });
//   }
//   Future<int> getLatestCount() async{
//     if(widget.article.views != null){
//       final DocumentReference ref = FirebaseFirestore.instance.collection('contents').doc(widget.article.timestamp);
//       DocumentSnapshot snap = await ref.get();
//       int itemCount = snap['views'] ?? 0;
//       return itemCount;
//     }else {
//       return 0;
//     }
//   }
//   @override
//   void initState() {
//     _viewIncrement();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context){
//     return Row(
//       children: [
//         const Icon(Icons.remove_red_eye_outlined,size: 20,color: Colors.grey,),
//         const SizedBox(width: 5,),
//         widget.article.views == null ?
//         Text(0.toString(),style: const TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.w400),) :
//         StreamBuilder(
//             stream: FirebaseFirestore.instance.collection('contents').doc(widget.article.timestamp!).snapshots(),
//             builder: (context, AsyncSnapshot snap){
//               if(snap.hasData){
//                 return Text(snap.data['views'].toString(),style: const TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.w400),);
//               }else{
//                 return Text(0.toString(),style: const TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.w400),);
//               }
//             }),
//         const Text(' Views',style: TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.w400),),
//       ],
//     );
//   }
// }