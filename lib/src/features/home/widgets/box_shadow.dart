import 'package:flutter/cupertino.dart';
import 'package:petscape/src/shared/theme.dart';

BoxShadow buildPrimaryBoxShadow() {
  return BoxShadow(color: black.withOpacity(0.10), blurRadius: 4, spreadRadius: 0, offset: const Offset(0, 2));
}

BoxShadow buildSecondaryBoxShadow() {
  return BoxShadow(color: black.withOpacity(0.10), blurRadius: 4, spreadRadius: 0, offset: const Offset(0, -2));
}
