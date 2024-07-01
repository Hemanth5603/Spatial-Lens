bool validateEmail(String email) {
  if (email.isEmpty) {
    return false;
  }

  List<String> parts = email.split("@");
  if (parts.length != 2) {
    return false;
  }

  String username = parts[0];
  String domain = parts[1];

  if (username.isEmpty || domain.isEmpty) {
    return false;
  }

  if (!domain.contains(".") || domain.indexOf(".") <= 0) {
    return false;
  }

  if (domain.contains("..")) {
    return false;
  }

  List<String> domainParts = domain.split(".");
  String tld = domainParts.last;
  if (tld.length < 2 || tld.length > 6) {
    return false;
  }

  RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9._-]+$');
  if (!usernameRegex.hasMatch(username)) {
    return false;
  }

  return true;
}
