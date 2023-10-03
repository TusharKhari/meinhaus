class Validator {

  // VALIDATE EMAIL
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return !regex.hasMatch(value) ? 'Enter a valid email address' : null;
  }

  // VALIDATE PASSWORD
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    return null;
  }
  
  // VALIDATE CONTACT NUMBER
  String? validateContactNo(String? value) {
    if (value!.isEmpty || value.length < 10 || value.length > 20) {
      return "Please enter valid contact no";
    }
    return null;
  }

  // VALIDATE CONFIRM PASSWORD
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

  // VALIDATE NULL VALUE
  String? nullValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }
}
