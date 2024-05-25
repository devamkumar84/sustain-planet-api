import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../blocs/admin_bloc.dart';
import '../blocs/notification_bloc.dart';
import '../blocs/signin_bloc.dart';
import '../services/app_service.dart';
import '../services/auth_service.dart';
import '../utils/dailog.dart';
import '../utils/next_screen.dart';
import '../utils/snacbar.dart';
import '../utils/uihelper.dart';
import 'bookmark.dart';
import 'edit_profile.dart';
import 'home.dart';
import 'security.dart';
class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState()=> ProfileScreenStateOne();
}
class ProfileScreenStateOne extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context){
    // return Container();
    final sb = context.watch<SignInBloc>();
    // final abm = context.watch<AdminBloc>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: ()async{
                  // print('isSignedIn ${sb.isSignedIn}');
                  // print('isAdmin ${abm.isAdmin}');
                },
                  child: Text('Profile', style:  TextStyle(fontWeight: FontWeight.w500,fontSize: 20),)
              ),
            ],
          )
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[100],
        child: SingleChildScrollView(
          child:
          Container(
              padding: const EdgeInsets.only(left: 18,right: 18),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        sb.isSignedIn == false ? LoginBox() : UserProfileData(),
                        // abm.isAdmin == true ? AdminSetting() : Container(),
                        GeneralSetting(),
                      ],
                    ),
                  ],
                ),
              )
          ),

        ),
      ),
    );
  }
}

