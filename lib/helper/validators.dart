class Validators {
  ///which uses regular expressions to validate the email and password

  //<editor-fold desc="Regular expression for validating Email.">

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  // </editor-fold>

  //<editor-fold desc="Regular expression for validating Password.">

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  //</editor-fold>

  //<editor-fold desc="Method :- isValidEmail">

  ///Checking email either valid or not
  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  //</editor-fold>

  // <editor-fold desc="Method :- isValidPassword">
  ///Checking password either valid or not
  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  //</editor-fold>
}
