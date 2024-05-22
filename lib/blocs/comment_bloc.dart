// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class CommentBloc with ChangeNotifier {
//   final FirebaseFirestore fireStore = FirebaseFirestore.instance;
//   // Comment Submit Algo
//   Future saveNewComment(String timestamp, String newComment)async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     String? _name = sp.getString('name');
//     String? _uid = sp.getString('uid');
//     String? _imageUrl = sp.getString('image_url');
//     await _getDate().then((value) => fireStore.collection('contents/${timestamp}/comments')
//         .doc('$_uid$newTimestamp').set({
//       'name': _name,
//       'comment' : newComment,
//       'date' : date,
//       'image url' : _imageUrl,
//       'timestamp': newTimestamp,
//       'uid' : _uid
//     })
//     );
//     notifyListeners();
//   }
//   String? date;
//   String? newTimestamp;
//   Future _getDate()async {
//     DateTime now = DateTime.now();
//     String _date = DateFormat('dd MMMM yy').format(now);
//     String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
//     date = _date;
//     newTimestamp = _timestamp;
//   }
// }