import 'package:flutter/material.dart';
import 'package:movie_db/controller/profile_controller.dart';
import 'package:movie_db/controller/widget/view_state_busy_widget.dart';
import 'package:movie_db/controller/widget/view_state_empty_widget.dart';
import 'package:movie_db/controller/widget/view_state_info_widget.dart';
import 'package:movie_db/controller/widget/view_state_widget.dart';
import 'package:movie_db/res/label.dart';
import 'package:movie_db/routes/app_routes.dart';
import 'package:movie_db/server/response_entity.dart';
import 'package:movie_db/utils/show_utils.dart';
import 'package:movie_db/widget/message_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

enum ViewState {
  idle,
  busy,
  empty,
  info,
  error
}

class StateController extends GetxController {
  ViewState viewState = ViewState.idle;

  String? _message;

  bool get idle => viewState == ViewState.idle;

  bool get busy => viewState == ViewState.busy;

  bool get empty => viewState == ViewState.empty;

  bool get info => viewState == ViewState.info;

  bool get error => viewState == ViewState.error;

  void setBusy(bool value) {
    _message = null;
    viewState = value ? ViewState.busy : ViewState.idle;
    update();
  }

  void setEmpty() {
    _message = null;
    viewState = ViewState.empty;
    update();
  }

  void setInfo(String message) {
    _message = message;
    viewState = ViewState.info;
    update();
  }

  void setError(String message) {
    _message = message;
    viewState = ViewState.error;
    update();
  }

  initData() async {}

  // this function will not call update, after call this function must update the controller
  checkEntity(ResponseEntity entity, {bool needStopLoading = true}) {
    if (entity.success) {
      if (needStopLoading) {
        viewState = ViewState.idle;
        stopLoading();
      }
      return true;
    } else {
      viewState = ViewState.error;
      _message = entity.message;
      stopLoading();

      handleError(entity);
      return false;
    }
  }

  handleError(ResponseEntity entity) {
    if (entity.statusCode == HttpStatus.unauthorized) {
      // TODO: clear user data
      Get.find<ProfileController>().clearUser();
      onUnauthorizedError(entity.message);
    } else if (entity.statusCode == HttpStatus.badRequest) {
      onResponseError(entity.message);
    } else {
      onDioError(entity.message);
    }
  }

  onUnauthorizedError(String message) {
    showUnauthorizedDialog(message);
  }

  onResponseError(String message) {
    showErrorDialog(message);
  }

  onDioError(String message) {
    showErrorDialog(message);
  }

  Future showUnauthorizedDialog(String msg) async {
    if (Get.overlayContext != null) {
      await Get.dialog(MessageDialog(msg, isError: true, dismissible: false, onSubmit: () {
        // TODO: push to login
        Get.offAllNamed(AppRoutes.signInPage);
      },), barrierDismissible: false);
    }
  }

  Future showErrorDialog(String msg, {VoidCallback? onSubmit}) async {
    if (Get.overlayContext != null) {
      await Get.dialog(MessageDialog(msg, isError: true, onSubmit: onSubmit,));
    }
  }

  Future showSuccessDialog(String msg, {VoidCallback? onSubmit}) async {
    await Get.dialog(MessageDialog(msg, onSubmit: onSubmit,));
  }

  showLoading({bool barrierDismissible = false}) {
    Show.showLoading(barrierDismissible: barrierDismissible);
  }

  stopLoading() {
    Show.stopLoading();
  }

  Widget showViewByState({required Widget child, Widget? viewEmpty, Widget? viewBusy,
    bool isSliver = false, bool showEmptyButton = true}) {
    Widget content;

    switch (viewState) {
      case ViewState.idle:
        return child;
      case ViewState.busy:
        content = viewBusy ?? const ViewStateBusyWidget();
        break;
      case ViewState.empty:
        content = viewEmpty ??
            ViewStateEmptyWidget(
                message: Label.noData.tr,
                buttonText: showEmptyButton ? Label.touchScreenToTryAgain.tr : null,
                onPressed: showEmptyButton ? () {
                  initData();
                } : null);
        break;
      case ViewState.error:
        content = ViewStateWidget(
            message: _message ?? '',
            buttonText: Label.touchScreenToTryAgain.tr,
            onPressed: () {
              initData();
            }
        );
        break;
      case ViewState.info:
        content = ViewStateInfoWidget(
          message: _message ?? '',
        );
        break;
    }

    if (isSliver) {
      return SliverFillRemaining(
        child: content,
      );
    } else {
      return content;
    }
  }
}