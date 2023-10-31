import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:notes_app/constants/api_urls.dart';
import 'package:notes_app/constants/snack_bar.dart';
import 'package:notes_app/pages/create_note/create.variable.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/pages/home/home.controller.dart';

class CreateController extends GetxController with CreateVariables {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  @override
  void dispose() {
    super.dispose();
  }

  init() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isNetworkAvailable.value = false;
    } else {
      isNetworkAvailable.value = true;
    }
    if (note.isNotEmpty) {
      titleController.text = note.value["title"];
      descriptionController.text = note.value["description"];
    }
  }

  createNote() async {
    Map<String, String>? header = {};
    Map json = {"title": "", "description": ""};
    json["title"] = titleController.text;
    json["description"] = descriptionController.text;
    header["Content-Type"] = "application/json";

    try {
      final response = await http.post(Uri.parse(ApiUrls.baseUrl),
          body: jsonEncode(json), headers: header);
      print(response);
    } catch (e) {
      SnackbarUtils.instance.failureSnackbar(e.toString());
    }
  }

  updateNote() async {
    Map<String, String>? header = {};
    Map json = {"title": "", "description": ""};
    json["title"] = titleController.text;
    json["description"] = descriptionController.text;
    header["Content-Type"] = "application/json";

    try {
      final response = await http.put(
          Uri.parse("${ApiUrls.baseUrl}/${note.value["id"]}"),
          body: jsonEncode(json),
          headers: header);
      print(response);
    } catch (e) {
      SnackbarUtils.instance.failureSnackbar(e.toString());
    }
  }

  saveNote(isDelete) {
    if (isDelete) {
      Get.back();
    } else {
      if (note.isNotEmpty) {
        if (!isNetworkAvailable.value) {
          Get.back();
          return SnackbarUtils.instance
              .failureSnackbar("No Network Connection");
        } else {
          updateNote();

          Get.back();
          Get.back(result: {
            "title": titleController.text,
            "description": descriptionController.text
          });
          titleController.text = "";
          descriptionController.text = "";
        }
      } else {
        if (!isNetworkAvailable.value) {
          Get.back();
          return SnackbarUtils.instance
              .failureSnackbar("No Network Connection");
        } else {
          createNote();
          titleController.text = "";
          descriptionController.text = "";
          Get.back();
          Get.back();
          Get.put(HomeController());
          Get.find<HomeController>().init();
        }
      }
    }
  }
}
