import 'package:flutter/material.dart';

ThemeData buildAppTheme() => ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.grey,
      ).copyWith(
        secondary: Colors.green,
      ),
      textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.blueGrey)),
    );
