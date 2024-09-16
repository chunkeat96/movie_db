import 'package:movie_db/controller/base/state_controller.dart';
import 'package:get/get.dart';
import 'package:movie_db/global/local_storage.dart';
import 'package:movie_db/model/recent_searches_model.dart';
import 'package:movie_db/service/search_service.dart';

import 'package:movie_db/model/search_model.dart';

class SearchController extends StateController {
  final _searchService = SearchService();

  final searchQuery = ''.obs;
  List<Results> searchList = [];
  List<RecentSearchesModel> recentSearchList = [];

  @override
  void onInit() {
    debounce(searchQuery, (text) => _searchMovies(text));
    initData();
    super.onInit();
  }

  @override
  initData() {
    setRecentSearchList();
  }

  setRecentSearchList() {
    recentSearchList = Get.find<LocalStorage>().recentSearchesList;
    update();
  }

  clearRecentSearchList() async {
    await Get.find<LocalStorage>().clearRecentSearchesList();
    recentSearchList = [];
    update();
  }

  @override
  void onClose() {
    searchQuery.close();
    super.onClose();
  }

  _searchMovies(String query) async {
    var entity = await _searchService.search(query);
    if (checkEntity(entity)) {
      searchList = entity.data?.results ?? [];
      update();
    }
  }
}