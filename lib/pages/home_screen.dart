import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../blocs/admin_bloc.dart';
import '../blocs/home_bloc.dart';
import '../blocs/signin_bloc.dart';
import '../blocs/tab_index_bloc.dart';
import '../services/app_service.dart';
import '../utils/next_screen.dart';
import '../widgets/tab_medium.dart';
import 'bookmark.dart';
import 'notification.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState()=> HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> with  AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categoryList.length, vsync: this);
    _tabController!.addListener(() {
      context.read<TabIndexBloc>().setTabIndex(_tabController!.index);
    });
    Future.delayed(const Duration(milliseconds: 0)).then((value) async{
      // context.read<HomeBloc>().getData();
      // context.read<HomeBloc>().getPopularData();
      // context.read<HomeBloc>().getRecentData(mounted);
      await AppService().checkInternet().then((hasInternet){
        if(hasInternet == false){
          openToast(context, 'No Internet');
        }else {
          context.read<PostProvider>().fetchPosts();
          context.read<PostProvider>().fetchPostsRecent();
        }
      });
    });
  }
  // final postProvider = Provider.of<PostProvider>(context);
  //
  // @override
  // void initState() {
  //   postProvider.fetchPosts();
  //   super.initState();
  // }
  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    // final sb = context.watch<SignInBloc>();
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        shape: const RoundedRectangleBorder(),
        // width: MediaQuery.of(context).size.width * .9,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14,right: 14,top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  width: 110,
                  image: AssetImage('assets/images/sustain_final1.webp'),
                ),
                const SizedBox(height: 6,),
                // const Text('Sustain Planet',style: TextStyle(fontFamily: "Logo",fontWeight: FontWeight.bold,fontSize: 27)),
                // Text('Version: ${sb.appVersion}',style: const TextStyle(fontSize: 15, color: Colors.grey)),
                const SizedBox(height: 20,),
                ListTile(
                  onTap: (){
                    nextScreen(context, BookmarkList());
                  },
                  style: ListTileStyle.list,
                  leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(FontAwesomeIcons.bookmark,color: Colors.black54,size: 20,)
                  ),
                  title: const Text('Bookmark List',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87
                    ),
                  ),
                ),
                Divider(thickness: 0.6,color: Colors.grey.withOpacity(.3),height: 10,),
                ListTile(
                  onTap: ()async{
                    AppService().openLinkWithCustomTab(context, 'https://sustainplanet.org/');
                  },
                  style: ListTileStyle.list,
                  leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(FontAwesomeIcons.globe,color: Colors.black54,size: 20,)
                  ),
                  title: const Text('Website',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87
                    ),
                  ),
                ),
                Divider(thickness: 0.6,color: Colors.grey.withOpacity(.3),height: 10,),
                ListTile(
                  onTap: ()async{
                    AppService().openLinkWithCustomTab(context, 'https://sustainplanet.org/contact-us/');
                  },
                  style: ListTileStyle.list,
                  leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(FontAwesomeIcons.envelope,color: Colors.black54,size: 20,)
                  ),
                  title: const Text('Contact Us',
                    style: TextStyle(
                        fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: Semantics(
                label: 'Menu',
                child: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 27,
                  ),
                ),
              ),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    width: 124,
                    image: AssetImage('assets/images/sustain_final1.webp'),
                  ),
                ],
              ),
              titleSpacing: 0,
              forceElevated: innerBoxIsScrolled,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Semantics(
                    label: 'Notifications',
                    child: IconButton(
                        onPressed: (){
                          nextScreen(context, NotificationAlert());
                        },
                        icon: const Icon(
                          Icons.notifications_none_outlined,
                          color: Colors.black87,
                          size: 26,
                        ),
                    ),
                  ),
                )
              ],
              pinned: true,
              elevation: 1,
              surfaceTintColor: Colors.white,
              floating: true,
              toolbarHeight: 84,
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(68),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10,top: 10),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                      labelStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w400),
                      splashFactory: NoSplash.splashFactory,
                      dividerColor: Colors.transparent,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      tabs: articleCategory,
                    ),
                  )),
            )
          ];
        },
        body: Builder(
          builder: (BuildContext context){
            final innerScrollController = PrimaryScrollController.of(context);
            return TabMedium(
                sc: innerScrollController,
                tc: _tabController
            );
          },
        )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
List<Widget> articleCategory = List<Widget>.generate(
  categoryList.length,
      (index) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(50)
    ),
    child: Tab(text: categoryList[index]),
  ),
);
final categoryList = ["Top Stories", "Health", "Food", "BioDiversity", "Ocean"];