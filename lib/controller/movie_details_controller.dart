import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_db/controller/base/state_controller.dart';
import 'package:movie_db/model/movie_casts_model.dart';
import 'package:movie_db/model/movie_details_model.dart';
import 'package:movie_db/model/movie_videos_model.dart';
import 'package:movie_db/service/movie_details_service.dart';
import 'package:movie_db/utils/data_extension.dart';

class MovieDetailsController extends StateController {
  final _movieDetailsService = MovieDetailsService();

  late int movieId;

  final InAppWebViewSettings options = InAppWebViewSettings(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      useHybridComposition: false,
      allowsInlineMediaPlayback: true,
  );

  List<Results> oriVideosList = [];
  List<String> get videosList => oriVideosList.map(
          (e) => 'https://www.themoviedb.org/video/play?key=${e.key}&width=1085&height=610').toList();
  String get firstVideo => videosList.isNotEmpty ? videosList.first : '';

  MovieDetailsModel? _movieDetailsModel;
  String get title => _movieDetailsModel?.title ?? '';
  String get overview => _movieDetailsModel?.overview ?? '';
  String get releaseDate => _movieDetailsModel?.releaseDate ?? '';
  String get posterPath => _movieDetailsModel?.posterPath.baseImageUrl ?? '';
  List<String> get genres => _movieDetailsModel?.genres?.map((e) => e.name ?? '').toList() ?? [];
  String get displayGenres => genres.join(', ');
  String get status => _movieDetailsModel?.status ?? '';
  String get oriLanguage => _movieDetailsModel?.originalLanguage ?? '';
  num get budget => _movieDetailsModel?.budget ?? 0;
  String get displayBudget => '\$${NumberFormat('###,##0.00').format(budget)}';
  num get revenue => _movieDetailsModel?.revenue ?? 0;
  String get displayRevenue => '\$${NumberFormat('###,##0.00').format(revenue)}';
  String get runtime {
    final temp = _movieDetailsModel?.runtime ?? 0;
    if (temp == 0) {
      return '';
    }
    return '  (${temp ~/ 60}h ${temp % 60}m)';
  }

  List<Cast> castsList = [];
  List<Cast> get cutCastsList => castsList.take(10).toList();

  @override
  void onInit() {
    movieId = Get.arguments ?? 0;
    initData();
    super.onInit();
  }

  @override
  initData() async {
    await _getDetails();
    await _getVideos();
    await _getCasts();
    update();
  }

  _getDetails() async {
    var entity = await _movieDetailsService.getMovieDetails(movieId);
    if (checkEntity(entity, needStopLoading: false)) {
      _movieDetailsModel = entity.data;
    }
  }

  _getVideos() async {
    var entity = await _movieDetailsService.getMovieVideos(movieId);
    if (checkEntity(entity, needStopLoading: false)) {
      oriVideosList = entity.data?.results?.where(
              (element) => element.type == 'Trailer').toList() ?? [];
    }
  }

  _getCasts() async {
    var entity = await _movieDetailsService.getMovieCasts(movieId);
    if (checkEntity(entity)) {
      castsList = entity.data?.cast ?? [];
    }
  }
}
