abstract class Validator {
  static String? emailValidator(String? value) {
    if (value == null) return "*required";
    if (value.isEmpty) return "*required";
    RegExp regex = RegExp(
        r"^(.+)@(.+)$");
    if (!regex.hasMatch(value)) return "invalid";
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null) return "*required";
    if (value.isEmpty) return "*required";
    if (value.length < 8) return "Must be minimum 8 characters";
    return null;
  }

  static String? textValidator(String? value) {
    if (value == null || value.isEmpty) return "*required";
    return null;
  }
}
