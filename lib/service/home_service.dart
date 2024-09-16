import 'package:movie_db/model/popular_model.dart';
import 'package:movie_db/server/api.dart';
import 'package:movie_db/server/response_entity.dart';
import 'package:movie_db/service/base_service.dart';

class HomeService extends BaseService {

  Future<ResponseEntity<PopularModel>> getPopularList({String page = '1'}) async {
    var entity = await serverRepository.loadEntityData(
      Api.getPopularList, query: {'page': page}, method: 'GET',
      decoder: (json) => PopularModel.fromJson(json)
    );

    return entity;
  }

  Future<ResponseEntity<PopularModel>> getNowPlayingList({String page = '1'}) async {
    var entity = await serverRepository.loadEntityData(
      Api.getNowPlaying, query: {'page': page}, method: 'GET',
      decoder: (json) => PopularModel.fromJson(json)
    );

    return entity;
  }

  Future<ResponseEntity<PopularModel>> getTopRatedList({String page = '1'}) async {
    var entity = await serverRepository.loadEntityData(
        Api.getTopRated, query: {'page': page}, method: 'GET',
        decoder: (json) => PopularModel.fromJson(json)
    );

    return entity;
  }

  Future<ResponseEntity<PopularModel>> getUpcomingList({String page = '1'}) async {
    var entity = await serverRepository.loadEntityData(
        Api.getUpcoming, query: {'page': page}, method: 'GET',
        decoder: (json) => PopularModel.fromJson(json)
    );

    return entity;
  }
}