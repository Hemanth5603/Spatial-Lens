bool validatePhoneNumber(String phoneNumber) {
  if (phoneNumber.length != 10) {
    return false;
  }
  for (int i = 3; i < phoneNumber.length; i++) {
    if (!phoneNumber[i].contains(RegExp(r'[0-9]'))) {
      return false;
    }
  }
  return true;
}
