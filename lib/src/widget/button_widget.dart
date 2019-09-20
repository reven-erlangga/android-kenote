import 'package:flutter/material.dart';

Widget addFabButton(IconData icon, String tooltip, VoidCallback callback) {
  return FloatingActionButton(
    onPressed: callback,
    tooltip: tooltip,
    elevation: 2.0,
    backgroundColor: Color.fromARGB(255, 254, 100, 110),
    isExtended: true,
    child: Icon(icon),
  );
}
