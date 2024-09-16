import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:movie_db/res/label.dart';

class PickerContainer extends StatelessWidget {
  final String? title;
  final Function()? onDone;
  final Widget? picker;

  const PickerContainer({
    super.key,
    this.title,
    this.onDone,
    this.picker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0)
          )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Text(title ??'',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 18.0
                ),),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    Label.cancel.tr,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context).primaryColorDark
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onDone,
                  child: Text(
                    Label.done.tr,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context).primaryColorDark
                    ),
                  )
                ),
              ),
            ],
          ),
          Divider(color: Theme.of(context).primaryColorDark,),
          SizedBox(
            height: 200.0,
            child: picker,
          ),
        ],
      ),
    );
  }
}
