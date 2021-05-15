import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:toast/toast.dart';

abstract class StringValidator {
  bool isValid(String value);
}

class RegexValidator implements StringValidator {
  RegexValidator({this.regexSource});
  final String regexSource;

  /// value: the input string
  /// returns: true if the input string is a full match for regexSource
  @override
  bool isValid(String value) {
    try {
      final regex = RegExp(regexSource);
      final matches = regex.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}

class ValidatorInputFormatter implements TextInputFormatter {
  ValidatorInputFormatter({this.editingValidator});
  final StringValidator editingValidator;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueValid = editingValidator.isValid(oldValue.text);
    final newValueValid = editingValidator.isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }
}

class EmailEditingRegexValidator extends RegexValidator {
  EmailEditingRegexValidator()
      : super(
            regexSource:
                "^[a-zA-Z0-9_.+-]*(@([a-zA-Z0-9-]*(\\.[a-zA-Z0-9-]*)?)?)?\$");
}

class EmailSubmitRegexValidator extends RegexValidator {
  EmailSubmitRegexValidator()
      : super(
            regexSource: "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\$)");
}

class PhoneNumberRegexValidator extends RegexValidator {
  PhoneNumberRegexValidator()
      : super(
            regexSource:
                "^[\\+]?[(]?[0-9]{3}[)]?[-\\s\\.]?[0-9]{3}[-\\s\\.]?[0-9]{4,6}\$");
}

String nameValidityErrorText(String name) {
  if (name.isEmpty)
    return 'Name can\'t be empty!';
  else
    return null;
}

String passwordValidityErrorText(String name) {
  if (name.isEmpty)
    return 'Password can\'t be empty!';
  else
    return null;
}

String emailValidityErrorText(String email) {
  if (email.isEmpty)
    return 'Email can\'t be empty!';
  else if (!EmailSubmitRegexValidator().isValid(email)) {
    return 'Invalid Email Format! Correct format: email@example.com';
  } else
    return null;
}

String phoneValidityErrorText(String phone) {
  if (!PhoneNumberRegexValidator().isValid(phone)) {
    return 'Invalid Phone Format! Correct format: an optional \'+\' sign with a 10-12 number & no characters';
  } else
    return null;
}
