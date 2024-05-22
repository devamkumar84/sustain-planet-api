import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'libraryscreen.dart';
import '../blocs/notification_bloc.dart';
import '../services/notification_service.dart';
import 'profilescreen.dart';
import 'searchscreen.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  PageController _pageController = PageController();

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;

    });
    _pageController.animateToPage(index,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 250));

  }


  // _initServies ()async{
  //   Future.delayed(const Duration(milliseconds: 0))
  //       .then((value) async{
  //     await NotificationService().initFirebasePushNotification(context)
  //         .then((value) => context.read<NotificationBloc>().checkPermission());
  //   });
  // }
  //
  //
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _initServies();
  //
  // }






  @override
  void dispose() {
    _pageController.dispose();
    //HiveService().closeBoxes();
    super.dispose();
  }



  Future _onWillPop () async{
    if(_currentIndex != 0){
      setState (()=> _currentIndex = 0);
      _pageController.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }else{
      await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', true);
    }
  }



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        _onWillPop();
      },
      child: DefaultTabController(
        length: articleCategory.length,
        child: Scaffold(
          bottomNavigationBar: SizedBox(
            height: 65,
              child: _bottomNavigationBar()
          ),
          // bottomNavigationBar: NavigationBar(
          //   destinations: _screenChanger,
          //   height: 70,
          //   indicatorColor: Colors.deepPurple,
          //   backgroundColor: Colors.white,
          //   selectedIndex: _selectedScreen,
          //   onDestinationSelected: (index){
          //     setState(() {
          //       _selectedScreen = index;
          //     });
          //   },
          // ),
          body: PageView(
            controller: _pageController,
            allowImplicitScrolling: false,
            physics: const NeverScrollableScrollPhysics(),
            children: const <Widget>[
              HomeScreen(),
              SearchScreen(),
              LibraryScreen(),
              ProfileScreen()
            ],
          ),
        ),
      ),
    );
  }



  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) => onTabTapped(index),
      currentIndex: _currentIndex,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      iconSize: 25,
      backgroundColor: Colors.white,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
// const _screenChanger = [
//   NavigationDestination(
//       icon: Icon(Icons.home_outlined),
//       selectedIcon: Icon(Icons.home,color: Colors.white,),
//       label: 'Home'
//   ),
//   NavigationDestination(
//       icon: Icon(Icons.search),
//       selectedIcon: Icon(Icons.search,color: Colors.white,),
//       label: 'Search'
//   ),
//   NavigationDestination(
//       icon: Icon(Icons.category_outlined),
//       selectedIcon: Icon(Icons.category,color: Colors.white,),
//       label: 'Library'
//   ),
//   NavigationDestination(
//       icon: Icon(Icons.person_2_outlined),
//       selectedIcon: Icon(Icons.person_2,color: Colors.white,),
//       label: 'Profile'
//   )
// ];