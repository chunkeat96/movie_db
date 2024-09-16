import 'package:get/get.dart';
import 'package:movie_db/model/recent_searches_model.dart';
import 'package:sp_util/sp_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends GetxService {
  static const _LANG_ID = 'lang_id';
  static const _OTP_EXPIRED_DATE = "otp_expired_date";
  static const _RECENT_SEARCHES = "recent_searches";

  late SharedPreferences sharedPreferences;

  Future<LocalStorage> init() async {
    await SpUtil.getInstance();
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future setLangId(String? langId) async {
    await SpUtil.putString(_LANG_ID, langId ?? '');
  }

  String get langId {
    return SpUtil.getString(_LANG_ID, defValue: 'en')!;
  }

  Future setOtpExpiredDate(int? timeStamp) async {
    await SpUtil.putInt(_OTP_EXPIRED_DATE, timeStamp ?? 0);
  }

  int get otpExpiredDate {
    return SpUtil.getInt(_OTP_EXPIRED_DATE, defValue: 0)!;
  }

  List<RecentSearchesModel> get recentSearchesList {
    return SpUtil.getObjList<RecentSearchesModel>(_RECENT_SEARCHES, (map) {
      return RecentSearchesModel.fromJson(map);
    }, defValue: <RecentSearchesModel>[])!;
  }

  Future setRecentSearchesList(RecentSearchesModel recentSearchesModel) async {
    List<RecentSearchesModel> list = recentSearchesList;
    int index = list.indexWhere((element) => element.id == recentSearchesModel.id);
    if (index == -1) {
      list.add(recentSearchesModel);
      await SpUtil.putObjectList(_RECENT_SEARCHES, list);
    }
  }

  Future clearRecentSearchesList() async {
    await SpUtil.putObjectList(_RECENT_SEARCHES, []);
  }

  clear() async {
    await SpUtil.remove(_OTP_EXPIRED_DATE);
  }
}