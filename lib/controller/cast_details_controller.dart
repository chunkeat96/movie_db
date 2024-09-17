import 'package:get/get.dart';
import 'package:movie_db/controller/base/state_controller.dart';
import 'package:movie_db/model/cast_details_model.dart';
import 'package:movie_db/model/combined_credits_model.dart';
import 'package:movie_db/service/cast_details_service.dart';
import 'package:movie_db/utils/data_extension.dart';
import 'package:movie_db/utils/date_manager.dart';

class CastDetailsController extends StateController {
  final _castDetailsService = CastDetailsService();

  late int personId;

  CastDetailsModel? _castDetailsModel;
  String get name => _castDetailsModel?.name ?? '';
  String get profilePath => _castDetailsModel?.profilePath?.baseImageUrl ?? '';
  String get knownFor => _castDetailsModel?.knownForDepartment ?? '';
  DateTime get formatDob => _castDetailsModel?.birthday ?? DateTime.now();
  String get birthday => DateManager.formatDateToString(formatDob, dateFormat: 'MMMM dd, yyyy');
  String get placeOfBirth => _castDetailsModel?.placeOfBirth ?? '';
  String get aka => _castDetailsModel?.alsoKnownAs?.join(', ') ?? '';
  String get biography => _castDetailsModel?.biography ?? '';

  List<Cast> _combinedCredits = [];
  List<Cast> get cutCombinedCredits => _combinedCredits.take(10).toList();

  @override
  void onInit() {
    personId = Get.arguments ?? 0;
    initData();
    super.onInit();
  }

  @override
  initData() async {
    setBusy(true);
    await _getCastDetails();
    await _getCombinedCredits();
    setBusy(false);
  }

  refreshPage() async {
    await _getCastDetails();
    await _getCombinedCredits();
    update();
  }

  _getCastDetails() async {
    var entity = await _castDetailsService.getCastDetails(personId);
    if (checkEntity(entity, needStopLoading: false)) {
      _castDetailsModel = entity.data;
    }
  }

  _getCombinedCredits() async {
    var entity = await _castDetailsService.getCombinedCredits(personId);
    if (checkEntity(entity, needStopLoading: false)) {
      final tempList = entity.data?.cast ?? [];
      tempList.sort((a, b) => b.formatPopularity.compareTo(a.formatPopularity));
      _combinedCredits = tempList;
    }
  }
}