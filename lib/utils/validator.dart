class FormValidator {
  static final RegExp _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Provide an email";
    } else if (!_emailRegex.hasMatch(email)) {
      return "Enter valid email";
    } else {
      return null;
    }
  }

  static String? validatePassword(String? pass) {
    if (pass == null || pass.isEmpty) {
      return "Password can't be empty";
    } else if (pass.length < 8) {
      return "Password must be of 8 characters";
    } else {
      return null;
    }
  }
}
