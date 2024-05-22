// import 'package:cloud_firestore/cloud_firestore.dart';

class Article {

  String? category;
  String? contentType;
  String? title;
  String? description;
  String? thumbnailImagelUrl;
  String? youtubeVideoUrl;
  String? videoID;
  int? loves;
  String? sourceUrl;
  String? date;
  String? timestamp;
  int? views;
  String? readingTime;

  Article({
    this.category,
    this.contentType,
    this.title,
    this.description,
    this.thumbnailImagelUrl,
    this.youtubeVideoUrl,
    this.videoID,
    this.loves,
    this.sourceUrl,
    this.date,
    this.timestamp,
    this.views,
    this.readingTime
  });

  // factory Article.fromFirestore(DocumentSnapshot snapshot){
  //   Map d = snapshot.data() as Map<dynamic, dynamic>;
  //   return Article(
  //       category: d['category'],
  //       contentType: d['content type'],
  //       title: d['title'],
  //       description: d['description'],
  //       thumbnailImagelUrl: d['image url'],
  //       youtubeVideoUrl: d['youtube url'],
  //       videoID: d['content type'] == 'video'? d['youtube url'] : '',
  //       loves: d['loves'],
  //       sourceUrl: d['source'],
  //       date: d['date'],
  //       timestamp: d['timestamp'],
  //       views: d['views'] ?? null,
  //   );
  // }
}

// class PostModel {
//   final String postTitle;
//   final String postContent;
//   final String postDate;
//   final String postImage;
//
//   PostModel({required this.postTitle, required this.postContent, required this.postDate, required this.postImage});
// }
class PostModel {
  final String postTitle;
  final String postContent;
  final DateTime postDate;
  final String postImage;
  final String postCategory;

  PostModel({
    required this.postTitle,
    required this.postContent,
    required this.postDate,
    required this.postImage,
    required this.postCategory,
  });

  // Factory constructor to handle null postImage values
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postTitle: json['post_title'],
      postContent: json['post_content'],
      postDate: DateTime.parse(json['post_date']),
      postImage: json['post_image'] ?? '',
      postCategory: json['post_category'] ?? '',
    );
  }
}

