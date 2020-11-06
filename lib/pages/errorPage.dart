import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.grey),
          actions: [
            Icon(
              Icons.more_vert,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
          ]),
      body: Column(
        children: [
          Text("공사중"),
        ],
      ),
    );
  }
}
