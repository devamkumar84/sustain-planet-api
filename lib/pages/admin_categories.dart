import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../blocs/admin_bloc.dart';
import '../models/category_model.dart';
import '../utils/empty.dart';
import '../utils/uihelper.dart';

// class Categories extends StatefulWidget {
//   const Categories({Key? key}) : super(key: key);
//
//   @override
//   _CategoriesState createState() => _CategoriesState();
// }

// class _CategoriesState extends State<Categories> {
//
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   ScrollController? controller;
//   DocumentSnapshot? _lastVisible;
//   late bool _isLoading;
//   List<DocumentSnapshot> _snap = [];
//   List<Category> _data = [];
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final String collectionName = 'categories';
//   bool? _hasData;
//
//   @override
//   void initState() {
//     controller = new ScrollController()..addListener(_scrollListener);
//     super.initState();
//     _isLoading = true;
//     _getData();
//   }
//
//
//
//
//   Future<Null> _getData() async {
//     QuerySnapshot data;
//     if (_lastVisible == null)
//       data = await firestore
//           .collection(collectionName)
//           .orderBy('timestamp', descending: true)
//           .limit(10)
//           .get();
//     else
//       data = await firestore
//           .collection(collectionName)
//           .orderBy('timestamp', descending: true)
//           .startAfter([_lastVisible!['timestamp']])
//           .limit(10)
//           .get();
//
//     if (data.docs.length > 0) {
//       _lastVisible = data.docs[data.docs.length - 1];
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//           _hasData = true;
//           _snap.addAll(data.docs);
//           _data = _snap.map((e) => Category.fromFirestore(e)).toList();
//         });
//       }
//     } else {
//       if(_lastVisible == null){
//         setState(() {
//           _isLoading = false;
//           _hasData = false;
//         });
//       }else{
//         setState(() {
//           _isLoading = false;
//           _hasData = true;
//         });
//         openToast(context, 'No more content available');
//         print('No more content available');
//
//       }
//     }
//     return null;
//   }
//
//   @override
//   void dispose() {
//     controller!.dispose();
//     super.dispose();
//   }
//
//   void _scrollListener() {
//     if (!_isLoading) {
//       if (controller!.position.pixels == controller!.position.maxScrollExtent) {
//         setState(() => _isLoading = true);
//         _getData();
//       }
//     }
//   }
//
//
//   refreshData ()async{
//     setState(() {
//       _data.clear();
//       _snap.clear();
//       _lastVisible = null;
//     });
//     await _getData();
//   }
//
//
//
//
//
//
//   handleDelete(timestamp1) {
//     final AdminBloc ab = Provider.of<AdminBloc>(context, listen: false);
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return SimpleDialog(
//             contentPadding: const EdgeInsets.all(20),
//             elevation: 0,
//             children: <Widget>[
//               const Text('Delete?',
//
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600)),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text('Want to delete this item from the database?',
//
//                   style: TextStyle(
//                       color: Colors.grey[900],
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400)),
//               const SizedBox(
//                 height: 30,
//               ),
//               Center(
//                   child: Row(
//                     children: <Widget>[
//                       TextButton(
//                         style: buttonStyle(Colors.redAccent),
//                         child: const Text(
//                           'Yes',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         onPressed: ()async{
//
//
//                           if (ab.isAdmin == false) {
//                             Navigator.pop(context);
//                             // openDialog(context, 'You are a Tester','Only admin can delete contents');
//                           } else {
//                             await ab.deleteContent(timestamp1, collectionName)
//                                 .then((value) => ab.getCategories())
//                                 .then((value) => ab.decreaseCount('categories_count'))
//                                 .then((value) => openToast(context, 'Deleted Successfully'));
//                             refreshData();
//                             Navigator.pop(context);
//
//
//                           }
//                         },
//                       ),
//
//                       const SizedBox(width: 10),
//
//                       TextButton(
//                         style: buttonStyle(Colors.deepPurpleAccent),
//                         child: const Text(
//                           'No',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ],
//                   )
//               )
//             ],
//           );
//
//         });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.10,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Categories',
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 40,
//                   padding: const EdgeInsets.only(left: 15, right: 15),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       border: Border.all(color: Colors.grey[300]!),
//                       borderRadius: BorderRadius.circular(30)),
//                   child: TextButton.icon(
//                       onPressed: (){
//                         openAddDialog();
//                       },
//                       icon: const Icon(Icons.list),
//                       label: const Text('Add Category')),
//
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 0,
//             ),
//             Expanded(
//               child: _hasData == false
//                   ? const EmptyPage(icon: Icons.content_paste, message: '', message1: 'No categories found.\nUpload categories first!')
//
//                   : RefreshIndicator(
//                 child: ListView.separated(
//                   padding: const EdgeInsets.only(top: 30, bottom: 20),
//                   controller: controller,
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   itemCount: _data.length + 1,
//                   separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
//                   itemBuilder: (_, int index) {
//                     if (index < _data.length) {
//                       return dataList(_data[index]);
//                     }
//                     if(_isLoading){
//                       return const Center(
//                         child: Opacity(
//                           opacity: 1.0,
//                           child: SizedBox(
//                               width: 32.0,
//                               height: 32.0,
//                               child: CircularProgressIndicator()),
//                         ),
//                       );
//                     }
//                     return Container();
//                   },
//                 ),
//                 onRefresh: () async {
//                   await refreshData();
//
//
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
//   Widget dataList(Category d) {
//     return Container(
//       height: 130,
//       padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
//       decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(10),
//           image: DecorationImage(
//               image: CachedNetworkImageProvider(d.thumbnailUrl!),
//               fit: BoxFit.cover
//           )
//       ),
//
//       child:
//
//       Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(d.name!, style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w500,
//               color: Colors.white
//           ),),
//           // Spacer(),
//           const SizedBox(height: 10,),
//           Row(
//             children: [
//               InkWell(
//                 child: Container(
//                     height: 35,
//                     width: 35,
//                     decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Icon(Icons.edit, size: 16, color: Colors.grey[800])),
//                 onTap: () => openEditDialog(d.name!, d.thumbnailUrl!, d.timestamp!),
//               ),
//               const SizedBox(width: 10,),
//               InkWell(
//                   child: Container(
//                       height: 35,
//                       width: 35,
//                       decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Icon(Icons.delete, size: 16, color: Colors.grey[800])),
//                   onTap: () {
//                     handleDelete(d.timestamp);
//                   }),
//             ],
//           )
//         ],
//       ),
//
//
//     );
//   }
//
//
//
//
//   // add/upload Category
//
//   var formKey = GlobalKey<FormState>();
//   var nameCtrl = TextEditingController();
//   var thumbnailCtrl = TextEditingController();
//   String? timestamp;
//
//
//   Future addCategory () async{
//     final DocumentReference ref = firestore.collection(collectionName).doc(timestamp);
//     await ref.set({
//       'name' : nameCtrl.text,
//       'thumbnail' : thumbnailCtrl.text,
//       'timestamp' : timestamp
//     });
//   }
//
//
//
//
//
//   handleAddCategory () async{
//     final AdminBloc ab  = Provider.of<AdminBloc>(context, listen: false);
//     if(formKey.currentState!.validate()){
//       formKey.currentState!.save();
//       if (ab.isAdmin == false) {
//         Navigator.pop(context);
//         // openDialog(context, 'You are a Tester', 'Only admin can add contents');
//       } else {
//         await getTimestamp()
//             .then((value) => addCategory())
//             .then((value) => context.read<AdminBloc>().increaseCount('categories_count'))
//             .then((value) => openToast(context, 'Added Successfully'))
//             .then((value) => ab.getCategories());
//         refreshData();
//         Navigator.pop(context);
//       }
//
//
//     }
//   }
//
//
//   clearTextfields (){
//     nameCtrl.clear();
//     thumbnailCtrl.clear();
//   }
//
//
//
//   Future getTimestamp() async {
//     DateTime now = DateTime.now();
//     String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
//     setState(() {
//       timestamp = _timestamp;
//     });
//
//   }
//
//
//
//   openAddDialog (){
//     showDialog(
//         context: context,
//         builder: (context){
//           return SimpleDialog(
//             contentPadding: const EdgeInsets.all(20),
//             children: <Widget>[
//               const Text('Add Category to Database', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
//               const SizedBox(height: 20,),
//               Form(
//                   key: formKey,
//                   child: Column(children: <Widget>[
//                     TextFormField(
//                       decoration: inputDecoration('Enter Category Name', 'Category Name', nameCtrl),
//                       controller: nameCtrl,
//                       validator: (value) {
//                         if (value!.isEmpty) return 'Name is empty';
//                         return null;
//                       },
//
//                     ),
//
//
//
//                     const SizedBox(height: 20,),
//
//                     TextFormField(
//                       decoration: inputDecoration('Enter Thumbnail Url', 'Thumbnail Url', thumbnailCtrl),
//                       controller: thumbnailCtrl,
//                       validator: (value) {
//                         if (value!.isEmpty) return 'Thumbnail url is empty';
//                         return null;
//                       },
//
//                     ),
//
//
//
//
//
//
//
//
//                     const SizedBox(height: 20,),
//
//                     Center(
//                         child: Column(
//                           children: <Widget>[
//
//
//                             TextButton(
//
//                               style: buttonStyle(Colors.purpleAccent),
//                               child: const Text(
//                                 'Add Category',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               onPressed: ()async{
//
//
//                                 await handleAddCategory();
//                                 clearTextfields();
//
//
//
//
//                               },
//                             ),
//
//                             const SizedBox(height: 10),
//
//                             TextButton(
//                               style: buttonStyle(Colors.redAccent),
//                               child: const Text(
//                                 'Cancel',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                           ],
//                         )
//                     )
//                   ],)
//               )
//             ],
//           );
//
//         }
//     );
//   }
//
//
//
//   //update/edit category
//
//   var nameCtrl1 = TextEditingController();
//   var thumbnailCtrl1 = TextEditingController();
//   var formKey1 = GlobalKey<FormState>();
//
//
//
//   Future _updateCategory (String categoryTimestamp) async{
//     final DocumentReference ref = firestore.collection(collectionName).doc(categoryTimestamp);
//     await ref.update({
//       'name' : nameCtrl1.text,
//       'thumbnail' : thumbnailCtrl1.text,
//     });
//   }
//
//
//   Future _handleUpdateCategory (String categoryTimestamp) async{
//     final AdminBloc ab  = Provider.of<AdminBloc>(context, listen: false);
//     if(formKey1.currentState!.validate()){
//       formKey1.currentState!.save();
//       if (ab.isAdmin == false) {
//         Navigator.pop(context);
//         // openDialog(context, 'You are a Tester', 'Only admin can add contents');
//       } else {
//         await _updateCategory(categoryTimestamp)
//             .then((value) => openToast(context, 'Updated Successfully'))
//             .then((value) => ab.getCategories());
//         refreshData();
//         Navigator.pop(context);
//       }
//
//
//     }
//   }
//
//
//   void openEditDialog (String oldCategoryName, String oldThumbnailUrl, String categoryTimestamp){
//     showDialog(
//         context: context,
//         builder: (context){
//           nameCtrl1.text = oldCategoryName;
//           thumbnailCtrl1.text = oldThumbnailUrl;
//
//           return SimpleDialog(
//             contentPadding: const EdgeInsets.all(20),
//             children: <Widget>[
//               const Text('Edit/Update Category to Database', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
//               const SizedBox(height: 20,),
//               Form(
//                   key: formKey1,
//                   child: Column(children: <Widget>[
//                     TextFormField(
//                       decoration: inputDecoration('Enter Category Name', 'Category Name', nameCtrl1),
//                       controller: nameCtrl1,
//                       validator: (value) {
//                         if (value!.isEmpty) return 'Name is empty';
//                         return null;
//                       },
//
//                     ),
//
//
//
//                     const SizedBox(height: 20,),
//
//                     TextFormField(
//                       decoration: inputDecoration('Enter Thumbnail Url', 'Thumbnail Url', thumbnailCtrl1),
//                       controller: thumbnailCtrl1,
//                       validator: (value) {
//                         if (value!.isEmpty) return 'Thumbnail url is empty';
//                         return null;
//                       },
//
//                     ),
//
//                     const SizedBox(height: 20,),
//
//                     Center(
//                         child: Column(
//                           children: <Widget>[
//
//
//                             TextButton(
//
//                               style: buttonStyle(Colors.purpleAccent),
//                               child: const Text(
//                                 'Update Category',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               onPressed: ()async{
//
//
//                                 _handleUpdateCategory(categoryTimestamp);
//
//
//
//
//                               },
//                             ),
//
//                             const SizedBox(height: 10),
//
//                             TextButton(
//                               style: buttonStyle(Colors.redAccent),
//                               child: const Text(
//                                 'Cancel',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                           ],
//                         )
//                     )
//                   ],)
//               )
//             ],
//           );
//
//         }
//     );
//   }
//
//
// }