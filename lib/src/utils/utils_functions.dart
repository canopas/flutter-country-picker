import 'package:flutter/cupertino.dart' show BuildContext, MediaQuery;

class UtilsFunctions {
  static double manageSheetSize(
      {required BuildContext context,
      required double initialSize,
      required double maxSize,
      required double minSize}) {
    final double sheetSize = initialSize +
        (MediaQuery.of(context).viewInsets.bottom /
            MediaQuery.of(context).size.height);

    if (sheetSize > maxSize) {
      return maxSize;
    } else if (sheetSize < minSize) {
      return minSize;
    }

    return sheetSize;
  }
}
