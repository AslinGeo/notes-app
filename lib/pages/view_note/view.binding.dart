import 'package:get/get.dart';
import 'package:notes_app/pages/view_note/view.controller.dart';

class ViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ViewController());
  }
}
