import 'package:movie_db/model/search_model.dart';
import 'package:movie_db/server/api.dart';
import 'package:movie_db/server/response_entity.dart';
import 'package:movie_db/service/base_service.dart';

class SearchService extends BaseService {

  Future<ResponseEntity<SearchModel>> search(String query) async {
    Map<String, dynamic> params = {};
    params['page'] = '1';
    params['include_adult'] = 'false';
    params['query'] = query;

    var entity = await serverRepository.loadEntityData(
      Api.search, query: params, method: 'GET',
      decoder: (json) => SearchModel.fromJson(json)
    );

    return entity;
  }
}