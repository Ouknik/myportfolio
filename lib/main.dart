// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ouknik_portfolio/views/home_view.dart';

import 'controlers/portfolio_controller.dart';


void main() {

  Get.put(PortfolioController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Portfolio',
     
      debugShowCheckedModeBanner: false,
     // initialRoute: AppPages.INITIAL,
     // getPages: AppPages.routes,

     home: HomeView(),
    );
  }
}
