import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../blocs/signin_bloc.dart';
import '../services/app_service.dart';
import '../utils/snacbar.dart';
import '../utils/uihelper.dart';

class EditProfile extends StatefulWidget{
  final String? profileName;
  final String? imagePath;
  const EditProfile({
    super.key,
    required this.profileName,
    required this.imagePath,
  });

  @override
  State<EditProfile> createState() => EditProfileState(profileName, imagePath);
}
class EditProfileState extends State<EditProfile>{
  EditProfileState(this.profileName, this.imagePath);
  String? profileName;
  String? imagePath;
  TextEditingController userName = TextEditingController();
  showAlertBox(){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
          title: const Text('Pick Image From',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  });
                },
                child: const ListTile(
                  leading: Icon(Icons.camera_alt),
                  title:  Text('Camera'),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  });
                },
                child: const ListTile(
                  leading: Icon(Icons.image),
                  title:  Text('Gallery'),
                ),
              )
            ],
          )
      );
    });
  }
  File? imageFile;
  String? fileName;
  bool loading = false;
  pickImage(ImageSource imageSource) async {
    final photo = await ImagePicker().pickImage(source: imageSource);
    if(photo == null) return;
    setState(() {
      imageFile = File(photo.path);
      fileName = (imageFile!.path);
    });
  }
  Future uploadProfile() async {
    // final SignInBloc sb = context.read<SignInBloc>();
    // Reference storageReference = FirebaseStorage.instance.ref().child('Profile Pictures/${sb.uid}');
    // UploadTask uploadTask = storageReference.putFile(imageFile!);
    // await uploadTask.whenComplete(()async{
    //   var url = await storageReference.getDownloadURL();
    //   var imageUrl = url.toString();
    //   setState(() {
    //     imagePath = imageUrl;
    //   });
    // });
  }
  handleUpdateDate()async {
    final sb = context.read<SignInBloc>();
    await AppService().checkInternet().then((hasInternet) async {
      if(hasInternet == false){
        openSnacbar(context, 'no internet');
      }
      else{
        setState(() {
          loading = true;
        });
        imageFile==null?
        await sb.updateUserProfile(userName.text, imagePath!).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                alignment: Alignment.centerLeft,
                height: 60,
                child: const Text(
                  "Updated Successfully",
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
          setState(() {
            loading = false;
          });
        }):
        await uploadProfile().then((value){
          sb.updateUserProfile(userName.text, imagePath!).then((value){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                  alignment: Alignment.centerLeft,
                  height: 60,
                  child: const Text(
                    "Updated Successfully",
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
            setState(() {
              loading = false;
            });
          });
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    userName.text = profileName!;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey.withOpacity(.2),
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    Stack(
                      children: [
                        fileName==null ? CircleAvatar(
                          radius: 55,
                          backgroundImage: CachedNetworkImageProvider(imagePath!),
                        ): CircleAvatar(
                          radius: 55,
                          backgroundImage: FileImage(imageFile!),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: (){
                              showAlertBox();
                            },
                            child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.black,
                                child: Icon(FontAwesomeIcons.pen,color: Colors.white,size: 12,)
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40,),
                    UiHelper.customTextField(userName, "Enter new name", "", false, null, () { }),
                    const SizedBox(height: 30,),
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: (){
                            handleUpdateDate();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.deepPurple,
                            alignment: Alignment.center,
                          ),
                          child: loading==true ?
                            const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),),)
                            :
                            const Text("Update Profile",style: TextStyle(fontSize: 16,color: Colors.white),)
                      ),
                    ),
                  ],
                ),
              )
          )
      ),
    );
  }
}