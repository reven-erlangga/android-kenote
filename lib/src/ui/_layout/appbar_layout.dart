import 'package:flutter/material.dart';

// Sliver appbar
Widget sliverappbarLayout(VoidCallback _backButton, IconData _backIcon, String _title, double _height) {
  return SliverAppBar(
    expandedHeight: _height,
    elevation: 0.0,
    titleSpacing: 2.0,
    floating: false,
    pinned: true,
    snap: false,
    primary: true,
    centerTitle: true,
    leading: FlatButton(
      onPressed: _backButton,
      child: Icon(_backIcon, color: Colors.white,),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.5, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
          colors: [const Color.fromARGB(255, 254, 100, 110), const Color.fromARGB(255, 	253, 126, 119)], // gradient color
        ),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          _height = constraints.biggest.height; // Dapat digunakan untuk mendeteksi appbar Expanded atau Collapsed
          return FlexibleSpaceBar(
            centerTitle: true,
            title: Container(
              child: Text(
                _title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Chilanka',
                ),
              ),
            ),
          );
        }
      ),
    ),
  );
}

// Appbar
Widget appbarLayout(VoidCallback backButton, IconData backIcon, String title) {
  return AppBar(
    elevation: 0.0,
    titleSpacing: 2.0,
    primary: true,
    leading: FlatButton(
      onPressed: backButton,
      child: Icon(backIcon, color: Colors.white,),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.5, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
          colors: [const Color.fromARGB(255, 254, 100, 110), const Color.fromARGB(255, 	253, 126, 119)], // gradient color
        ),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Chilanka'
              ),
            ),
          );
        }
      ),
    ),
  );
}