class ProfileScreenTwo extends StatefulWidget{
  const ProfileScreenTwo({super.key});
  @override
  State<ProfileScreenTwo> createState()=> ProfileScreenStateTwo();
}
class ProfileScreenStateTwo extends State<ProfileScreenTwo>{
  bool _isLogin = false;
  bool eyePassword = true;
  bool eyeCheckPassword = true;
  var iconEye = const Icon(FontAwesomeIcons.eye);
  bool isForgotPassword = false;


  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailCheckController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();
  TextEditingController passForgotController = TextEditingController();
  bool isEmailValid(String email) {
    // Regular expression for basic email validation
    final RegExp emailRegex =
    RegExp(r'^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }
  // Future<int> getTotalUsersCount () async {
  //   const String fieldName = 'count';
  //   final DocumentReference ref = FirebaseFirestore.instance.collection('item_count').doc('users_count');
  //   DocumentSnapshot snap = await ref.get();
  //   if(snap.exists == true){
  //     int itemCount = snap[fieldName] ?? 0;
  //     return itemCount;
  //   }
  //   else{
  //     await ref.set({
  //       fieldName : 0
  //     });
  //     return 0;
  //   }
  // }
  // Future increaseUserCount () async {
  //   await getTotalUsersCount()
  //       .then((int documentCount)async {
  //     await FirebaseFirestore.instance.collection('item_count').doc('users_count').update({
  //       'count' : documentCount + 1
  //     });
  //   });
  // }

  Future handleSignUpwithEmailPassword () async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false );
    await AppService().checkInternet().then((hasInternet){
      if(hasInternet == false){
        Navigator.pop(context);
        openSnacbar(context, 'no internet');
      }else {
        sb.signUpwithEmailPassword(userController.text.toString(), emailController.text.toString(), passwordController.text.toString()).then((_)async{
          if(sb.hasError == false){
            sb.getTimestamp()
                .then((value) =>  sb.setSignIn())
                .then((value) => sb.saveDataToSP());
            Navigator.pop(context);
            openSnacbar(context, 'Account created successfully');
            nextScreenReplace(context, HomePage());
          }else {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: const Text('Error'),
                    content: Text(sb.errorCode.toString()),
                    actions: [
                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'))
                    ],
                  );
                }
            );
          }
        });
      }
    });
  }

  handleSignInwithemailPassword () async {
    showDialog(context: context, barrierDismissible: false, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
    await AppService().checkInternet().then((hasInternet) {
      if (hasInternet == false) {
        Navigator.pop(context);
        openSnacbar(context, 'no internet');
      } else {
        sb.signInWithEmailPassword(emailCheckController.text.toString(),
            passwordCheckController.text.toString()).then((_) async {
          if (sb.hasError == false) {
                sb.saveDataToSP()
                .then((value) => sb.setSignIn());

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                  alignment: Alignment.centerLeft,
                  height: 60,
                  child: const Text(
                    "login successfully",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                action: SnackBarAction(
                  label: 'Ok',
                  textColor: Colors.blueAccent,
                  onPressed: () {},
                ),
              ),
            );
            print('User Login');
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }
          else {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: Text(sb.errorCode ?? 'Invalid Credentials.'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'))
                    ],
                  );
                }
            );
          }
        });
      }
    });
  }



  // login(String email, String password) async {
  //   try {
  //     showDialog(
  //         context: context,
  //         builder: (context){
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //     );
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: email,
  //         password: password
  //     );
  //     Navigator.pop(context);
  //     nextScreenReplace(context, HomePage());
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       // print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       // print('Wrong password provided for that user.');
  //     }
  //     Navigator.pop(context);
  //     showDialog(
  //         context: context,
  //         builder: (context){
  //           return AlertDialog(
  //             title: const Text('Error'),
  //             content: const Text('Invalid Credentials'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //           );
  //         }
  //     );
  //   }
  // }
  // checkUser(){
  //   final user = FirebaseAuth.instance.currentUser;
  //   return user!=null;
  // }
  // forgotPass(String email) async {
  //   try{
  //     showDialog(
  //         context: context,
  //         builder: (context){
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //     );
  //     await FirebaseAuth.instance.sendPasswordResetEmail(
  //         email: email
  //     );
  //     Navigator.pop(context);
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Password Reset Email Sent'),
  //           content: Text('Reset password link sent to your ${email.toString()}.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }catch(e){
  //     Navigator.pop(context);
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: Text(e.toString()),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    // return Container();
    final sb = context.watch<SignInBloc>();
    // final abm = context.watch<AdminBloc>();
    return Scaffold(
      appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text('Profile', style:  TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
            ],
          )
      ),
      body:
       Container(
         height: MediaQuery.of(context).size.height,
         // color: Colors.grey[200],
         child: SingleChildScrollView(
              child:
              Container(
                  padding: const EdgeInsets.only(left: 18,right: 18),
                  child: Form(
                      child: _isLogin?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16,),
                          InkWell(onTap:(){print(sb.isSignedIn);},child: const Text('Sign Up',style: TextStyle(fontSize: 26,fontWeight: FontWeight.w600,color: Colors.deepPurple),)),
                          const Text('Follow the simple steps',style: TextStyle(color: Colors.black87),),
                          const SizedBox(height: 46,),
                          UiHelper.customTextField(userController, "Enter Name", "Name", false, const Icon(Icons.person), (){}),
                          const SizedBox(height: 8,),
                          UiHelper.customTextField(emailController, "username@mail.com", "Email Address", false, const Icon(Icons.mail), (){}),
                          const SizedBox(height: 8,),
                          UiHelper.customTextField(passwordController, "Enter Password", "Password", eyePassword, iconEye, (){
                            setState(() {
                              if(eyePassword){
                                eyePassword = false;
                                iconEye = const Icon(FontAwesomeIcons.eyeSlash);
                              }else {
                                eyePassword = true;
                                iconEye = const Icon(FontAwesomeIcons.eye);
                              }
                            });
                          }),
                          const SizedBox(height: 26,),
                          UiHelper.customElevatedButton("Sign Up", const Icon(Icons.create,color: Colors.white,), () {
                            if (userController.text.isNotEmpty &&
                                emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              if (isEmailValid(emailController.text.toString())) {
                                handleSignUpwithEmailPassword();
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text("Please enter a valid email address."),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Error"),
                                    content: const Text("Please fill in all fields."),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }),
                          const SizedBox(height: 0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already Have an Account?'),
                              TextButton(onPressed:(){
                                setState(() {
                                  if(!_isLogin){
                                    _isLogin = true;
                                  }else {
                                    _isLogin = false;
                                  }
                                });
                              }, child: const Text('Login')),
                            ],
                          ),
                        ],
                      ):
                      !isForgotPassword ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16,),
                          InkWell(
                            onTap: (){
                              // print('is SignIn ${sb.isSignedIn}');
                              // print('is Admin Login ${abm.isAdmin}');
                            },
                            child: const Text('Sign in',style: TextStyle(fontSize: 26,fontWeight: FontWeight.w600,color: Colors.deepPurple),)
                          ),
                          const Text('Follow the simple steps',style: TextStyle(color: Colors.black87),),
                          const SizedBox(height: 46,),
                          UiHelper.customTextField(emailCheckController, "username@mail.com", "Email Address", false, const Icon(Icons.mail), (){ }),
                          const SizedBox(height: 8,),
                          UiHelper.customTextField(passwordCheckController, "Enter Password", "Password", eyeCheckPassword, iconEye, (){
                            setState(() {
                              if(eyeCheckPassword){
                                eyeCheckPassword = false;
                                iconEye = const Icon(FontAwesomeIcons.eyeSlash);
                              }else {
                                eyeCheckPassword = true;
                                iconEye = const Icon(FontAwesomeIcons.eye);
                              }
                            });
                          }),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(onPressed:(){
                                setState(() {
                                  if(!isForgotPassword){
                                    isForgotPassword = true;
                                  }else {
                                    isForgotPassword = false;
                                  }
                                });
                              }, child: const Text('Forgot Password?')),
                            ],
                          ),
                          const SizedBox(height: 0,),
                          UiHelper.customElevatedButton("Sign In", null, () {
                            if(emailCheckController.text.isNotEmpty && passwordCheckController.text.isNotEmpty){
                              // login(emailCheckController.text.toString(), passwordCheckController.text.toString());
                              handleSignInwithemailPassword();
                            }else {
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text('Please fill in all fields.'),
                                      actions: [
                                        TextButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'))
                                      ],
                                    );
                                  }
                              );
                            }
                          }),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(onPressed:(){
                                setState(() {
                                  if(_isLogin){
                                    _isLogin = false;
                                  }else {
                                    _isLogin = true;
                                  }
                                });
                              }, child: const Text("Sign Up")),
                            ],
                          )
                        ],
                      ) :
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16,),
                          const Text('Reset Your Password',style: TextStyle(fontSize: 26,fontWeight: FontWeight.w600,color: Colors.deepPurple),),
                          const Text('Follow the simple steps',style: TextStyle(color: Colors.black87),),
                          const SizedBox(height: 46,),
                          UiHelper.customTextField(passForgotController, "username@mail.com", "Email Address", false, const Icon(Icons.mail), (){ }),
                          const SizedBox(height: 26,),
                          UiHelper.customElevatedButton("Reset Password", const Icon(Icons.lock_reset,color: Colors.white,), () {
                            if(passForgotController.text.isNotEmpty){
                              // forgotPass(passForgotController.text.toString());
                              passForgotController.clear();
                            }else {
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text('Please fill the email field.'),
                                      actions: [
                                        TextButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'))
                                      ],
                                    );
                                  }
                              );
                            }
                          }),
                          const SizedBox(height: 10,),
                          Center(
                            child: TextButton(onPressed:(){
                              setState(() {
                                if(isForgotPassword){
                                  isForgotPassword = false;
                                }else {
                                  isForgotPassword = true;
                                }
                              });
                            }, child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(.2),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: const Icon(Icons.arrow_back,size: 28,),
                            )
                            ),
                          )
                        ],
                      )
                  ),
              ),

               ),
       ),
    );
  }
}
class GeneralSetting extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    // final sb = context.watch<SignInBloc>();
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text('General Settings',style: TextStyle(fontSize: 22,color: Colors.black, fontWeight: FontWeight.w500),)
          ),
        ),
        ListTile(
          onTap: (){
            nextScreen(context, BookmarkList());
          },
          style: ListTileStyle.list,
          leading: Container(
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(6)
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(FontAwesomeIcons.bookmark,color: Colors.white,size: 20,)
          ),
          title: const Text('Bookmark List',
            style: TextStyle(
                fontSize: 16
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 16,color: Colors.grey,),
        ),
        Divider(thickness: 0.6,color: Colors.grey.withOpacity(.3),height: 10,),
        ListTile(
          onTap: ()async{
            AppService().openLinkWithCustomTab(context, 'https://sustainplanet.org/');
          },
          style: ListTileStyle.list,
          leading: Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(6)
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(FontAwesomeIcons.globe,color: Colors.white,size: 20,)
          ),
          title: const Text('Website',
            style: TextStyle(
                fontSize: 16
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 16,color: Colors.grey,),
        ),
        Divider(thickness: 0.6,color: Colors.grey.withOpacity(.3),height: 10,),
        // ListTile(
        //   title: const Text('get notifications'),
        //   leading: Container(
        //     padding: const EdgeInsets.all(5),
        //     // height: 30,
        //     // width: 30,
        //     decoration: BoxDecoration(
        //         color: Colors.deepPurpleAccent,
        //         borderRadius: BorderRadius.circular(5)
        //     ),
        //     child: const Icon(Icons.notifications_none_sharp, size: 26, color: Colors.white),
        //   ),
        //   trailing:  Switch.adaptive(
        //       activeColor: Theme.of(context).primaryColor,
        //       value: context.watch<NotificationBloc>().subscribed,
        //       onChanged: (bool newValue) {
        //         context.read<NotificationBloc>().handleSubscription(context, newValue);
        //       }),
        // ),
        // sb.isSignedIn == false ? Container() : const SecurityOption(),
        // Divider(thickness: 0.6,color: Colors.grey.withOpacity(.3),height: 10,),
        ListTile(
          onTap: ()async{
            AppService().openLinkWithCustomTab(context, 'https://sustainplanet.org/contact-us/');
          },
          style: ListTileStyle.list,
          leading: Container(
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(6)
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(FontAwesomeIcons.envelope,color: Colors.white,size: 20,)
          ),
          title: const Text('Contact Us',
            style: TextStyle(
                fontSize: 16
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 16,color: Colors.grey,),
        ),
        SizedBox(height: 30,),
        // Text('Version: ${sb.appVersion}',style: const TextStyle(fontSize: 15, color: Colors.redAccent)),
        SizedBox(height: 30,),
      ],
    );
  }
}
class SecurityOption extends StatelessWidget{
  const SecurityOption({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Divider(thickness: 0.6,color: Colors.grey.withOpacity(.3),height: 10,),
        ListTile(
          onTap: (){
            nextScreen(context, const SecurityPage());
          },
          style: ListTileStyle.list,
          leading: Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6)
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(FontAwesomeIcons.lock,color: Colors.white,size: 18,)
          ),
          title: const Text('Security',
            style: TextStyle(
                fontSize: 16
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 16,color: Colors.grey,),
        ),
      ],
    );
  }
}
class AdminSetting extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Admin Settings',style: TextStyle(fontSize: 22,color: Colors.black, fontWeight: FontWeight.w500),)
          ),
        ),
        ListTile(
          onTap: (){
            // nextScreen(context, Categories());
          },
          style: ListTileStyle.list,
          leading: Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(6)
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.grid_view,color: Colors.white,size: 20,)
          ),
          title: const Text('Categories',
            style: TextStyle(
                fontSize: 16
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 16,color: Colors.grey,),
        ),

        Divider(thickness: 0.6,color: Colors.grey.withOpacity(.3),height: 10,),
        ListTile(
          onTap: (){
            // nextScreen(context, UploadContent());
          },
          style: ListTileStyle.list,
          leading: Container(
              decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(6)
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.article,color: Colors.white,size: 20,)
          ),
          title: const Text('Upload Article',
            style: TextStyle(
                fontSize: 16
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 16,color: Colors.grey,),
        ),
      ],
    );
  }
}
class LoginBox extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        const SizedBox(height: 20,),
        ListTile(
          onTap: (){
            nextScreen(context, ProfileScreenTwo());
          },
          style: ListTileStyle.list,
          leading: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(FontAwesomeIcons.user,color: Colors.white,size: 20,)
          ),
          title: const Text('Login',
            style: TextStyle(
                fontSize: 16
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 16,color: Colors.grey,),
        ),
      ],
    );
  }
}
class UserProfileData extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    // return Container();
    final sb = context.watch<SignInBloc>();
    // final abm = context.watch<AdminBloc>();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 20,),
              sb.imageUrl!=null ? CircleAvatar(
                radius: 50,
                backgroundImage: CachedNetworkImageProvider(sb.imageUrl!),
              ): const CircleAvatar(
                radius: 50,
                child: Center(child: Icon(Icons.person,size: 50,)),
              ),
              const SizedBox(height: 15,),
              InkWell(
                  onTap: (){
                    // print('is SignIn ${sb.isSignedIn}');
                    // print('is Admin Login ${abm.isAdmin}');
                  },
                  child: Text(sb.name ?? 'Default Name', style: const TextStyle(fontSize: 22,color: Colors.black87,fontWeight: FontWeight.w500))),
              const SizedBox(height: 35,),
              ListTile(
                style: ListTileStyle.list,
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6)
                  ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.email_outlined,color: Colors.white,size: 24,)
                ),
                title: Text('${sb.email}',
                  style: const TextStyle(
                      fontSize: 16
                  ),),
              ),
              Divider(thickness: 0.6,color: Colors.grey.withOpacity(.3),height: 10,),
              ListTile(
                onTap: (){
                    nextScreen(context, EditProfile(profileName: sb.name, imagePath: sb.imageUrl));
                },
                style: ListTileStyle.list,
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(6)
                  ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(FontAwesomeIcons.pencil,color: Colors.white,size: 20,)
                ),
                title: const Text('Edit Profile',
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 16,color: Colors.grey,),
              ),
              Divider(thickness: 0.6,color: Colors.grey.withOpacity(.3),height: 10,),
              ListTile(
                onTap: (){
                  print(sb.isSignedIn);
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: const Text("Do you really want to logout from the app?",style: TextStyle(fontSize: 20),),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: const Text('No')
                            ),
                            TextButton(
                                onPressed: (){
                                  sb.afterUserSignOut();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 60,
                                        child: const Text(
                                          "Logout Successfully",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      action: SnackBarAction(
                                        label: 'Ok',
                                        textColor: Colors.blueAccent,
                                        onPressed: () {},
                                      ),
                                    ),
                                  );
                                  nextScreenReplace(context, HomePage());
                                },
                                child: const Text('Yes')
                            ),
                          ],
                        );
                      });
                },
                style: ListTileStyle.list,
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(6)
                  ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.logout_outlined,color: Colors.white,size: 20,)
                ),
                title: const Text('Logout',
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 16,color: Colors.grey,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}