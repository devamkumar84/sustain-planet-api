// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../models/notification_model.dart';
import '../utils/next_screen.dart';

// class NotificationService {
//
//
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//
//
//
//   Future _handleIosNotificationPermissaion () async {
//     NotificationSettings settings = await _fcm.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       debugPrint('User granted permission');
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       debugPrint('User granted provisional permission');
//     } else {
//       debugPrint('User declined or has not accepted permission');
//     }
//   }
//
//
//
//
//
//   Future initFirebasePushNotification(context) async {
//     await _handleIosNotificationPermissaion();
//     String? token = await _fcm.getToken();
//     debugPrint('User FCM Token : $token');
//
//     RemoteMessage? initialMessage = await _fcm.getInitialMessage();
//     debugPrint('inittal message : $initialMessage');
//     if (initialMessage != null) {
//       await saveNotificationData(initialMessage).then((value) => _navigateToDetailsScreen(context, initialMessage));
//     }
//
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       debugPrint('onMessage: ${message.data}');
//       await saveNotificationData(message).then((value) => _handleOpenNotificationDialog(context, message));
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       await saveNotificationData(message).then((value) => _navigateToDetailsScreen(context, message));
//     });
//   }
//
//
//
//   Future _handleOpenNotificationDialog(context, RemoteMessage message) async {
//     DateTime now = DateTime.now();
//     String timestamp = DateFormat('yyyyMMddHHmmss').format(now);
//     NotificationModel notificationModel = NotificationModel(
//       date: DateTime.now(),
//       description: message.data['description'],
//       postId: message.data['post_id'],
//       thumbnailUrl: message.data['image_url'],
//       timestamp: timestamp,
//       title: message.notification!.title,
//       subTitle: message.notification!.body,
//     );
//     showDialog(
//         context: context,
//         builder: (_) {
//           return AlertDialog(
//             scrollable: false,
//             contentPadding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
//             content: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     CircleAvatar(
//                       radius: 12,
//                       backgroundColor: Theme.of(context).primaryColor,
//                       child: const Icon(Icons.notifications_none, size: 16, color: Colors.white),
//                     ),
//                     const SizedBox(width: 10,),
//                     Text(
//                       'New Notification Alert!',
//                       style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.primary),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   notificationModel.title.toString(),
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,
//                       color: Theme.of(context).colorScheme.primary
//                   ),
//                 ),
//                 const SizedBox(height: 15,),
//                 Text(
//                     notificationModel.description!,
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 3,
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: Theme.of(context).colorScheme.secondary
//                     )
//                 ),
//               ],
//             ),
//
//
//             actions: [
//               TextButton(
//                 child: const Text('Open'),
//                 onPressed: (){
//                   Navigator.pop(context);
//                   navigateToNotificationDetailsScreen(context, notificationModel);
//                 },
//               ),
//               TextButton(
//                 child: const Text('Close'),
//                 onPressed: (){
//                   Navigator.pop(context);
//                 },
//               )
//             ],
//           );
//         });
//   }
//
//
//   Future _navigateToDetailsScreen(context, RemoteMessage message) async {
//     DateTime now = DateTime.now();
//     String timestamp = DateFormat('yyyyMMddHHmmss').format(now);
//     NotificationModel notificationModel = NotificationModel(
//         timestamp: timestamp,
//         date: DateTime.now(),
//         title: message.notification!.title,
//         description: message.data['description'],
//         postId: message.data['post_id'],
//         thumbnailUrl: message.data['image_url'],
//         subTitle: message.notification!.body
//     );
//     navigateToNotificationDetailsScreen(context, notificationModel);
//   }
//
//
//
//   Future saveNotificationData(RemoteMessage message) async {
//     final list = Hive.box('notifications');
//     DateTime now = DateTime.now();
//     String timestamp = DateFormat('yyyyMMddHHmmss').format(now);
//     Map<String, dynamic> notificationData = {
//       'timestamp': timestamp,
//       'date': DateTime.now(),
//       'title': message.notification!.title,
//       'body': message.data['description'],
//       'post_id': message.data['post_id'],
//       'image': message.data['image_url'],
//       'subtitle': message.notification!.body,
//     };
//
//     await list.put(timestamp, notificationData);
//   }
//
//
//
//   Future deleteNotificationData(key) async {
//     final notificationList = Hive.box('notifications');
//     await notificationList.delete(key);
//   }
//
//
//
//   Future deleteAllNotificationData() async {
//     final notificationList = Hive.box('notifications');
//     await notificationList.clear();
//   }
//
//   Future<bool?> checkingPermisson ()async{
//     bool? accepted;
//     await _fcm.getNotificationSettings().then((NotificationSettings settings)async{
//       if(settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional){
//         accepted = true;
//       }else{
//         accepted = false;
//       }
//     });
//     return accepted;
//   }
//
//   Future subscribe ()async{
//     await _fcm.subscribeToTopic('all');
//   }
//
//   Future unsubscribe ()async{
//     await _fcm.unsubscribeFromTopic('all');
//   }
//
//
// }