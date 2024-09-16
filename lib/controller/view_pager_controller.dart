import 'package:movie_db/controller/base/state_pagination_controller.dart';
import 'package:movie_db/model/popular_model.dart';
import 'package:movie_db/service/home_service.dart';

class ViewPagerController extends StatePaginationController<Results> {
  final _homeService = HomeService();

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  Future<List<Results>> loadData({int pageNum = 1}) async {
    var entity = await _homeService.getPopularList(page: pageNum.toString());
    checkEntity(entity);
    return entity.data?.results ?? [];
  }
}