import 'package:flutter/material.dart';

Widget buildContainer(index,item) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 63.0,
        color: Color.fromARGB(255, 126, 124, 124),
        child: Center(
          child: Text(
            item.data![index].title,
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }