import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInBloc extends ChangeNotifier {
  SignInBloc(){
    checkSignIn();
    initPackageInfo();
  }
  final String defaultUserImageUrl = 'https://www.oxfordglobal.co.uk/nextgen-omics-series-us/wp-content/uploads/sites/16/2020/03/Jianming-Xu-e5cb47b9ddeec15f595e7000717da3fe.png';

  String? _name;
  String? get name => _name;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  String? _id;
  String? get id => _id;

  String? _email;
  String? get email => _email;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  String? _signInProvider;
  String? get signInProvider => _signInProvider;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? timestamp;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String _appVersion = '0.0';
  String get appVersion => _appVersion;

  String _packageName = '';
  String get packageName => _packageName;

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }
  Future clearAllData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
  Future  afterUserSignOut ()async{
    await clearAllData();
    _isSignedIn = false;
    notifyListeners();
  }
  void checkSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _isSignedIn = sp.getBool('signed_in') ?? false;
    notifyListeners();
  }
  Future getTimestamp() async {
    DateTime now = DateTime.now();
    String timeStamp = DateFormat('yyyyMMddHHmmss').format(now);
    timestamp = timeStamp;
  }
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
  Future signUpwithEmailPassword (userName,userEmail, userPassword) async{
    try{
      var url = Uri.parse('https://sustainplanet.org/sp_app/public/register');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': userName,
          'email': userEmail,
          'password': userPassword,
        }),
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body) as Map<String, dynamic>;

        if (responseData['message'] == 'User created successfully') {
          print('Success: User created successfully');
          _name = userName;
          _id = responseData['user_id'].toString();
          _imageUrl = defaultUserImageUrl;
          _email = userEmail;
          _signInProvider = 'email';
          _isSignedIn = true;
          _hasError = false;
        } else {
          print('Error123: ${responseData['message']}');
          _errorCode = 'Invalid Credentials';
          _hasError = true;
        }
      } else {
        print('Error: Status code - ${response.statusCode}');
        _errorCode = 'Invalid Credentials';
        _hasError = true;
      }
    } catch (error) {
      print('Try Error111: $error');
      _errorCode = 'Invalid Credentials';
      _hasError = true;
    } finally {
      notifyListeners();
    }
  }
  Future<void> signInWithEmailPassword(String userEmail, String userPassword) async {
    try {
      var url = Uri.parse('https://sustainplanet.org/sp_app/public/login');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': userEmail,
          'password': userPassword,
        }),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body) as Map<String, dynamic>;

        if (responseData.containsKey('user')) {
          print('Success: User signed in successfully');
          _name = responseData['user']['name'];
          _id = responseData['user']['id'].toString();
          _imageUrl = responseData['user']['image_url'] ?? defaultUserImageUrl;
          _email = responseData['user']['email'];
          _signInProvider = 'email';
          _isSignedIn = true;
          _hasError = false;
        } else {
          print('Error: ${responseData['message']}');
          _hasError = true;
          _errorCode = responseData['message'];
        }
      } else {
        print('Error: Status code - ${response.statusCode}');
        _hasError = true;
        _errorCode = 'Invalid credentials';
      }
    } catch (error) {
      print('Try Error: $error');
      _hasError = true;
      _errorCode = error.toString();
    } finally {
      notifyListeners();
    }
  }
  Future saveDataToSP() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    await sp.setString('name', _name!);
    await sp.setString('email', _email!);
    await sp.setString('image_url', _imageUrl!);
    await sp.setString('id', _id!);
    await sp.setString('sign_in_provider', _signInProvider!);
  }
  // Future updateUserProfile(String profileName, String imagePath)async {
  //   final url = Uri.parse('https://sustainplanet.org/sp_app/public/profile/usernameUpdate');
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   sp.setString('name', profileName);
  //   sp.setString('image_url', imagePath);
  //   _name = profileName;
  //   _imageUrl = imagePath;
  //   notifyListeners();
  // }
  Future<void> updateUserProfile(String profileName, String? imagePath) async {
    try {
      final url = Uri.parse('https://sustainplanet.org/sp_app/public/profile/usernameUpdate');
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final accessToken = sp.getString('access_token');

      if (accessToken == null) {
        print('Error: Missing access token');
        _hasError = true;
        return;
      }

      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $accessToken'
        ..fields['name'] = profileName;

      if (imagePath != null && imagePath.isNotEmpty) {
        // Add image upload logic here
        // ...
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      // Follow redirects if needed
      if (response.statusCode == 302) {
        // Extract the redirect URL from the response headers
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          request = http.MultipartRequest('POST', Uri.parse(redirectUrl))
            ..fields['name'] = profileName;
          // Add image upload logic again if needed
          // ...
          response = await request.send();
          responseBody = await response.stream.bytesToString();
        } else {
          print('Error: Invalid redirect URL');
          _hasError = true;
          return;
        }
      }

      // Check final response status code
      if (response.statusCode == 200) {
        // ... (process successful response as before)
      } else {
        print('Error: Status code - ${response.statusCode}');
        _hasError = true;
      }
    } catch (error) {
      print('Error: $error');
      _hasError = true;
    } finally {
      notifyListeners();
    }
  }

  Future getDataFromSp () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _name = sp.getString('name');
    _email = sp.getString('email');
    _imageUrl = sp.getString('image_url');
    _id = sp.getString('id');
    _signInProvider = sp.getString('sign_in_provider');
    notifyListeners();
  }
}

