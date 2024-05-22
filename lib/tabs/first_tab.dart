import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sustain_planet_api_app/blocs/admin_bloc.dart';
import 'package:sustain_planet_api_app/services/app_service.dart';
import '../blocs/home_bloc.dart';
import '../pages/more_article.dart';
import '../utils/next_screen.dart';
import '../widgets/featured_article_widget.dart';
import '../widgets/popular_article_widget.dart';
import '../widgets/recent_article_widget.dart';

class FirstTab extends StatefulWidget{
  const FirstTab({super.key});

  @override
  State<FirstTab> createState() => FirstTabState();
}
class FirstTabState extends State<FirstTab>{

  @override
  Widget build(BuildContext context){
    return RefreshIndicator(
      onRefresh: () async{
        await AppService().checkInternet().then((hasInternet){
          if(hasInternet == false){
            openToast(context, 'No Internet');
          }else {
            context.read<PostProvider>().onPopularDataRefresh();
            context.read<PostProvider>().onRecentDataRefresh();
          }
        });
      },
      child: SingleChildScrollView(
          padding: EdgeInsets.all(0),
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            color: Colors.white,
            // height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                FeaturedArticle(),
                PopularArticle(),
                RecentArticle(),
              ],
            ),
          )),
    );
  }
}