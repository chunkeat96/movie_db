import 'package:movie_db/model/discover_movie_model.dart';
import 'package:movie_db/model/genre_list_model.dart';
import 'package:movie_db/server/api.dart';
import 'package:movie_db/server/response_entity.dart';
import 'package:movie_db/service/base_service.dart';
import 'package:movie_db/utils/date_manager.dart';

class MoviesService extends BaseService {

  Future<ResponseEntity<GenreListModel>> getGenreList() async {
    Map<String, dynamic> params = {};

    var entity = await serverRepository.loadEntityData(
      Api.getGenres, query: params, method: 'GET',
      decoder: (json) => GenreListModel.fromJson(json)
    );

    return entity;
  }

  Future<ResponseEntity<DiscoverMovieModel>> getMoviesList(int genreId, {int page = 1}) async {
    Map<String, dynamic> params = {};
    params['with_genres'] = genreId.toString();
    params['sort_by'] = 'primary_release_date.desc';
    params['primary_release_date.lte'] = DateManager.todayDate();
    params['page'] = page.toString();

    var entity = await serverRepository.loadEntityData(
      Api.discoverMovie, query: params, method: 'GET',
      decoder: (json) => DiscoverMovieModel.fromJson(json)
    );

    return entity;
  }
}