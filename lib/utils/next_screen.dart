import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../models/notification_model.dart';
import '../pages/article_detail.dart';
import '../pages/custom_notification_detail.dart';
import '../pages/post_notification_detail.dart';

void nextScreen (context, page){
  Navigator.push(context, MaterialPageRoute(
      builder: (context) => page));
}


void nextScreeniOS (context, page){
  Navigator.push(context, CupertinoPageRoute(
      builder: (context) => page));
}


void nextScreenCloseOthers (context, page){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

void nextScreenReplace (context, page){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
}


void nextScreenPopup (context, page){
  Navigator.push(context, MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => page),
  );
}

void navigateToDetailsScreen (context, PostModel posts, String? heroTag){
  Navigator.push(context, MaterialPageRoute(
      builder: (context) => ArticleDetail(data: posts, tag: heroTag,)),
  );
}


void navigateToDetailsScreenByReplace (context, PostModel post, String? heroTag, bool? replace){
  if(replace == null || replace == false){
    navigateToDetailsScreen(context, post, heroTag);
  }else{
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => ArticleDetail(data: post, tag: heroTag,)),
    );
  }
}


void navigateToNotificationDetailsScreen (context, NotificationModel notificationModel){
  if(notificationModel.postId == null){
    nextScreen(context, CustomNotificationDeatils(notificationModel: notificationModel));
  }else{
    // nextScreen(context, PostNotificationDetails(postID: notificationModel.postId!));
  }
}