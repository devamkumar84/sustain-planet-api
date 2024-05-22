// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/article_model.dart';

// class SearchBloc with ChangeNotifier{
//
//   SearchBloc(){
//     getRecentSearchList();
//   }
//   List<String> _recentSearchData = [];
//   List<String> get recentSearchData => _recentSearchData;
//
//   String _searchText = '';
//   String get searchText => _searchText;
//
//   bool _searchStarted = false;
//   bool get searchStarted => _searchStarted;
//
//   TextEditingController _textFieldCtrl = TextEditingController();
//   TextEditingController get textFieldCtrl => _textFieldCtrl;
//   final FirebaseFirestore fireStore = FirebaseFirestore.instance;
//
//   Future addToSearchList(String value) async{
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     _recentSearchData.add(value);
//     await sp.setStringList('recent_search_data', _recentSearchData);
//     notifyListeners();
//   }
//   Future getRecentSearchList() async{
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     _recentSearchData = sp.getStringList('recent_search_data') ?? [];
//     notifyListeners();
//   }
//   Future removeFromSearchList(String value)async{
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     _recentSearchData.remove(value);
//     await sp.setStringList('recent_search_data', _recentSearchData);
//     notifyListeners();
//
//   }
//   Future<List> getData() async{
//     List<Article> data = [];
//     QuerySnapshot rawData = await fireStore.collection('contents').orderBy('timestamp', descending: true).get();
//     List<DocumentSnapshot> _snap = [];
//     _snap.addAll(rawData.docs.where((e){
//       return e['title'].toLowerCase().contains(_searchText.toLowerCase()) ||
//       e['category'].toLowerCase().contains(_searchText.toLowerCase()) ||
//       e['description'].toLowerCase().contains(_searchText.toLowerCase());
//     }));
//     data = _snap.map((e) => Article.fromFirestore(e)).toList();
//     return data;
//   }
//   setSearchText(value){
//     _textFieldCtrl.text = value;
//     _searchText = value;
//     _searchStarted = true;
//     notifyListeners();
//   }
//   searchInitialise(){
//     _textFieldCtrl.clear();
//     _searchStarted = false;
//     notifyListeners();
//   }
// }