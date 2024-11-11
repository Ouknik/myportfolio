// lib/controllers/portfolio_controller.dart
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/project.dart';

class PortfolioController extends GetxController {
  final personalInfo = StaticData.personalInfo;
  final projects = StaticData.projects;
  final experience = StaticData.experience;
  
  final RxBool isImageHovered = false.obs;
  final RxBool isCVButtonHovered = false.obs;
  
  void updateImageHover(bool value) => isImageHovered.value = value;
  void updateCVButtonHover(bool value) => isCVButtonHovered.value = value;
}