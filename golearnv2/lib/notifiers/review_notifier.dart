import 'package:flutter/material.dart';
import 'package:golearnv2/enums/selection_type.dart';

class ReviewNotifier extends ChangeNotifier {
  bool showImage = true,
      showWord = true,
      showType = false,
      buttonsAreDisabled = false;

//THIS IS THE CODE FOR THE REVIEW NOTIFIERS

  disableButtons({required bool disable}) {
    buttonsAreDisabled = disable;
    notifyListeners();
  }

  updateShowType({required SelectionType select}) {
    switch (select) {
      case SelectionType.image:
        showImage = !showImage;
        break;

      case SelectionType.word:
        showWord = !showWord;
        break;
      case SelectionType.type:
        showType = !showType;
        break;
    }

    notifyListeners();
  }
}
