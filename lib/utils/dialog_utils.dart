import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/model/select_option.dart';
import 'package:movie_db/widget/image_picker_dialog.dart';
import 'package:movie_db/widget/picker_container.dart';

typedef DateToVoidFunc = void Function(DateTime);

class DialogUtils {
  static void showDatePickerDialog(BuildContext context, DateToVoidFunc onPick,
      {DateTime? initDate,
        DateTime? dateFrom,
        DateTime? dateTo,
        bool dob = false}) {
    showDatePicker(
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Theme.of(context).primaryColor,
              buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme:
              ColorScheme.light(primary: Theme.of(context).primaryColor)
                  .copyWith(secondary: Theme.of(context).primaryColor),
            ),
            child: child ?? Container(),
          );
        },
        context: context,
        initialDate: initDate ?? DateTime.now(),
        firstDate: dob ? DateTime(1919) : DateTime.now(),
        lastDate: dob ? DateTime.now() : DateTime(2121),
        selectableDayPredicate: (date) {
          if (dateFrom == null && dateTo == null) {
            return true;
          }
          if (dateTo != null && date.isBefore(dateTo) || date == dateTo) {
            return true;
          } else if (dateFrom != null && date.isAfter(dateFrom) ||
              date == dateFrom) {
            return true;
          }
          return false;
        }).then((DateTime? date) {
      if (date != null) {
        onPick(date);
      }
    });
  }

  static void showPicker(
      {String? title,
        SelectOption? currentOption,
        List<SelectOption>? list,
        Function(SelectOption)? onSelect}) async {
    SelectOption? selectOption = currentOption;
    int initialItem =
        list?.indexWhere((element) => element.id == currentOption?.id) ?? 0;
    await Get.bottomSheet(PickerContainer(
      title: title,
      onDone: () {
        if (list?.isNotEmpty == true) {
          onSelect?.call(selectOption ?? list!.first);
        }
        Get.back();
      },
      picker: CupertinoPicker(
          itemExtent: 50,
          scrollController:
          FixedExtentScrollController(initialItem: initialItem),
          onSelectedItemChanged: (index) {
            selectOption = list?.elementAt(index);
          },
          children: List<Widget>.generate(list?.length ?? 0, (index) {
            return Center(
              child: Text(
                list?[index].name ?? '',
              ),
            );
          })),
    ));
  }

  static void showTimePicker(
      {String? title,
        DateTime? initTime,
        Function(DateTime time)? onSelect}) async {
    DateTime durationTime = initTime ?? DateTime.now();

    await Get.bottomSheet(PickerContainer(
      title: title,
      onDone: () {
        onSelect?.call(durationTime);
        Get.back();
      },
      picker: CupertinoDatePicker(
        initialDateTime: initTime,
        mode: CupertinoDatePickerMode.time,
        use24hFormat: false,
        onDateTimeChanged: (dateTime) {
          durationTime = dateTime;
        },
      ),
    ));
  }

  static void showPickerDialog({Function(File)? onPickImage}) async {
    await Get.bottomSheet(ImagePickerDialog(
      onPickImage: onPickImage,
    ));
  }
}
