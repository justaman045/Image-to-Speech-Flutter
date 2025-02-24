import 'package:flutter/material.dart';
import 'package:get/get.dart';
String introHeader = "Hello!!";
String introText = "Convert you Image to Speech using this App in a more seamless manner";
Map<String, String> routes = {
  "homePage": "/",
  "login": "/login",
  "signup": "/signup",
  "history": "/history",
  "result": "/result"
};
Curve cusCurve = Curves.decelerate;
Transition custransition = Transition.cupertino;
Duration  cusDuration = const Duration(seconds: 1);
Map<String, String> names = {
  "Names": "Social Security Number"
};