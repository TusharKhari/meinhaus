class Validator {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return !regex.hasMatch(value) ? 'Enter a valid email address' : null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 4) {
      return "Password must be at least 8 characters long";
    }
    return null;
  }

  String? validateConfirmPassword({
    required String? value,
    required String valController,
  }) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != valController) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? nullValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }
}
