class ValidatorHelper {
  static bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!_isEmailValid(email)) {
      return 'Email format is invalid';
    }
    return null;
  }

  static String? password(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be 6 characters';
    }
    return null;
  }

  static String? others(String? value) {
    if (value == null || value.isEmpty) {
      return 'This is required';
    }
    return null;
  }

  // add trip fields
  static String? trip(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // store validation
  static String? storeName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Store name is required';
    }
    return null;
  }

  static String? storeEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Store email is required';
    }
    return null;
  }

  static String? storePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Store phone is required';
    }
    return null;
  }

  static String? storeLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Store location is required';
    }
    return null;
  }
}
