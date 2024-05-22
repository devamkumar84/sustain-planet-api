import 'package:flutter/material.dart';
// import 'package:jiffy/jiffy.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/notification_model.dart';

class CustomNotificationDeatils extends StatelessWidget {
  const CustomNotificationDeatils({Key? key, required this.notificationModel})
      : super(key: key);

  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    // final String dateTime = Jiffy(notificationModel.date).fromNow();
    DateTime notificationDate = notificationModel.date ?? DateTime.now();
    final String dateTime = timeago.format(notificationDate);
    return Scaffold(
      appBar: AppBar(
        title: const Text('notification details'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.watch_later_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  dateTime,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              notificationModel.title!,
              style: const TextStyle(
                fontFamily: 'Manrope',
                wordSpacing: 1,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 2,
              height: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              notificationModel.description!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            // HtmlBodyWidget(
            //     content: notificationModel.description.toString(),
            //     isVideoEnabled: true,
            //     isimageEnabled: true,
            //     isIframeVideoEnabled: true),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}