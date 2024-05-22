import 'dart:io';


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'blocs/admin_bloc.dart';
import 'blocs/category_bloc.dart';
import 'blocs/comment_bloc.dart';
import 'blocs/home_bloc.dart';
import 'blocs/search_bloc.dart';
import 'blocs/signin_bloc.dart';
import 'blocs/tab_index_bloc.dart';
import 'blocs/notification_bloc.dart';
// import 'firebase_options.dart';
import 'pages/home.dart';
import 'utils/next_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // Directory directory = await getApplicationDocumentsDirectory();
  // Hive.init(directory.path);
  // await Hive.openBox('notifications');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PostProvider>(
          create: (context) => PostProvider(),
        ),
        ChangeNotifierProvider<TabIndexBloc>(
            create: (context) => TabIndexBloc()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Sustain Planet",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: "Poppins",
        ),
        home: const SplashPage(),
      ),
    );
  }
}
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  afterSplash(){
    // final SignInBloc sb = context.read<SignInBloc>();
    Future.delayed(const Duration(milliseconds: 1500)).then((value){
      gotoHomePage();

    });
  }

  gotoHomePage () {
    // final SignInBloc sb = context.read<SignInBloc>();
    // sb.getDataFromSp();
    // if(FirebaseAuth.instance.currentUser!=null){
    //   var uid = FirebaseAuth.instance.currentUser!.uid;
    //   sb.getUserDatafromFirebase(uid);
    // }
    nextScreenReplace(context, HomePage());
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
  }
  @override
  void initState() {
    afterSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Image(
              image: AssetImage('assets/images/sustain_final1.webp'),
              width: 140,
              fit: BoxFit.contain,
            )
        ));
  }
}










