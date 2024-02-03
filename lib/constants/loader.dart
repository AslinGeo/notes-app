import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader {
 
     Future<void> showOverlayLoader() async {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: true,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 45,
            height: 45,
            child: CircularProgressIndicator(
              strokeWidth: 5,
            ),
          ),
        ),
      ),
    );
  
  }
}
