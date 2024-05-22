import 'package:app_settings/app_settings.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/notification_service.dart';

// class NotificationBloc extends ChangeNotifier {
//
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//
//
//   bool _subscribed = false;
//   bool get subscribed => _subscribed;
//
//
//   Future checkPermission ()async{
//     await NotificationService().checkingPermisson().then((bool? accepted)async{
//       if(accepted != null && accepted){
//         checkSubscription();
//       }else{
//         await SPService().setNotificationSubscription(false);
//         _subscribed = false;
//         notifyListeners();
//       }
//     });
//   }
//
//   Future checkSubscription ()async{
//     await SPService().getNotificationSubscription().then((bool value)async{
//       if(value){
//         await NotificationService().subscribe();
//         _subscribed = true;
//       }else{
//         await NotificationService().unsubscribe();
//         _subscribed = false;
//       }
//     });
//     notifyListeners();
//   }
//
//   handleSubscription (context, bool newValue) async{
//     if(newValue){
//       await NotificationService().checkingPermisson().then((bool? accepted)async{
//         if(accepted != null && accepted){
//           await NotificationService().subscribe();
//           await SPService().setNotificationSubscription(newValue);
//           _subscribed = true;
//           notifyListeners();
//         }else{
//           showDialog(context: context, builder: (context)=> AlertDialog(
//             title: const Text('Allow Notifications from Settings'),
//             content: const Text('You need to allow notifications from your settings first to enable this'),
//             actions: [
//               TextButton(
//                 child: const Text('Close'),
//                 onPressed: ()=> Navigator.pop(context),
//               ),
//               TextButton(
//                 child: const Text('Open Settings'),
//                 onPressed: (){
//                   Navigator.pop(context);
//                   AppSettings.openAppSettings(type: AppSettingsType.notification);
//                 },
//               ),
//             ],
//           ));
//         }
//       });
//     }else{
//       await NotificationService().unsubscribe();
//       await SPService().setNotificationSubscription(newValue);
//       _subscribed = newValue;
//       notifyListeners();
//     }
//   }
//
//
// }

class SPService {

  Future clearLocalData () async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future setNotificationSubscription (bool value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('n_subscribe', value);
  }

  Future<bool> getNotificationSubscription () async{
    final prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool('n_subscribe') ?? true;
    return value;
  }
}