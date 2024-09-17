import 'package:movie_db/model/cast_details_model.dart';
import 'package:movie_db/model/combined_credits_model.dart';
import 'package:movie_db/server/response_entity.dart';
import 'package:movie_db/service/base_service.dart';

class CastDetailsService extends BaseService {

  Future<ResponseEntity<CastDetailsModel>> getCastDetails(int personId) async {
    var entity = await serverRepository.loadEntityData(
      '/person/$personId', method: 'GET', query: {},
      decoder: (json) => CastDetailsModel.fromJson(json)
    );

    return entity;
  }

  Future<ResponseEntity<CombinedCreditsModel>> getCombinedCredits(int personId) async {
    var entity = await serverRepository.loadEntityData(
      '/person/$personId/movie_credits', method: 'GET', query: {},
      decoder: (json) => CombinedCreditsModel.fromJson(json)
    );

    return entity;
  }
}