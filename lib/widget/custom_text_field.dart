import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_db/model/select_option.dart';
import 'package:movie_db/res/label.dart';
import 'package:movie_db/utils/date_manager.dart';
import 'package:movie_db/utils/dialog_utils.dart';
import 'package:movie_db/widget/load_image.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final int maxLines;
  final bool obscureText;
  final String? prefixImage;
  final IconData? suffixIcon;
  final Color hintTextColor;
  final bool centerText;
  final double? contentPadding;
  final Color fillColor;
  final bool withShadow;
  final bool isItalic;
  final FormFieldValidator<String>? validator;
  final bool checkEmpty;
  final AutovalidateMode autoValidateMode;
  final String? labelText;
  final bool canInteract;
  final Function? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool autoFocus;
  final SelectOption? selectOption;
  final List<SelectOption>? selectionList;
  final Function(SelectOption)? onSelection;
  final Function? onRefreshList;
  final Function(DateTime)? onSelectDate;
  final bool outlineBorder;
  final bool dob;
  final List<TextInputFormatter> inputFormatters;
  final String datePickerFormat;
  final String? prefixText;
  final Widget? suffix;
  final String? selectOptionTitle;
  final double borderRadius;
  final Color borderColor;
  final Color suffixIconColor;

  const CustomTextField(
      {super.key, this.controller,
        this.hintText,
        this.textInputType = TextInputType.text,
        this.textInputAction = TextInputAction.next,
        this.maxLines = 1,
        this.obscureText = false,
        this.prefixImage,
        this.suffixIcon,
        this.hintTextColor = Colors.grey,
        this.centerText = false,
        this.contentPadding,
        this.fillColor = Colors.white,
        this.withShadow = false,
        this.isItalic = false,
        this.validator,
        this.checkEmpty = false,
        this.autoValidateMode = AutovalidateMode.onUserInteraction,
        this.labelText,
        this.canInteract = true,
        this.onTap,
        this.onChanged,
        this.onFieldSubmitted,
        this.autoFocus = false,
        this.selectOption,
        this.selectionList,
        this.onSelection,
        this.onRefreshList,
        this.onSelectDate,
        this.outlineBorder = true,
        this.dob = false,
        this.inputFormatters = const [],
        this.datePickerFormat = 'dd MMM yyyy',
        this.prefixText,
        this.suffix,
        this.selectOptionTitle,
        this.borderRadius = 25.0,
        this.borderColor = Colors.grey,
        this.suffixIconColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    Widget body = TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: outlineBorder
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          )
              : OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: BorderSide.none),
          focusedBorder: outlineBorder
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          )
              : OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: BorderSide.none),
          enabledBorder: outlineBorder
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          )
              : OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: BorderSide.none),
          fillColor: fillColor,
          filled: true,
          hintText: hintText,
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.grey[700]
          ),
          hintStyle: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: hintTextColor, fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
          prefixIcon: prefixImage == null
              ? null
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: LoadAssetImage(
              prefixImage,
              width: 20.0,
              fit: BoxFit.fitWidth,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          prefixText: prefixText,
          suffixIcon: !canInteract && selectionList != null
              ? const Padding(
            padding: EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
          )
              : suffixIcon == null
              ? null
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(
              suffixIcon,
              color: suffixIconColor,
            ),
          ),
          suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffix: suffix,
          isDense: true,
          errorMaxLines: 2,
          contentPadding: contentPadding == null ? null : EdgeInsets.all(contentPadding!)),
      textAlign: centerText ? TextAlign.center : TextAlign.left,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
      maxLines: maxLines,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enableInteractiveSelection: canInteract,
      focusNode: canInteract ? null : AlwaysDisabledFocusNode(),
      autofocus: autoFocus,
      autovalidateMode: autoValidateMode,
      //disable emoji by default
      inputFormatters: [
        FilteringTextInputFormatter.deny(
            RegExp(
                r'(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|\ud83c[\ude32-\ude3a]|\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff])'
            )
        ), ...inputFormatters
      ],
      validator: (text) {
        if (text?.isEmpty == true && checkEmpty) {
          return labelText?.isNotEmpty == true ? '$labelText ${Label.isRequired.tr}' : Label.thisFieldIsRequired.tr;
        }

        if (validator != null) {
          return validator!.call(text);
        }

        return null;
      },
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: () =>
      textInputAction == TextInputAction.next ? FocusScope.of(context).nextFocus() : FocusScope.of(context).unfocus(),
      onTap: canInteract
          ? null
          : () {
        if (textInputType == TextInputType.datetime) {
          DialogUtils.showDatePickerDialog(context, (date) {
            controller?.text = DateManager.formatDateToString(date, dateFormat: datePickerFormat);
            onSelectDate?.call(date);
          }, dob: dob, initDate: DateManager.formatStringToDate(controller?.text ?? '', dateFormat: datePickerFormat));
        } else if (selectionList != null) {
          _onTap(context);
        } else {
          onTap?.call();
        }
      },
    );

    if (withShadow) {
      return Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        child: body,
      );
    } else {
      return body;
    }
  }

  _onTap(BuildContext context) {
    if (selectionList?.isNotEmpty == true) {
      DialogUtils.showPicker(
          title: selectOptionTitle,
          currentOption: selectOption,
          list: selectionList,
          onSelect: (value) {
            controller?.text = value.name ?? '';
            onSelection?.call(value);
          });
    } else {
      onRefreshList?.call();
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
