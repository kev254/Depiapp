import 'package:flutter/material.dart';
import 'package:get/get.dart';
void showSnackbar({required String title, required String subtitle, path}) {
  Get.snackbar(
    title,
    subtitle,
    backgroundColor: Colors.white,
    colorText: Colors.green,
    icon: Icon(path, size: 28, color: Colors.green),
    snackPosition: SnackPosition.BOTTOM,
  );
}
