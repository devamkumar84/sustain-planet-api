// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class LoveCount extends StatelessWidget{
//   final String? timestamp;
//
//   const LoveCount({super.key, required this.timestamp});
//   @override
//   Widget build(BuildContext context){
//     return Row(
//       children: [
//         const FaIcon(FontAwesomeIcons.solidHeart,size: 16,color: Colors.grey,),
//         const SizedBox(width: 5,),
//         StreamBuilder(
//             stream: FirebaseFirestore.instance.collection('contents').doc(timestamp).snapshots(),
//             builder: (context, AsyncSnapshot snap){
//               if(!snap.hasData){
//                 return Text(0.toString(),style: const TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.w400),);
//               }else {
//                 return Text(snap.data['loves'].toString(),style: const TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.w400),);
//               }
//             }
//         ),
//         const Text(' People like this',style: TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.w400),)
//       ],
//     );
//   }
// }