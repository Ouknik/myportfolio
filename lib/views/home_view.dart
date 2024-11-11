// lib/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ouknik_portfolio/widgets/header.dart';


import '../controlers/portfolio_controller.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';

class HomeView extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            ProjectsSection(),
           
            ExperienceSection(),
            ContactSection(),
          ],
        ),
      ),
    );
  }
}
