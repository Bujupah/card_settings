// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

import '../../interfaces/text_field_properties.dart';

/// This is a phone number field. It's designed for US numbers
class CardSettingsDouble extends StatelessWidget
    implements ICommonFieldProperties, ITextFieldProperties {
  CardSettingsDouble({
    Key key,
    this.label: 'Label',
    this.labelWidth,
    this.labelAlign,
    this.hintText,
    this.prefixText,
    this.contentAlign,
    this.initialValue,
    this.contentOnNewLine = false,
    this.maxLength = 10,
    this.decimalDigits = 2,
    this.icon,
    this.requiredIndicator,
    this.unitLabel,
    this.visible: true,
    this.enabled: true,
    this.autofocus: false,
    this.obscureText: false,
    this.autocorrect: false,
    //this.autovalidate: false,
    this.autovalidateMode : AutovalidateMode.onUserInteraction,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.inputAction,
    this.inputActionNode,
    this.keyboardType,
    this.style,
    this.maxLengthEnforced: true,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.showMaterialonIOS,
    this.locale,
    this.fieldPadding,
  });

  @override
  final String label;

  @override
  final double labelWidth;

  @override
  final TextAlign labelAlign;

  @override
  final TextAlign contentAlign;

  @override
  final String hintText;

  final String prefixText;

  final double initialValue;

  final bool contentOnNewLine;

  final int maxLength;

  final String unitLabel;

  @override
  final Icon icon;

  @override
  final Widget requiredIndicator;

  @override
  final bool visible;

  final bool enabled;

  final bool autofocus;

  final bool obscureText;

  final bool autocorrect;

/*   @override
  final bool autovalidate; */
  @override
  final AutovalidateMode autovalidateMode;

  @override
  final FormFieldValidator<double> validator;

  @override
  final FormFieldSetter<double> onSaved;

  @override
  final ValueChanged<double> onChanged;

  final TextEditingController controller;

  final FocusNode focusNode;

  final FocusNode inputActionNode;

  final TextInputType keyboardType;

  final TextStyle style;

  final TextInputAction inputAction;

  final bool maxLengthEnforced;

  final int decimalDigits;

  final ValueChanged<String> onFieldSubmitted;

  final List<TextInputFormatter> inputFormatters;

  final Locale locale;

  @override
  final bool showMaterialonIOS;

  @override
  final EdgeInsetsGeometry fieldPadding;

  @override
  Widget build(BuildContext context) {
    var myLocale = locale ?? Localizations.localeOf(context);

    var pattern = "#,###" +
        ((decimalDigits > 0) ? ".".padRight(decimalDigits + 1, "#") : "");

    var formatter = NumberFormat(pattern, myLocale.languageCode);

    return CardSettingsText(
      key: key,
      label: label,
      hintText: hintText,
      showMaterialonIOS: showMaterialonIOS,
      fieldPadding: fieldPadding,
      labelAlign: labelAlign,
      labelWidth: labelWidth,
      contentAlign: contentAlign,
      initialValue: formatter.format(initialValue),
      unitLabel: unitLabel,
      icon: icon,
      requiredIndicator: requiredIndicator,
      maxLength: maxLength,
      visible: visible,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: obscureText,
      autocorrect: autocorrect,
      //autovalidate: autovalidate,
      autovalidateMode: autovalidateMode,
      validator: (val) => _safeValidator(val, formatter),
      onSaved: (val) => _safeOnSaved(val, formatter),
      onChanged: (val) => _safeOnChanged(val, formatter),
      controller: controller,
      focusNode: focusNode,
      inputAction: inputAction,
      inputActionNode: inputActionNode,
      keyboardType:
          keyboardType ?? TextInputType.numberWithOptions(decimal: true),
      style: style,
      maxLengthEnforced: maxLengthEnforced,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: [
        ThousandsFormatter(
            formatter: formatter, allowFraction: (decimalDigits > 0)),
        LengthLimitingTextInputFormatter(maxLength),
      ],
    );
  }

  String _safeValidator(String value, NumberFormat formatter) {
    if (validator == null) return null;
    var number = formatter.parse(value);
    return validator(intelligentCast<double>(number));
  }

  void _safeOnSaved(String value, NumberFormat formatter) {
    if (onSaved == null) return;
    var number = formatter.parse(value);
    onSaved(intelligentCast<double>(number));
  }

  void _safeOnChanged(String value, NumberFormat formatter) {
    if (onChanged == null) return;
    var number = formatter.parse(value);
    onChanged(intelligentCast<double>(number));
  }
}
