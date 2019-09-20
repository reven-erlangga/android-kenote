import 'package:flutter/material.dart';

Widget listTile(String title, String subtitle){
  var titleStyle = TextStyle(fontFamily: "Lato", fontSize: 22);
  var subtitleStyle = TextStyle(fontFamily: "Lustria", fontSize: 18);
  // subtitle =  subtitle.contains('\n') ? subtitle.length > 20 ? subtitle.replaceAll('\n', ' ').substring(0, 20) + ". . ." : subtitle.replaceAll('\n', ' ') : subtitle;

  return ListTile(
    title: Text(
      title,
      style: titleStyle,
    ),
    subtitle: Text(
      subtitle, 
      style: subtitleStyle,
    ),
  );
}