import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget{
  final IconData icon;
  final String message;
  final String message1;

  const EmptyPage({super.key, required this.icon, required this.message, required this.message1});

  @override
  Widget build(BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: Colors.grey),
            const SizedBox(height: 20,),
            Text(message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500,

              ),),
            const SizedBox(height: 5,),
            Text(message1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400,
                  color: Colors.grey
              ),)
          ],
        ),
      ),
    );
  }
}