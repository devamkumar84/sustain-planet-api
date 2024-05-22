import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../utils/empty.dart';
import '../utils/next_screen.dart';
import '../models/notification_model.dart';
import '../services/notification_service.dart';

class NotificationAlert extends StatefulWidget{
  @override
  State<NotificationAlert> createState()=> NotificationState();
}
class NotificationState extends State<NotificationAlert>{
  final notificationList = Hive.box('notifications');
  void _openClearAllDialog (){
    showModalBottomSheet(
        elevation: 2,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
        )),
        context: context, builder: (context){
      return Container(
        padding: const EdgeInsets.all(20),
        height: 210,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Clear all notification dialog',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.6,
                  wordSpacing: 1
              ),),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.resolveWith((states) => const Size(100, 50)),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Theme.of(context).primaryColor),
                      shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ))

                  ),
                  onPressed: (){
                    // NotificationService().deleteAllNotificationData();
                    Navigator.pop(context);
                  },
                  child: const Text('Yes', style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),),
                ),

                const SizedBox(width: 20,),

                TextButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.resolveWith((states) => const Size(100, 50)),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey[400]),
                      shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ))

                  ),
                  onPressed: ()=> Navigator.pop(context),
                  child: const Text('Cancel', style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),),
                )
              ],
            ),


          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification',style:  TextStyle(fontWeight: FontWeight.w500,fontSize: 21),),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              _openClearAllDialog();
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith(
                        (states) => const EdgeInsets.only(right: 15, left: 15))),
            child: const Text('clear all', style: TextStyle(
                color: Colors.black87,fontSize: 15)),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
                valueListenable: notificationList.listenable(),
                builder: (BuildContext context, dynamic value, Widget? child) {
                  List items = notificationList.values.toList();
                  items.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
                  if (items.isEmpty) {
                    return const EmptyPage(icon: Icons.notifications_off_outlined, message: 'No notifications found!', message1: 'You haven\'t received any notifications yet.\n Make sure you have turned on thr notifications from the settings.');
                  }
                  return Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 30),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                      itemBuilder: (BuildContext context, int index) {

                        final NotificationModel notificationModel = NotificationModel(
                          timestamp: items[index]['timestamp'],
                          date: items[index]['date'],
                          title: items[index]['title'],
                          description: items[index]['body'],
                          postId: items[index]['post_id'],
                          thumbnailUrl: items[index]['image'],
                          subTitle: items[index]['subtitle'] ?? '',

                        );

                        // final String timeAgo = Jiffy(notificationModel.date).fromNow();
                        DateTime notificationDate = notificationModel.date ?? DateTime.now();
                        final String timeAgo = timeago.format(notificationDate);

                        if(notificationModel.postId== null){
                          return InkWell(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(
                                              notificationModel.title!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,),
                                            )),
                                        IconButton(
                                            constraints: const BoxConstraints(minHeight: 40),
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.all(0),
                                            icon: const Icon(
                                              Icons.close,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              // NotificationService().deleteNotificationData(notificationModel.timestamp);
                                            } )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(notificationModel.description!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600])),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          CupertinoIcons.time,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          timeAgo,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                navigateToNotificationDetailsScreen(context, notificationModel);
                              });
                        }else{
                          return InkWell(
                              child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          notificationModel.thumbnailUrl == '' ? Container() :
                                          SizedBox(
                                              height: 80,
                                              width: 90,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(5),
                                                      topRight: Radius.circular(5),

                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: notificationModel.thumbnailUrl!,
                                                    fit: BoxFit.cover,
                                                    height: MediaQuery.of(context).size.height,
                                                    placeholder: (context, url) => Container(color: Colors.grey[300]),
                                                    errorWidget: (context, url, error) => Container(
                                                      color: Colors.grey[300],
                                                      child: const Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 70,
                                          padding: const EdgeInsets.only(top: 0, bottom: 0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notificationModel.title!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16, fontWeight: FontWeight.w500),
                                              ),
                                              const SizedBox(height: 5,),
                                              // Spacer(),
                                              Expanded(
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      const Icon(
                                                        CupertinoIcons.time,
                                                        size: 18,
                                                        color: Colors.grey,
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(timeAgo,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.grey)),
                                                      const Spacer(),
                                                      IconButton(
                                                          alignment: Alignment.centerRight,
                                                          icon: const Icon(Icons.close, size: 18),
                                                          onPressed: (){
                                                            // NotificationService().deleteNotificationData(notificationModel.timestamp);
                                                          }),
                                                    ]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              onTap: () {
                                navigateToNotificationDetailsScreen(context, notificationModel);
                              }
                          );
                        }


                      },
                    ),
                  );

                }),
          ],
        ),
      ),
    );
  }
}
