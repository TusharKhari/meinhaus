// Urls
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final bool isTest = false;

// test env
// final String baseUrl = "https://test.meinhaus.ca/api";
// final String baseUrl2 = "https://test.meinhaus.ca";
// final String stripePublishableKey =
//     "pk_test_51H4ThcJ5SREt5PwvuHB2JXUj0MbYCwZFpZgREvJhgVD40feUTFMgLUlzEd4pnbtfkWazSCzKDv7jJno8X7HiPMcC00dXe9FS99";

// prod env

final String baseUrl = "https://meinhaus.ca/api";
final String baseUrl2 = "https://meinhaus.ca";
final String stripePublishableKey = "pk_live_51H4ThcJ5SREt5PwvNVuthkswoxkMKololExDZy835JPptq4EyMexUtgltIaIt77Ft1m5Fs5tUgYGrnmzafRQGUl7002XHrLNsB";


// ======
// Google Map API Keys
final String kPLACES_API_KEY = "AIzaSyCVqDZXoo2xPqEw8vksPeoqR8eF1kr8I8U";

// stripePublishableKey
// final String stripePublishableKey = "pk_live_51H4ThcJ5SREt5PwvNVuthkswoxkMKololExDZy835JPptq4EyMexUtgltIaIt77Ft1m5Fs5tUgYGrnmzafRQGUl7002XHrLNsB";
// final String stripePublishableKey = "pk_test_51N179pSELejhGBY67FodNVLvVJlV3H8RGdzLtEStBGxmFKv8DQSjK8Bcg6gTHTFjbjpkrogLisDTRQKEwaazHoAQ00769CpcH2";

//  Pusher
final String pusherApiKey = "5b60d35e6a67569cad9b";
final String pusherCluster = "us2";
//  final String pusherApiKey = "c1b0d94242e1c20581e6";

//  final String pusherApiKey = "823f246fdf95c1ff3f95";
//  final String pusherCluster = "ap2";

final String googleAddressUrl =
    "https://maps.googleapis.com/maps/api/place/autocomplete/json";
//  final  String kPLACES_API_KEY = "AIzaSyC3WLUbDPnruzxcS7eT8IQ5OVYJiSiLIlU";
//  final  String kPLACES_API_KEY = "AIzaSyA_hQ7SWkmIToW7jOLsjjT-9fLQPFe3OvM";

// Card box shadow
final List<BoxShadow> boxShadow = [
  BoxShadow(
    color: const Color.fromARGB(20, 0, 0, 0),
    blurRadius: 10,
    spreadRadius: 2,
  ),
];

final List<BoxShadow> darkShadow = [
  BoxShadow(
    color: const Color.fromARGB(50, 0, 0, 0),
    blurRadius: 15,
    spreadRadius: 4,
  ),
];

final List<BoxShadow> buttonShadow = [
  BoxShadow(
    color: const Color.fromARGB(56, 0, 0, 0),
    offset: const Offset(0, 4),
    blurRadius: 10,
  ),
];

final cachedNetworkPlaceHolder = Center(
  child: LoadingAnimationWidget.inkDrop(
    color: Colors.blue,
    size: 10,
  ),
);

final cachedNetworkErrorWidget = Center(
  child: Icon(
    Icons.image_not_supported_sharp,
    color: Colors.red[900],
  ),
);
