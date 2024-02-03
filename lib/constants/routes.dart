import 'package:get/get.dart';
import 'package:notes_app/constants/app_paths.dart';
import 'package:notes_app/pages/create_note/create.binding.dart';
import 'package:notes_app/pages/create_note/create.view.dart';
import 'package:notes_app/pages/home/home.binding.dart';
import 'package:notes_app/pages/home/home.view.dart';
import 'package:notes_app/pages/search/search.binding.dart';
import 'package:notes_app/pages/search/search.view.dart';
import 'package:notes_app/pages/view_note/view.binding.dart';
import 'package:notes_app/pages/view_note/view.view.dart';

class AppRoutes {
  AppRoutes._();
static const inital = AppPaths.home;
  static final route = [
    GetPage(
        binding: HomeBinding(), name: AppPaths.home, page: () => HomeView()),
    GetPage(
        binding: CreateBinding(),
        name: AppPaths.edit,
        page: () => CreateView()),
    GetPage(
        binding: ViewBindings(), name: AppPaths.home, page: () => ViewView()),
    GetPage(
        binding: SearchBinding(),
        name: AppPaths.home,
        page: () => SearchView()),
  
  ];
}
