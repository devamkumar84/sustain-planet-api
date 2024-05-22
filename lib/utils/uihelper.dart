import 'package:flutter/material.dart';

class UiHelper{
  static customTextField(TextEditingController controller, String text, String labelText, bool noHide, Icon? iconData, VoidCallback voidCallback){
    return TextField(
      controller: controller,
      obscureText: noHide,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: text,
        hintStyle: const TextStyle(fontSize: 15),
        suffixIcon: iconData!=null ? IconButton(
          icon: iconData,
          iconSize: 20,
          onPressed: (){
            voidCallback();
          },
        ): null,
      ),
    );
  }
  static customElevatedButton(String text, Icon? iconData, VoidCallback voidCallback){
    return ElevatedButton(
        onPressed: (){
          voidCallback();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.deepPurple,
          alignment: Alignment.center,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,style: const TextStyle(fontSize: 16,color: Colors.white),),
              iconData!=null ?
              Row(
                children: [
                  const SizedBox(width: 6,),
                  iconData,
                ],
              ): Container(),
            ],
          ),
        ));
  }
}
ButtonStyle buttonStyle(Color? color) {
  return ButtonStyle(
      padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 15)),
      backgroundColor: MaterialStateProperty.resolveWith((states) => color),
      shape: MaterialStateProperty.resolveWith((states) =>
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))));
}
InputDecoration inputDecoration(hint, label, controller) {
  return InputDecoration(
      hintText: hint,
      border: const OutlineInputBorder(),
      labelText: label,
      contentPadding: const EdgeInsets.only(right: 0, left: 10),
      suffixIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.grey[300],
          child: IconButton(
              icon: const Icon(Icons.close, size: 15),
              onPressed: () {
                controller.clear();
              }),
        ),
      ));
}