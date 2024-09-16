import 'package:movie_db/server/server_repository.dart';
import 'package:get/instance_manager.dart';

class BaseService {
  ServerRepository get serverRepository => Get.find<ServerRepository>();
}