import 'package:get/get.dart';
import 'package:http/http.dart';
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
    title.value = viewNote["title"];
    description.value = viewNote["description"];
  }

  editNavigation() {
    Get.put(CreateController());
    Get.to(CreateView(
      note: viewNote,
    ));
  }
}
