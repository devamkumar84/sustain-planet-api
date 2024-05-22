// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;

import '../models/article_model.dart';

// class HomeBloc with ChangeNotifier{
//   final FirebaseFirestore fireStore = FirebaseFirestore.instance;
//
//   // HomeFeatured List
//   List _data = [];
//   List get data => _data;
//   List featuredList = [];
//
//   Future<List> _getFeaturedData() async{
//     final DocumentReference ref = fireStore.collection('featured').doc('featured_list');
//     DocumentSnapshot snap = await ref.get();
//     featuredList = snap['contents'].take(6).toList() ?? [];
//     return featuredList;
//   }
//   Future getData() async{
//     _getFeaturedData().then((featuredList) async{
//       QuerySnapshot rawData;
//       rawData = await fireStore.collection('contents').where('timestamp', whereIn: featuredList).limit(4).get();
//       List<DocumentSnapshot> snap = [];
//       snap.addAll(rawData.docs);
//       _data = snap.map((e) => Article.fromFirestore(e)).toList();
//       notifyListeners();
//     });
//   }
//   onFeaturedRefresh (){
//     featuredList.clear();
//     _data.clear();
//     getData();
//     notifyListeners();
//   }
//
//
//   // PopularArticle List
//   List _dataPopular = [];
//   List get dataPopular => _dataPopular;
//
//
//   Future getPopularData() async{
//     QuerySnapshot rawData;
//     rawData = await fireStore.collection('contents')
//         .orderBy('loves', descending: true).limit(4).get();
//     List<DocumentSnapshot> snap = [];
//     snap.addAll(rawData.docs);
//     _dataPopular = snap.map((e) => Article.fromFirestore(e)).toList();
//     notifyListeners();
//
//   }
//   onPopularDataRefresh (){
//     _dataPopular.clear();
//     getPopularData();
//     notifyListeners();
//   }
//
//   // RecentArticle List
//   List<Article> _dataRecent = [];
//   List<Article> get dataRecent => _dataRecent;
//
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final List<DocumentSnapshot> _snapRecent = [];
//
//   DocumentSnapshot? _lastVisibleRecent;
//   DocumentSnapshot? get lastVisibleRecent => _lastVisibleRecent;
//
//   bool _isLoadingRecent = true;
//   bool get isLoadingRecent => _isLoadingRecent;
//
//
//   Future<Null> getRecentData(mounted) async {
//     QuerySnapshot rawData;
//
//     if (_lastVisibleRecent == null){
//       rawData = await firestore
//           .collection('contents')
//           .orderBy('timestamp', descending: true)
//           .limit(2)
//           .get();
//     }
//     else{
//       rawData = await firestore
//           .collection('contents')
//           .orderBy('timestamp', descending: true)
//           .startAfter([_lastVisibleRecent!['timestamp']])
//           .limit(2)
//           .get();
//     }
//
//     if (rawData.docs.length > 0) {
//       _lastVisibleRecent = rawData.docs[rawData.docs.length - 1];
//       if (mounted) {
//         _isLoadingRecent = false;
//         _snapRecent.addAll(rawData.docs);
//         _dataRecent = _snapRecent.map((e) => Article.fromFirestore(e)).toList();
//         notifyListeners();
//       }
//     } else {
//       _isLoadingRecent = false;
//       // print('no items available');
//
//     }
//     notifyListeners();
//     return null;
//   }
//
//   setRecentLoading(bool isloading) {
//     _isLoadingRecent = isloading;
//     notifyListeners();
//   }
//   onRecentRefresh(mounted) {
//     _snapRecent.clear();
//     _dataRecent.clear();
//     _isLoadingRecent = true;
//     _lastVisibleRecent = null;
//     getRecentData(mounted);
//     notifyListeners();
//   }
//
//
//   // Health Data
//   List _healthData = [];
//   List get healthData => _healthData;
//
//   bool _isHealthLoading = true;
//   bool get isHealthLoading => _isHealthLoading;
//
//   bool? _hasHealthData;
//   bool? get hasHealthData => _hasHealthData;
//
//   DocumentSnapshot? _lastVisible;
//   DocumentSnapshot? get lastVisible => _lastVisible;
//
//   List<DocumentSnapshot> snapshot = [];
//
//   Future<Null> getHealthData(mounted)async {
//     QuerySnapshot rawData;
//     if(_lastVisible == null){
//       rawData = await fireStore.collection('contents').where('category', isEqualTo: "Health")
//           .orderBy('timestamp', descending: true).limit(4).get();
//     } else{
//       rawData = await fireStore.collection('contents').where('category', isEqualTo: "Health")
//           .orderBy('timestamp', descending: true).startAfter([_lastVisible!['timestamp']]).limit(4).get();
//     }
//     if(rawData.docs.length > 0){
//       _lastVisible = rawData.docs[rawData.docs.length - 1];
//       if(mounted){
//         snapshot.addAll(rawData.docs);
//         _isHealthLoading = false;
//         _healthData = snapshot.map((e) => Article.fromFirestore(e)).toList();
//         notifyListeners();
//       }
//     }else {
//       if(_lastVisible == null){
//         _isHealthLoading = false;
//         _hasHealthData = false;
//         // print('no item');
//       }else{
//         _isHealthLoading = false;
//         _hasHealthData = true;
//         // print('no more items');
//       }
//     }
//     notifyListeners();
//     return null;
//   }
//   setLoading(bool isloading) {
//     _isHealthLoading = isloading;
//     notifyListeners();
//   }
//   onHealthRefresh(mounted){
//     _healthData.clear();
//     snapshot.clear();
//     _isHealthLoading = true;
//     _lastVisible = null;
//     getHealthData(mounted);
//     notifyListeners();
//   }
//
//   // Food Data
//   List _foodData = [];
//   List get foodData => _foodData;
//
//   bool _isFoodLoading = true;
//   bool get isFoodLoading => _isFoodLoading;
//
//   bool? _hasFoodData;
//   bool? get hasFoodData => _hasFoodData;
//
//   DocumentSnapshot? _lastFoodVisible;
//   DocumentSnapshot? get lastFoodVisible => _lastFoodVisible;
//
//   List<DocumentSnapshot> snapshotfood = [];
//
//   Future getFoodData(mounted)async {
//     QuerySnapshot rawData;
//     if(_lastFoodVisible == null){
//       rawData = await fireStore.collection('contents').where('category', isEqualTo: "Food")
//           .orderBy('timestamp', descending: true).limit(4)
//           .get();
//     }else {
//       rawData = await fireStore.collection('contents').where('category', isEqualTo: "Food")
//           .orderBy('timestamp', descending: true).startAfter([_lastFoodVisible!['timestamp']])
//           .limit(4).get();
//     }
//     if(rawData.docs.length > 0){
//       _lastFoodVisible = rawData.docs[rawData.docs.length - 1];
//       if(mounted){
//         snapshotfood.addAll(rawData.docs);
//         _isFoodLoading = false;
//         _hasFoodData = true;
//         _foodData = snapshotfood.map((e) => Article.fromFirestore(e)).toList();
//       }
//     }else {
//       if(_lastFoodVisible == null){
//         _hasFoodData = false;
//         _isFoodLoading = false;
//       }else {
//         _hasFoodData = true;
//         _isFoodLoading = false;
//       }
//     }
//     notifyListeners();
//   }
//   setFoodLoading(bool isfoodloading) {
//     _isFoodLoading = isfoodloading;
//     notifyListeners();
//   }
//   onFoodRefresh(mounted){
//     _foodData.clear();
//     snapshotfood.clear();
//     _isFoodLoading = true;
//     _lastFoodVisible = null;
//     getFoodData(mounted);
//     notifyListeners();
//   }
//
//   // Biodiversity Data
//   List _biodiversityData = [];
//   List get biodiversityData => _biodiversityData;
//
//   bool _isBioLoading = true;
//   bool get isBioLoading => _isBioLoading;
//
//   bool? _hasBioData;
//   bool? get hasBioData => _hasBioData;
//
//   DocumentSnapshot? _lastBioVisible;
//   DocumentSnapshot? get lastBioVisible => _lastBioVisible;
//
//   List<DocumentSnapshot> snapBio = [];
//
//   Future getBiodiversityData(mounted) async{
//     QuerySnapshot rawData;
//     if(_lastBioVisible == null){
//       rawData = await fireStore.collection('contents').where('category', isEqualTo: 'Biodiversity')
//           .orderBy('timestamp', descending: true).limit(4).get();
//     }else {
//       rawData = await fireStore.collection('contents').where('category', isEqualTo: 'Biodiversity')
//           .orderBy('timestamp', descending: true).startAfter([_lastBioVisible!['timestamp']]).limit(4).get();
//     }
//     if(rawData.docs.length > 0){
//       _lastBioVisible = rawData.docs[rawData.docs.length - 1];
//       if(mounted){
//         snapBio.addAll(rawData.docs);
//         _hasBioData = true;
//         _isBioLoading = false;
//         _biodiversityData = snapBio.map((e){
//           return Article.fromFirestore(e);
//         }).toList();
//       }
//     }else {
//       if(_lastBioVisible == null){
//         _hasBioData = false;
//         _isBioLoading = false;
//       }else {
//         _hasBioData = true;
//         _isBioLoading = false;
//       }
//     }
//     notifyListeners();
//   }
//   setBioLoading(bool onBioLoading){
//     _isBioLoading = onBioLoading;
//     notifyListeners();
//   }
//   onBioRefresh(mounted){
//     _biodiversityData.clear();
//     snapBio.clear();
//     _isBioLoading = true;
//     _lastBioVisible = null;
//     getBiodiversityData(mounted);
//     notifyListeners();
//   }
//
//   // Ocean Data
//   List _oceanData = [];
//   List get oceanData => _oceanData;
//
//   bool _isOceanLoading = true;
//   bool get isOceanLoading => _isOceanLoading;
//
//   bool? _hasOceanData;
//   bool? get hasOceanData => _hasOceanData;
//
//   DocumentSnapshot? _lastOceanVisible;
//   DocumentSnapshot? get lastOceanVisible => _lastOceanVisible;
//
//   List<DocumentSnapshot> snapshotOcean = [];
//
//   Future getOceanData(mounted)async {
//     QuerySnapshot rawData;
//     if(_lastOceanVisible == null){
//       rawData = await fireStore.collection('contents').where('category', isEqualTo: 'Ocean')
//           .orderBy('timestamp', descending: true).limit(4).get();
//     }else{
//       rawData = await fireStore.collection('contents').where('category', isEqualTo: 'Ocean')
//           .orderBy('timestamp', descending: true).startAfter([_lastOceanVisible!['timestamp']]).limit(4).get();
//     }
//     if(rawData.docs.length > 0){
//       _lastOceanVisible = rawData.docs[rawData.docs.length - 1];
//       if(mounted){
//         snapshotOcean.addAll(rawData.docs);
//         _hasOceanData = true;
//         _isOceanLoading = false;
//         _oceanData = snapshotOcean.map((e) => Article.fromFirestore(e)).toList();
//       }
//     }else {
//       if(_lastOceanVisible == null){
//         _hasOceanData = false;
//         _isOceanLoading = false;
//       }else {
//         _hasOceanData = true;
//         _isOceanLoading = false;
//       }
//     }
//     notifyListeners();
//   }
//   setOceanLoading(bool onOceanLoading){
//     _isOceanLoading = onOceanLoading;
//     notifyListeners();
//   }
//   onOceanRefresh(mounted){
//     oceanData.clear();
//     snapshotOcean.clear();
//     _lastOceanVisible = null;
//     _isOceanLoading = true;
//     getOceanData(mounted);
//     notifyListeners();
//   }
//
//
//
//   // Like Algo
//   Future onLoveIconClick(String? timestamp) async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     const String _collectionName = 'contents';
//     String? _uid = sp.getString('uid');
//     String _fieldName = 'loved items';
//
//
//     final DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(_uid);
//     final DocumentReference ref1 = FirebaseFirestore.instance.collection(_collectionName).doc(timestamp);
//
//     DocumentSnapshot snap = await ref.get();
//     DocumentSnapshot snap1 = await ref1.get();
//     List d = snap[_fieldName];
//     int? _loves = snap1['loves'];
//
//     if (d.contains(timestamp)) {
//
//       List a = [timestamp];
//       await ref.update({_fieldName: FieldValue.arrayRemove(a)});
//       ref1.update({'loves': _loves! - 1});
//
//     } else {
//
//       d.add(timestamp);
//       await ref.update({_fieldName: FieldValue.arrayUnion(d)});
//       ref1.update({'loves': _loves! + 1});
//
//     }
//   }
//   // BookMark Icon Algo
//   Future onBookmarkIconClick(String? timestamp, BuildContext context) async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     String? _uid = sp.getString('uid');
//     String _fieldName = 'bookmarked items';
//
//     final DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(_uid);
//     DocumentSnapshot snap = await ref.get();
//     List d = snap[_fieldName];
//     if(d.contains(timestamp)){
//       List a = [timestamp];
//       await ref.update({_fieldName: FieldValue.arrayRemove(a)});
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Container(
//             alignment: Alignment.centerLeft,
//             height: 60,
//             child: const Text(
//               "Remove to favourite",
//               style: TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           action: SnackBarAction(
//             label: 'Ok',
//             textColor: Colors.blueAccent,
//             onPressed: () {},
//           ),
//         ),
//       );
//     }else {
//       d.add(timestamp);
//       await ref.update({_fieldName: FieldValue.arrayUnion(d)});
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Container(
//             alignment: Alignment.centerLeft,
//             height: 60,
//             child: const Text(
//               "Add to favourite",
//               style: TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           action: SnackBarAction(
//             label: 'Ok',
//             textColor: Colors.blueAccent,
//             onPressed: () {},
//           ),
//         ),
//       );
//     }
//     notifyListeners();
//   }
//   // Bookmark show Algo
//   Future<List> getBookmarkArticles()async {
//     String _fieldName = 'bookmarked items';
//
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     String? _uid = sp.getString('uid');
//
//     final DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(_uid);
//     DocumentSnapshot snap = await ref.get();
//     List BookmarkList = snap[_fieldName];
//     print('mainList: $BookmarkList');
//     List deee = [];
//     if(BookmarkList.isEmpty){
//       return deee;
//     }else if(BookmarkList.length > 0) {
//       await FirebaseFirestore.instance.collection('contents').where('timestamp', whereIn: BookmarkList)
//           .limit(10).get().then((QuerySnapshot snap) {
//         deee.addAll(snap.docs.map((e) => Article.fromFirestore(e)).toList());
//       });
//     }
//     return deee;
//   }
//
// }

class PostProvider extends ChangeNotifier {
  PostProvider(){
    initPackageInfo();
  }
  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;

  Future<void> fetchPosts() async {
    const url = 'https://sustainplanet.org/sp_app/public/blog/data';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      // Populate the _posts list with data from the API response
      for (var postData in jsonResponse) {
        final post = PostModel.fromJson(postData);
        _posts.add(post);
      }
    } else {
      // Handle errors here
      throw Exception('Failed to load posts');
    }
    notifyListeners();
  }
  onPopularDataRefresh (){
    _posts.clear();
    fetchPosts();
    notifyListeners();
  }


  // Recent Article
  List<PostModel> _postsRecent = [];
  List<PostModel> get postsRecent => _postsRecent;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  int _offset = 0;
  final int _limit = 2; // Number of posts to load per request

  Future<void> fetchPostsRecent() async {
    final url = 'https://sustainplanet.org/sp_app/public/blog/datarecent?limit=$_limit&offset=$_offset';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<PostModel> fetchedPosts = jsonResponse.map((postData) => PostModel.fromJson(postData)).toList();

      _postsRecent.addAll(fetchedPosts);
      _offset += _limit;
      _isLoading = false;
    } else {
      _isLoading = false;
      // Handle errors here
      throw Exception('Failed to load posts');
    }
    notifyListeners();
  }
  onRecentDataRefresh (){
    _postsRecent.clear();
    _offset = 0;
    _isLoading = true;
    fetchPostsRecent();
    notifyListeners();
  }
  void loadMorePosts() {
    if (!_isLoading) {
      _isLoading = true;
      fetchPostsRecent();
    }
  }

  // Health Department
  List<PostModel> _healthArticle = [];
  List<PostModel> get healthArticle => _healthArticle;

  bool _isHealthLoading = true;
  bool get isHealthLoading => _isHealthLoading;

  bool? _hasHealthData;
  bool? get hasHealthData => _hasHealthData;

  int _healthOffset = 0;
  final int _healthLimit = 4;
  final String _artCategory = 'Health';

  Future<void> fetchHealthArticle() async{
    final url = 'https://sustainplanet.org/sp_app/public/blog/datarecent?limit=$_healthLimit&offset=$_healthOffset&category=$_artCategory';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      if(response.body.isNotEmpty){
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        final List<PostModel> fetchedPosts = jsonResponse.map((postData) => PostModel.fromJson(postData)).toList();
        _healthArticle.addAll(fetchedPosts);
        _healthOffset += _healthLimit;
        _isHealthLoading = false;
      }else {
        _hasHealthData = false;
        _isHealthLoading = false;
      }
    }else {
      _isHealthLoading = false;
      throw Exception('Failed to Load post5');
    }
    notifyListeners();
  }
  onHealthDataRefresh(){
    _healthArticle.clear();
    _healthOffset = 0;
    _isHealthLoading = true;
    fetchHealthArticle();
    notifyListeners();
  }
  void loadMoreHealthData(){
    if(!_isHealthLoading){
      _isHealthLoading = true;
      fetchHealthArticle();
      notifyListeners();
    }
  }

  // Food Department
  List<PostModel> _foodArticle = [];
  List<PostModel> get foodArticle => _foodArticle;

  bool _isFoodLoading = true;
  bool get isFoodLoading => _isFoodLoading;

  bool? _hasFoodData;
  bool? get hasFoodData => _hasFoodData;

  int foodOffset = 0;
  final int foodLimit = 4;
  final String artCategory2 = 'Food';

  Future<void> fetchFoodArticle() async{
    final url = 'https://sustainplanet.org/sp_app/public/blog/datarecent?limit=$foodLimit&offset=$foodOffset&category=$artCategory2';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      if(response.body.isNotEmpty){
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        final List<PostModel> fetchFoodArticle = jsonResponse.map((postData) => PostModel.fromJson(postData)).toList();
        _foodArticle.addAll(fetchFoodArticle);
        foodOffset += foodLimit;
        _isFoodLoading = false;
      }else {
        _isFoodLoading = false;
        _hasFoodData = false;
      }
    }else {
      _isFoodLoading = false;
      throw Exception('Failed to load food Articles');
    }
    notifyListeners();
  }

  onFoodDataRefresh(){
    _foodArticle.clear();
    _isFoodLoading = true;
    foodOffset = 0;
    fetchFoodArticle();
    notifyListeners();
  }
  void loadMoreFoodData(){
    if(!_isFoodLoading){
      _isFoodLoading = true;
      fetchFoodArticle();
      notifyListeners();
    }
  }

  // Biodiversity Department
  List<PostModel> _biodiversityArticle = [];
  List<PostModel> get biodiversityArticle => _biodiversityArticle;

  bool _isbioLoading = true;
  bool get isBioLoading => _isbioLoading;

  bool? _hasBioData;
  bool? get hasBioData => _hasBioData;

  int bioOffset = 0;
  final int bioLimit = 4;
  final String artCategory3 = 'Biodiversity';

  Future<void> fetchBioArticle()async {
    final url = "https://sustainplanet.org/sp_app/public/blog/datarecent?limit=$bioLimit&offset=$bioOffset&category=$artCategory3";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      if(response.body.isNotEmpty){
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        final List<PostModel> fetchBioArticle = jsonResponse.map((postData){
          return PostModel.fromJson(postData);
        }).toList();
        _biodiversityArticle.addAll(fetchBioArticle);
        foodOffset += foodLimit;
        _isbioLoading = false;
      } else {
        _isbioLoading = false;
        _hasBioData = false;
      }
    }else {
      _isbioLoading = false;
      throw Exception('Failed to load biodiversity article');
    }
  }
  onBioDataRefresh(){
    _biodiversityArticle.clear();
    _isbioLoading = true;
    bioOffset = 0;
    fetchBioArticle();
    notifyListeners();
  }
  void loadMoreBioData(){
    if(!_isbioLoading){
      _isbioLoading = true;
      fetchBioArticle();
      notifyListeners();
    }
  }

  // App Info
  String _appVersion = '0.0';
  String get appVersion => _appVersion;

  String _packageName = '';
  String get packageName => _packageName;

  void initPackageInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _appVersion = packageInfo.version;
      _packageName = packageInfo.packageName;
      notifyListeners();
    } catch (e) {
      print('Error fetching package info: $e');
    }
  }

}