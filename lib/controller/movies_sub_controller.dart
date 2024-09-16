import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/controller/base/state_pagination_controller.dart';
import 'package:movie_db/model/discover_movie_model.dart';
import 'package:movie_db/service/movies_service.dart';

class MoviesSubController extends StatePaginationController<Results> {
  final int genreId;

  MoviesSubController(this.genreId);

  final _moviesService = MoviesService();

  final ScrollController scrollController = ScrollController();
  final scrollOnTop = true.obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  @override
  Future<List<Results>> loadData({int pageNum = 1}) async {
    var entity = await _moviesService.getMoviesList(genreId, page: pageNum);
    checkEntity(entity);
    return entity.data?.results ?? [];
  }
}