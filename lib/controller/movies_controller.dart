import 'package:movie_db/controller/base/state_controller.dart';
import 'package:movie_db/model/genre_list_model.dart';
import 'package:movie_db/service/movies_service.dart';

class MoviesController extends StateController {

  final _moviesService = MoviesService();
  List<Genres> genreList = [];

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  initData() async {
    await _getGenreList();
    update();
  }

  _getGenreList() async {
    var entity = await _moviesService.getGenreList();
    if (checkEntity(entity)) {
      genreList = entity.data?.genres ?? [];
    }
  }
}