import 'package:flutter/material.dart';
import 'package:get/get.dart';
String introHeader = "Image to Speech Converter App";
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
  "vishal Ojha" : "23BHI",
  "Aman Ojha" : "23BHI",
  "Aman Ojha2" : "23BHI",
  "Aman Ojha3" : "23BHI",
  "Aman Ojha4" : "23BHI"
};