import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:notes_app/constants/app_paths.dart';
import 'package:notes_app/pages/create_note/create.controller.dart';
import 'package:notes_app/pages/create_note/create.view.dart';
import 'package:notes_app/pages/view_note/view.variable.dart';

class ViewController extends GetxController with ViewVariables {
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
    var data = Get.arguments;
    title.value = data["title"];
    description.value = data["description"];
  }

  editNavigation() async {
    var result = await Get.toNamed(AppPaths.edit, arguments: viewNote);
    if (result != null) {
      title.value = result["title"];
      description.value = result["description"];
      viewNote["title"] = title.value;
      viewNote["description"] = description.value;
      description.refresh();
      title.refresh();
    }
  }
}
