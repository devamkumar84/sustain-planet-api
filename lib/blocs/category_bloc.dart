// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';

// class CategoryBloc with ChangeNotifier{
//   final FirebaseFirestore fireStore = FirebaseFirestore.instance;
//   // Category Data
//   List _cateData = [];
//   List get cateData => _cateData;
//
//   bool _isCateLoading = true;
//   bool get isCateLoading => _isCateLoading;
//
//   bool? _hasCateData;
//   bool? get hasCateData => _hasCateData;
//
//   Future getCateData()async {
//     QuerySnapshot rawData;
//     rawData = await fireStore.collection('categories')
//         .orderBy('timestamp', descending: false)
//         .get();
//     List<DocumentSnapshot> snapshot = [];
//     if(rawData.docs.length > 0){
//       snapshot.addAll(rawData.docs);
//       _hasCateData = true;
//       _isCateLoading = false;
//       _cateData = snapshot.map((e) => Category.fromFirestore(e)).toList();
//     }else {
//       _isCateLoading = false;
//       _hasCateData = false;
//       return Null;
//     }
//     notifyListeners();
//   }
//   onCateRefresh(){
//     _isCateLoading = true;
//     _cateData.clear();
//     getCateData();
//     notifyListeners();
//   }
// }