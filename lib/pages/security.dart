import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:sustain_planet/pages/home.dart';

import '../blocs/signin_bloc.dart';
import '../utils/next_screen.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {

  bool _isLoading = false;


  _openDeleteDialog() {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Do you really want to delete your data?'),
            content: const Text('Your account information like profile data, bookmarks, etc will be erased from the app database and You will have to sign up again in the app to continue.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // _handleDeleteAccount();
                },
                child: const Text('Yes, Delete My Account'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          );
        });
  }


  // Future<void> _handleDeleteAccount() async {
  //   setState(() => _isLoading = true);
  //
  //   try {
  //     await context.read<SignInBloc>().deleteUserDatafromDatabase();
  //     await context.read<SignInBloc>().userSignout();
  //     await context.read<SignInBloc>().decreaseUserCount();
  //     await context.read<SignInBloc>().afterUserSignOut();
  //     setState(() => _isLoading = false);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Container(
  //           alignment: Alignment.centerLeft,
  //           height: 60,
  //           child: const Text(
  //             "Account deleted successfully",
  //             style: TextStyle(
  //               fontSize: 14,
  //             ),
  //           ),
  //         ),
  //         action: SnackBarAction(
  //           label: 'Ok',
  //           textColor: Colors.blueAccent,
  //           onPressed: () {},
  //         ),
  //       ),
  //     );
  //     // Delay for 1 second before navigating to the home page
  //     await Future.delayed(const Duration(seconds: 1));
  //     nextScreenCloseOthers(context, HomePage());
  //   } catch (error) {
  //     // Handle any errors
  //     print('Error deleting account: $error');
  //     setState(() => _isLoading = false);
  //   }
  // }
  // Future<void> _handleDeleteAccount() async {
  //   setState(() => _isLoading = true);
  //
  //   context.read<SignInBloc>().deleteUserDatafromDatabase()
  //       .then((_) => context.read<SignInBloc>().userSignout())
  //       .then((_) => context.read<SignInBloc>().afterUserSignOut())
  //       .then((_) {
  //     setState(() => _isLoading = false);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Container(
  //           alignment: Alignment.centerLeft,
  //           height: 60,
  //           child: const Text(
  //             "Account deleted successfully",
  //             style: TextStyle(
  //               fontSize: 14,
  //             ),
  //           ),
  //         ),
  //         action: SnackBarAction(
  //           label: 'Ok',
  //           textColor: Colors.blueAccent,
  //           onPressed: () {},
  //         ),
  //       ),
  //     );
  //     // Delay for 1 second before navigating to the home page
  //     return Future.delayed(const Duration(seconds: 1));
  //   })
  //       .then((_) => nextScreenCloseOthers(context, HomePage()))
  //       .catchError((error) {
  //     // Handle any errors
  //     print('Error deleting account: $error');
  //     setState(() => _isLoading = false);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security', style:  TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                ListTile(
                  title: const Text('Delete My Data & Account'),
                  leading: const Icon(FontAwesomeIcons.trash, size: 20,),
                  onTap: _openDeleteDialog,

                ),
              ],
            ),

            Align(
              child: _isLoading == true ? const CircularProgressIndicator() : Container(),
            )


          ],
        ),
      ),
    );
  }
}