class Validators {
  static String _maxStatement(val) {
    return 'Maximum characters allowed - $val';
  }

  static String _minStatement(val) {
    return 'Minimum characters required - $val';
  }

  static String _nullStatement() {
    return 'This field should not be null';
  }

  static String _validStatement(val) {
    return 'Please provide a valid $val';
  }

  //string validator: takes min, max, isRequired, whitespace as additional arguments
  static String? string(
    String? value, {
    int? max,
    int? min,
    bool isRequired = false,
    bool whitespace = true,
  }) {
    final int length = value!.length;

    //check for empty field only when isRequired is true
    if (isRequired == true) {
      if (value.isEmpty) {
        return _nullStatement();
      }
    }

    if (value.isNotEmpty) {
      if (min != null) {
        if (length < min) {
          return _minStatement(min);
        }
      }
      if (max != null) {
        if (length > max) {
          return _maxStatement(max);
        }
      }
    }
    return null;
  }

  //email validator : takes isRequired as additonal argument

  //regular expression for valid email address #official_referenced
  static RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  static String? email(String? value, {bool isRequired = false}) {
    if (isRequired == true) {
      if (value!.isEmpty) {
        return _nullStatement();
      }
    }

    if (value!.isNotEmpty) {
      if (!emailReg.hasMatch(value)) {
        return _validStatement('email');
      }
    }
  }

  //intNum validator

  static String? intNum(
    String? value, {
    int? max,
    int? min,
    bool isRequired = false,
  }) {
    if (isRequired == true) {
      if (value!.isEmpty) {
        return _nullStatement();
      }
    }

    if (value!.isNotEmpty) {
      int? intValue = int.tryParse(value);
      if (intValue != null) {
        int length = intValue.toString().length;
        if (max != null) {
          if (length > max) {
            return _maxStatement(max);
          }
        }
        if (min != null) {
          if (length < min) {
            return _minStatement(min);
          }
        }
        return null;
      } else {
        return _validStatement('number');
      }
    }
    return null;
  }

  //doubleNum validator
  static String? doubleNum(
    String? value, {
    int? max,
    int? min,
    bool isRequired = false,
  }) {
    double? intValue = double.tryParse(value!);
    if (intValue != null) {
      return null;
    } else {
      return _validStatement('number');
    }
  }
}
