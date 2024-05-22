import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../blocs/home_bloc.dart';
import '../blocs/signin_bloc.dart';


import '../models/article_model.dart';
import '../utils/next_screen.dart';
import '../widgets/bookmark_icon.dart';
import '../widgets/html_body.dart';
import '../widgets/love_count.dart';
import '../widgets/love_icon.dart';
import '../widgets/view_count.dart';
import 'comments.dart';

class ArticleDetail extends StatefulWidget{
  final PostModel? data;
  final String? tag;

  const ArticleDetail({super.key, required this.data, required this.tag});


  @override
  State<ArticleDetail> createState(){
    return ArticleDetailState();
  }
}
class ArticleDetailState extends State<ArticleDetail>{
  void _handleShare(){
    final sb = context.read<PostProvider>();
    final String _androidLink = '${widget.data!.postTitle}, Check out this app to explore more. App link: https://play.google.com/store/apps/details?id=${sb.packageName}';
    Share.share(_androidLink);
  }
  handleLoveClick(){
    // bool checker = context.read<SignInBloc>().isSignedIn;
    // if(!checker){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: const Text('Sign in first to access this feature'),
              content: const Text('You haven\'t signed in yet. \n Please sign in to unlock this feature'),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('OK')
                )
              ],
            );
          });
    // }else {
    //   context.read<HomeBloc>().onLoveIconClick(widget.data!.timestamp);
    // }
  }
  handleBookmarkClick(){
    // bool bookChecker = context.read<SignInBloc>().isSignedIn;
    // if(!bookChecker){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: const Text('Sign in first to access this feature'),
              content: const Text('You haven\'t signed in yet. \n Please sign in to unlock this feature'),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('OK')
                )
              ],
            );
          });
    // }else {
    //   context.read<HomeBloc>().onBookmarkIconClick(widget.data!.timestamp, context);
    // }
  }
  @override
  Widget build(BuildContext context){
    // final sb = context.watch<SignInBloc>();
    final PostModel article = widget.data!;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, index) {
          return [
            SliverAppBar(
              pinned: false,
              expandedHeight: 270,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,color: Colors.white,size: 24,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: IconButton(
                    icon: const Icon(Icons.share,color: Colors.white,size: 24,),
                    onPressed: (){
                      _handleShare();
                    },
                  ),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: widget.tag == null ? CachedNetworkImage(
                  imageUrl: article.postImage, // Use the article's image URL here
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey[300]),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  ),
                ) : Hero(
                    tag: widget.tag!,
                    child: CachedNetworkImage(
                      imageUrl: article.postImage, // Use the article's image URL here
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey[300]),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      ),
                    )
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey[300],
                      ),
                      child: Text(article.postCategory,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        // IconButton(
                        //   icon: BuildLoveIcon(
                        //       uid: sb.uid,
                        //       timestamp: article.timestamp),
                        //   onPressed: (){
                        //     handleLoveClick();
                        //   },
                        // ),
                        const SizedBox(width: 25,),
                        // IconButton(
                        //     onPressed: (){
                        //       handleBookmarkClick();
                        //     },
                        //     icon: BuildBookmarkIcon(
                        //         uid: sb.uid,
                        //         timestamp: article.timestamp
                        //     )
                        // ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.calendar_month,size: 20,color: Colors.grey,),
                    const SizedBox(width: 5,),
                    Text(DateFormat('dd MMMM yy').format(article.postDate),style: const TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.w400),),
                    // const SizedBox(width: 15,),
                    // const Icon(Icons.watch_later_outlined,size: 20,color: Colors.grey,),
                    // const SizedBox(width: 5,),
                    // const Text('2 min read',style: TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.w400),)
                  ],
                ),
                const SizedBox(height: 8,),
                Text(article.postTitle,
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,height: 1.3),
                ),
                const SizedBox(height: 3,),
                const Divider(thickness: 2,color: Colors.deepPurple,endIndent: 180,),
                TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.deepPurple),
                    shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                    padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(horizontal: 12,vertical: 8))
                  ),
                    onPressed: (){
                    // nextScreen(context, Comments(timestamp: article.timestamp));
                    },
                    label: const Text('Comments',style: TextStyle(fontSize: 15,color: Colors.white),),
                    icon: const Icon(Icons.comment,color: Colors.white,size: 18,),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    // ViewCount(article: article),
                    const SizedBox(width: 15,),
                    // LoveCount(timestamp: article.timestamp)
                  ],
                ),
                const SizedBox(height: 15,),
                HtmlBodyWidget(
                  content: article.postContent,
                  isIframeVideoEnabled: true,
                  isVideoEnabled: true,
                  isimageEnabled: true,
                ),
                // Text(article.postContent,
                //   style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.black54,height: 1.5),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





