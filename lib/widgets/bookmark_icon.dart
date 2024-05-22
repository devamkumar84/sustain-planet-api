// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../blocs/signin_bloc.dart';

// class BuildBookmarkIcon extends StatelessWidget{
//   final String? uid;
//   final String? timestamp;
//
//   const BuildBookmarkIcon({super.key, required this.uid, required this.timestamp});
//   @override
//   Widget build(BuildContext context){
//     final sb = context.watch<SignInBloc>();
//     String typeCheck = "bookmarked items";
//     if(sb.isSignedIn == false) return const FaIcon(FontAwesomeIcons.bookmark,size: 22,color: Colors.black87,);
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
//         builder: (context, AsyncSnapshot shot){
//           if(uid == null) return const FaIcon(FontAwesomeIcons.bookmark,size: 22,color: Colors.black87,);
//           if(!shot.hasData) return const FaIcon(FontAwesomeIcons.bookmark,size: 22,color: Colors.black87,);
//           List d = shot.data[typeCheck];
//           if(d.contains(timestamp)){
//             return const FaIcon(FontAwesomeIcons.solidBookmark,size: 22,color: Colors.black87,);
//           }else {
//             return const FaIcon(FontAwesomeIcons.bookmark,size: 22,color: Colors.black87,);
//           }
//         }
//     );
//   }
// }