// class SignInBloc extends ChangeNotifier {
//   SignInBloc(){
//    checkSignIn();
//    initPackageInfo();
//   }
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final String defaultUserImageUrl = 'https://www.oxfordglobal.co.uk/nextgen-omics-series-us/wp-content/uploads/sites/16/2020/03/Jianming-Xu-e5cb47b9ddeec15f595e7000717da3fe.png';
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   String? _name;
//   String? get name => _name;
//
//   bool _isSignedIn = false;
//   bool get isSignedIn => _isSignedIn;
//
//   String? _uid;
//   String? get uid => _uid;
//
//   String? _email;
//   String? get email => _email;
//
//   String? _imageUrl;
//   String? get imageUrl => _imageUrl;
//
//   String? _signInProvider;
//   String? get signInProvider => _signInProvider;
//
//   bool _hasError = false;
//   bool get hasError => _hasError;
//
//   String? _errorCode;
//   String? get errorCode => _errorCode;
//
//   String? timestamp;
//
//   String _appVersion = '0.0';
//   String get appVersion => _appVersion;
//
//   String _packageName = '';
//   String get packageName => _packageName;
//
//   void initPackageInfo() async {
//     try {
//       PackageInfo packageInfo = await PackageInfo.fromPlatform();
//       _appVersion = packageInfo.version;
//       _packageName = packageInfo.packageName;
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching package info: $e');
//       // Handle the error accordingly
//     }
//   }
//
//   Future signUpwithEmailPassword (userName,userEmail, userPassword) async{
//     try{
//       final User user = (await _firebaseAuth.createUserWithEmailAndPassword(email: userEmail,password: userPassword,)).user!;
//       await user.getIdToken();
//       _name = userName;
//       _uid = user.uid;
//       _imageUrl = defaultUserImageUrl;
//       _email = user.email;
//       _signInProvider = 'email';
//       _isSignedIn = true;
//       _hasError = false;
//       notifyListeners();
//     } on FirebaseAuthException catch(e){
//       _hasError = true;
//       if (e.code == 'weak-password') {
//         _errorCode = 'The password provided is too weak.';
//       }else if (e.code == 'email-already-in-use') {
//         _errorCode = 'The account already exists for that email.';
//       }
//     }catch (e) {
//       _errorCode = e.toString();
//       notifyListeners();
//     }
//   }
//   // Future signInWithEmailPassword (email, password) async {
//   //   UserCredential? userCredential;
//   //   try{
//   //     final User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)).user!;
//   //     await user.getIdToken();
//   //     _uid = FirebaseAuth.instance.currentUser!.uid;
//   //     _signInProvider = "email";
//   //     _hasError = false;
//   //     _isSignedIn = true;
//   //     print('is signin ${_isSignedIn}');
//   //     notifyListeners();
//   //   }catch(e){
//   //     _hasError = true;
//   //     _errorCode = e.toString();
//   //     notifyListeners();
//   //   }
//   // }
//   Future<UserCredential?> signInWithEmailPassword (email, password) async {
//     UserCredential? userCredential;
//     await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
//         .then((UserCredential user)async{
//       userCredential = user;
//       _uid = FirebaseAuth.instance.currentUser!.uid;
//       _signInProvider = "email";
//       _hasError = false;
//       _isSignedIn = true;
//       print('is signin ${_isSignedIn}');
//       notifyListeners();
//     }).catchError((e){
//       _hasError = true;
//       _errorCode = e.toString();
//       notifyListeners();
//     });
//     return userCredential;
//   }
//   Future signOut() async{
//     await FirebaseAuth.instance.signOut();
//   }
//   Future clearAllData() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.clear();
//   }
//   Future  afterUserSignOut ()async{
//     await clearAllData();
//     _isSignedIn = false;
//
//     notifyListeners();
//   }
//   Future saveToFirebase() async {
//     final DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(_uid);
//     var userData = {
//       'name': _name,
//       'email': _email,
//       'uid': _uid,
//       'image url': _imageUrl,
//       'timestamp': timestamp,
//       'loved items': [],
//       'bookmarked items': []
//     };
//     await ref.set(userData);
//   }
//
//
//   Future setSignIn() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.setBool('signed_in', true);
//     _isSignedIn = true;
//     notifyListeners();
//   }
//
//
//
//   void checkSignIn() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     _isSignedIn = sp.getBool('signed_in') ?? false;
//     notifyListeners();
//   }
//   Future getTimestamp() async {
//     DateTime now = DateTime.now();
//     String timeStamp = DateFormat('yyyyMMddHHmmss').format(now);
//     timestamp = timeStamp;
//   }
//
//   Future getUserDatafromFirebase(uid) async {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .get()
//         .then((DocumentSnapshot snap) {
//       _uid = snap['uid'];
//       _name = snap['name'];
//       _email = snap['email'];
//       _imageUrl = snap['image url'];
//       // print(_name);
//     });
//     notifyListeners();
//   }
//   Future updateUserProfile(String profileName, String imagePath)async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     FirebaseFirestore.instance.collection('users').doc(_uid).update({
//       'name': profileName,
//       'image url': imagePath
//     });
//     sp.setString('name', profileName);
//     sp.setString('image_url', imagePath);
//     _name = profileName;
//     _imageUrl = imagePath;
//     notifyListeners();
//   }
//   Future saveDataToSP() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//
//     await sp.setString('name', _name!);
//     await sp.setString('email', _email!);
//     await sp.setString('image_url', _imageUrl!);
//     await sp.setString('uid', _uid!);
//     await sp.setString('sign_in_provider', _signInProvider!);
//   }
//   Future getDataFromSp () async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     _name = sp.getString('name');
//     _email = sp.getString('email');
//     _imageUrl = sp.getString('image_url');
//     _uid = sp.getString('uid');
//     _signInProvider = sp.getString('sign_in_provider');
//     notifyListeners();
//   }
//
//   Future<int> getTotalUsersCount () async {
//     const String fieldName = 'count';
//     final DocumentReference ref = firestore.collection('item_count').doc('users_count');
//     DocumentSnapshot snap = await ref.get();
//     if(snap.exists == true){
//       int itemCount = snap[fieldName] ?? 0;
//       return itemCount;
//     }
//     else{
//       await ref.set({
//         fieldName : 0
//       });
//       return 0;
//     }
//   }
//   Future increaseUserCount () async {
//     await getTotalUsersCount()
//         .then((int documentCount)async {
//       await firestore.collection('item_count').doc('users_count').update({
//         'count' : documentCount + 1
//       });
//     });
//   }
//   Future decreaseUserCount () async {
//     await getTotalUsersCount()
//         .then((int documentCount)async {
//       await firestore.collection('item_count').doc('users_count').update({
//         'count' : documentCount - 1
//       });
//     });
//   }
//   Future deleteUserDatafromDatabase () async{
//     FirebaseFirestore _db = FirebaseFirestore.instance;
//     if (FirebaseAuth.instance.currentUser != null) {
//       await _db.collection('users').doc(uid).delete();
//       await FirebaseAuth.instance.currentUser!.delete();
//     }
//   }
//   Future userSignout() async {
//     await _firebaseAuth.signOut();
//   }
// }