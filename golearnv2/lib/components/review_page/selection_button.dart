import 'package:flutter/material.dart';
import 'package:golearnv2/enums/selection_type.dart';
import 'package:golearnv2/notifiers/review_notifier.dart';
import 'package:golearnv2/utils/methods.dart';
import 'package:provider/provider.dart';

class SelectionButton extends StatelessWidget {
  const SelectionButton({
    required this.selectType,
    this.isDisabled = false,
    Key? key,
  }) : super(key: key);

  final SelectionType selectType;
  final bool isDisabled;

//THIS IS THE CODE FOR SELECTION BOTTON FOR THE REVIEW PAGE
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(6, 1, 6, 1),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor),
          onPressed: isDisabled
              ? null
              : () {
                  Provider.of<ReviewNotifier>(context, listen: false)
                      .updateShowType(
                    select: selectType,
                  );
                },
          child: Text(selectType.toSymbol())),
    ));
  }
}
