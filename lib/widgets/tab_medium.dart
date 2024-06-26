import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/home_bloc.dart';
import '../blocs/tab_index_bloc.dart';
import '../tabs/fifth_tab.dart';
import '../tabs/first_tab.dart';
import '../tabs/fourth_tab.dart';
import '../tabs/second_tab.dart';
import '../tabs/third_tab.dart';

class TabMedium extends StatefulWidget{
  final ScrollController? sc;
  final TabController? tc;

  const TabMedium({super.key, required this.sc, required this.tc});
  @override
  State<TabMedium> createState()=> TabMediumState();
}
class TabMediumState extends State<TabMedium>{
  @override
  void initState() {
    super.initState();
    widget.sc!.addListener(_scrollListener);
  }
  void _scrollListener() {
    final sb = context.read<TabIndexBloc>();
    final db = Provider.of<PostProvider>(context, listen: false);

    if (sb.tabIndex == 0) {
      if (!db.isLoading) {
        if (widget.sc!.offset >= widget.sc!.position.maxScrollExtent &&
            !widget.sc!.position.outOfRange) {
          db.loadMorePosts(true);
          db.fetchPostsRecent();
        }
      }
    }
    else if(sb.tabIndex == 1){
      if (!db.isHealthLoading) {
        if (widget.sc!.offset >= widget.sc!.position.maxScrollExtent &&
            !widget.sc!.position.outOfRange) {
          // db.setLoading(true);
          db.loadMoreHealthData();
        }
      }
    }
    else if(sb.tabIndex == 2){
      if (!db.isFoodLoading) {
        if (widget.sc!.offset >= widget.sc!.position.maxScrollExtent &&
            !widget.sc!.position.outOfRange) {
          db.loadMoreFoodData();
        }
      }
    }
    else if(sb.tabIndex == 3){
      if (!db.isBioLoading) {
        if (widget.sc!.offset >= widget.sc!.position.maxScrollExtent &&
            !widget.sc!.position.outOfRange) {
          db.loadMoreBioData();
        }
      }
    }else if(sb.tabIndex == 4){
      if (!db.isOceanLoading) {
        if (widget.sc!.offset >= widget.sc!.position.maxScrollExtent &&
            !widget.sc!.position.outOfRange) {
          db.loadMoreOceanData();
        }
      }
    }

  }
  @override
  Widget build(BuildContext context){
    return TabBarView(
      controller: widget.tc,
      children: const <Widget>[
        FirstTab(),
        SecondTab(),
        ThirdTab(),
        FourthTab(),
        FifthTab(),
      ],
    );
  }
  }