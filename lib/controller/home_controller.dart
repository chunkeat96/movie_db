import 'package:movie_db/controller/base/state_controller.dart';
import 'package:movie_db/model/popular_model.dart';
import 'package:movie_db/service/home_service.dart';

class HomeController extends StateController {

  final _homeService = HomeService();

  List<Results> nowPlayingList = [];
  List<Results> popularList = [];
  List<Results> topRatedList = [];
  List<Results> upcomingList = [];

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  initData() async {
    await _getNowPlayingList();
    await _getPopularList();
    await _getTopRatedList();
    await _getUpcomingList();
    update();
  }

  _getNowPlayingList() async {
    var entity = await _homeService.getNowPlayingList();
    if (checkEntity(entity)) {
      nowPlayingList = entity.data?.results ?? [];
    }
  }

  _getPopularList() async {
    var entity = await _homeService.getPopularList();
    if (checkEntity(entity)) {
      popularList = entity.data?.results ?? [];
    }
  }

  _getTopRatedList() async {
    var entity = await _homeService.getTopRatedList();
    if (checkEntity(entity)) {
      topRatedList = entity.data?.results ?? [];
    }
  }

  _getUpcomingList() async {
    var entity = await _homeService.getUpcomingList();
    if (checkEntity(entity)) {
      upcomingList = entity.data?.results ?? [];
    }
  }
}