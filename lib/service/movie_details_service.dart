import 'package:movie_db/model/movie_details_model.dart';
import 'package:movie_db/model/movie_videos_model.dart';
import 'package:movie_db/server/response_entity.dart';
import 'package:movie_db/service/base_service.dart';

class MovieDetailsService extends BaseService {

  Future<ResponseEntity<MovieDetailsModel>> getMovieDetails(int movieId) async {
    var entity = await serverRepository.loadEntityData(
      '/movie/$movieId', method: 'GET', query: {},
      decoder: (json) => MovieDetailsModel.fromJson(json)
    );

    return entity;
  }

  Future<ResponseEntity<MovieVideosModel>> getMovieVideos(int movieId) async {
    var entity = await serverRepository.loadEntityData(
      '/movie/$movieId/videos', method: 'GET', query: {},
      decoder: (json) => MovieVideosModel.fromJson(json)
    );

    return entity;
  }
}