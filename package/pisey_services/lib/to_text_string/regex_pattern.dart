part of pisey_services;

class RegexPattern {
  /// Username regex
  /// Requires minimum 3 character
  /// Allowing "_" and "." in middle of name
  static Pattern username = r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$';
  static String usernameError = '''Username regex
  Requires minimum 3 character
  Allowing "_" and "." in middle of name''';
  static PatternModel usernameModel = PatternModel(username, usernameError);

  /// Email regex
  static Pattern email =
      r'^[a-z0-9]+([-+._][a-z0-9]+){0,2}@.*?(\.(a(?:[cdefgilmnoqrstuwxz]|ero|(?:rp|si)a)|b(?:[abdefghijmnorstvwyz]iz)|c(?:[acdfghiklmnoruvxyz]|at|o(?:m|op))|d[ejkmoz]|e(?:[ceghrstu]|du)|f[ijkmor]|g(?:[abdefghilmnpqrstuwy]|ov)|h[kmnrtu]|i(?:[delmnoqrst]|n(?:fo|t))|j(?:[emop]|obs)|k[eghimnprwyz]|l[abcikrstuvy]|m(?:[acdeghklmnopqrstuvwxyz]|il|obi|useum)|n(?:[acefgilopruz]|ame|et)|o(?:m|rg)|p(?:[aefghklmnrstwy]|ro)|qa|r[eosuw]|s[abcdeghijklmnortuvyz]|t(?:[cdfghjklmnoprtvwz]|(?:rav)?el)|u[agkmsyz]|v[aceginu]|w[fs]|y[etu]|z[amw])\b){1,2}$';
  static String emailError = '''/// Email regex''';
  static PatternModel emailModel = PatternModel(email, emailError);

  /// URL regex
  /// Eg:
  /// - https://medium.com/@diegoveloper/flutter-widget-size-and-position-b0a9ffed9407
  /// - https://www.youtube.com/watch?v=COYFmbVEH0k
  /// - https://stackoverflow.com/questions/53913192/flutter-change-the-width-of-an-alertdialog/57688555
  static Pattern url =
      r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-@]+))*$";
  static String urlError = '''/// URL regex
  /// Eg:
  /// - https://medium.com/@diegoveloper/flutter-widget-size-and-position-b0a9ffed9407
  /// - https://www.youtube.com/watch?v=COYFmbVEH0k
  /// - https://stackoverflow.com/questions/53913192/flutter-change-the-width-of-an-alertdialog/57688555
''';
  static PatternModel urlModel = PatternModel(url, urlError);

  /// Phone Number regex
  /// Must started by either, "0", "+", "+XX <X between 2 to 4 digit>", "(+XX <X between 2 to 3 digit>)"
  /// Can add whitespace separating digit with "+" or "(+XX)"
  /// Example: 05555555555, +555 5555555555, (+123) 5555555555, (555) 5555555555, +5555 5555555555
  static Pattern phone =
      r'^(0|\+|(\+[0-9]{2,4}|\(\+?[0-9]{2,4}\)) ?)([0-9]*|\d{2,4}-\d{2,4}(-\d{2,4})?)$';
  static String phoneError = '''/// Phone Number regex
  /// Must started by either, "0", "+", "+XX <X between 2 to 4 digit>", "(+XX <X between 2 to 3 digit>)"
  /// Can add whitespace separating digit with "+" or "(+XX)"
  /// Example: 05555555555, +555 5555555555, (+123) 5555555555, (555) 5555555555, +5555 5555555555
''';
  static PatternModel phoneModel = PatternModel(phone, phoneError);

  /// Hexadecimal regex
  static Pattern hexadecimal = r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$';
  static String hexadecimalError = '''/// Hexadecimal regex''';
  static PatternModel hexadecimalModel =
      PatternModel(hexadecimal, hexadecimalError);

  /// Image vector regex
  static Pattern vector = r'.(svg)$';
  static String vectorError = '''/// Image vector regex: r'.(svg) ''';
  static PatternModel vectorModel = PatternModel(vector, vectorError);

  /// Image regex
  static Pattern image = r'.(jpeg|jpg|gif|png|bmp)$';
  static String imageError = '''/// Image regex : r'.(jpeg|jpg|gif|png|bmp)''';
  static PatternModel imageModel = PatternModel(image, imageError);

  /// Audio regex
  static Pattern audio = r'.(mp3|wav|wma|amr|ogg)$';
  static String audioError = '''///Audio regex .(mp3|wav|wma|amr|ogg)''';
  static PatternModel audioModel = PatternModel(audio, audioError);

  /// Video regex
  static Pattern video = r'.(mp4|avi|wmv|rmvb|mpg|mpeg|3gp)$';
  static String videoError =
      '''///Video regex.(mp4|avi|wmv|rmvb|mpg|mpeg|3gp)''';
  static PatternModel videoModel = PatternModel(audio, videoError);

  /// Txt regex
  static Pattern txt = r'.txt$';
  static String txtError = '''///Txt regex .txt''';
  static PatternModel txtModel = PatternModel(txt, txtError);

  /// Document regex
  static Pattern doc = r'.(doc|docx)$';
  static String docError = '''/// Document regex .(doc|docx)''';
  static PatternModel docModel = PatternModel(doc, docError);

  /// Excel regex
  static Pattern excel = r'.(xls|xlsx)$';
  static String excelError = '''///Excel regex .(xls|xlsx)''';
  static PatternModel excelModel = PatternModel(excel, excelError);

  /// PPT regex
  static Pattern ppt = r'.(ppt|pptx)$';
  static String pptError = '''///PPT regex .(ppt|pptx)''';
  static PatternModel pptModel = PatternModel(ppt, pptError);

  /// Apk regex
  static Pattern apk = r'.apk$';
  static String apkError = '''/// Error regex .apk''';
  static PatternModel apkModel = PatternModel(apk, apkError);

  /// Apk regex
  static Pattern json = r'.json$';
  static String jsonError = '''/// Error regex .json''';
  static PatternModel jsonModel = PatternModel(json, jsonError);

  /// PDF regex
  static Pattern pdf = r'.pdf$';
  static String pdfError = '''/// PDF regex .pdf''';
  static PatternModel pdfModel = PatternModel(pdf, pdfError);

  /// HTML regex
  static Pattern html = r'.html$';
  static String htmlError = '''/// HTML regex .html''';
  static PatternModel htmlModel = PatternModel(html, htmlError);

  /// DateTime regex (UTC)
  /// Unformatted date time (UTC and Iso8601)
  /// Example: 2020-04-27 08:14:39.977, 2020-04-27T08:14:39.977, 2020-04-27 01:14:39.977Z
  static Pattern basicDateTime =
      r'^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}:\d{2}.\d{3}Z?$';
  static String basicDateTimeError = '''/// DateTime regex (UTC)
  /// Unformatted date time (UTC and Iso8601)
  /// Example: 2020-04-27 08:14:39.977, 2020-04-27T08:14:39.977, 2020-04-27 01:14:39.977Z''';
  static PatternModel basicDateTimeModel =
      PatternModel(basicDateTime, basicDateTimeError);

  /// Binary regex
  /// Consist only 0 & 1
  static Pattern binary = r'^[0-1]*$';
  static String binaryError = '''/// Binary regex
  /// Consist only 0 & 1''';
  static PatternModel binaryModel = PatternModel(binary, binaryError);

  /// MD5 regex
  static Pattern md5 = r'^[a-f0-9]{32}$';
  static String md5Error = '''/// MD5 regex ^[a-f0-9]{32}''';
  static PatternModel md5Model = PatternModel(md5, md5Error);

  /// SHA1 regex
  static Pattern sha1 =
      r'(([A-Fa-f0-9]{2}\:){19}[A-Fa-f0-9]{2}|[A-Fa-f0-9]{40})';
  static String sha1Error = '''/// SHA1 regex''';
  static PatternModel sha1Model = PatternModel(sha1, sha1Error);

  /// SHA256 regex
  static Pattern sha256 =
      r'([A-Fa-f0-9]{2}\:){31}[A-Fa-f0-9]{2}|[A-Fa-f0-9]{64}';
  static String sha256Error = '''/// SHA256 regex''';
  static PatternModel sha256Model = PatternModel(sha256, sha256Error);

  /// SSN (Social Security Number) regex
  static Pattern ssn =
      r'^(?!0{3}|6{3}|9[0-9]{2})[0-9]{3}-?(?!0{2})[0-9]{2}-?(?!0{4})[0-9]{4}$';
  static String ssnError = '''/// SSN (Social Security Number) regex''';
  static PatternModel ssnModel = PatternModel(ssn, ssnError);

  /// IPv4 regex
  static Pattern ipv4 = r'^(?:(?:^|\.)(?:2(?:5[0-5]|[0-4]\d)|1?\d?\d)){4}$';
  static String ipv4Error = '''/// IPv4 regex''';
  static PatternModel ipv4Model = PatternModel(ipv4, ipv4Error);

  /// IPv6 regex
  static Pattern ipv6 =
      r'^((([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){5}:([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){4}:([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){3}:([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){2}:([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(([0-9A-Fa-f]{1,4}:){0,5}:((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(::([0-9A-Fa-f]{1,4}:){0,5}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|([0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})|(::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,7}:))$';
  static String ipv6Error = '''/// IPv6 regex''';
  static PatternModel ipv6Model = PatternModel(ipv6, ipv6Error);

  /// ISBN 10 & 13 regex
  static Pattern isbn =
      r'(ISBN(\-1[03])?[:]?[ ]?)?(([0-9Xx][- ]?){13}|([0-9Xx][- ]?){10})';
  static String isbnError = '''/// ISBN 10 & 13 regex''';
  static PatternModel isbnModel = PatternModel(isbn, isbnError);

  /// Github repository regex
  static Pattern github =
      r'((git|ssh|http(s)?)|(git@[\w\.]+))(:(\/\/)?)([\w\.@\:/\-~]+)(\.git)(\/)?';
  static String githubError = '''/// Github repository regex''';
  static PatternModel githubModel = PatternModel(github, githubError);

  /// Passport No. regex
  static Pattern passport = r'^(?!^0+$)[a-zA-Z0-9]{6,9}$';
  static String passportError = '''/// Passport No. regex''';
  static PatternModel passportModel = PatternModel(passport, passportError);

  /// Currency regex
  static Pattern currency =
      r'^(S?\$|\₩|Rp|\¥|\€|\₹|\₽|fr|R$|R)?[ ]?[-]?([0-9]{1,3}[,.]([0-9]{3}[,.])*[0-9]{3}|[0-9]+)([,.][0-9]{1,2})?( ?(USD?|AUD|NZD|CAD|CHF|GBP|CNY|EUR|JPY|IDR|MXN|NOK|KRW|TRY|INR|RUB|BRL|ZAR|SGD|MYR))?$';
  static String currencyError = '''/// Currency regex''';
  static PatternModel currencyModel = PatternModel(currency, currencyError);

  /// Numeric Only regex (No Whitespace & Symbols)
  static Pattern numericOnly = r'^\d+$';
  static String numericOnlyError =
      '''/// Numeric Only regex (No Whitespace & Symbols)''';
  static PatternModel numericOnlyModel =
      PatternModel(numericOnly, numericOnlyError);

  /// Alphabet Only regex (No Whitespace & Symbols)
  static Pattern alphabetOnly = r'^[a-zA-Z]+$';
  static String alphabetOnlyError =
      '''/// Alphabet Only regex (No Whitespace & Symbols)''';
  static PatternModel alphabetOnlyModel =
      PatternModel(alphabetOnly, alphabetOnlyError);

  /// Password (Easy) Regex
  /// Allowing all character except 'whitespace'
  /// Minimum character: 8
  static Pattern passwordEasy = r'^\S{8,}$';
  static String passwordEasyError = '''/// Password (Easy) Regex
  /// Allowing all character except 'whitespace'
  /// Minimum character: 8''';
  static PatternModel passwordEasyModel =
      PatternModel(passwordEasy, passwordEasyError);

  /// Password (Easy) Regex
  /// Allowing all character
  /// Minimum character: 8
  static Pattern passwordEasyAllowedWhitespace = r'^[\S ]{8,}$';
  static String passwordEasyAllowedWhitespaceError =
      '''  /// Password (Easy) Regex
  /// Allowing all character
  /// Minimum character: 8''';
  static PatternModel passwordEasyAllowedWhitespaceModel = PatternModel(
      passwordEasyAllowedWhitespace, passwordEasyAllowedWhitespaceError);

  /// Password (Normal) Regex
  /// Allowing all character except 'whitespace'
  /// Must contains at least: 1 letter & 1 number
  /// Minimum character: 8
  static Pattern passwordNormal1 = r'^(?=.*[A-Za-z])(?=.*\d)\S{8,}$';
  static String passwordNormal1Error = '''/// Password (Normal) Regex
  /// Allowing all character except 'whitespace'
  /// Must contains at least: 1 letter & 1 number
  /// Minimum character: 8''';
  static PatternModel passwordNormal1Model =
      PatternModel(passwordNormal1, passwordNormal1Error);

  /// Password (Normal) Regex
  /// Allowing all character
  /// Must contains at least: 1 letter & 1 number
  /// Minimum character: 8
  static Pattern passwordNormal1AllowedWhitespace =
      r'^(?=.*[A-Za-z])(?=.*\d)[\S ]{8,}$';
  static String passwordNormal1AllowedWhitespaceError =
      '''/// Password (Normal) Regex
  /// Allowing all character
  /// Must contains at least: 1 letter & 1 number
  /// Minimum character: 8''';
  static PatternModel passwordNormal1AllowedWhitespaceModel = PatternModel(
      passwordNormal1AllowedWhitespace, passwordNormal1AllowedWhitespaceError);

  /// Password (Normal) Regex
  /// Allowing LETTER and NUMBER only
  /// Must contains at least: 1 letter & 1 number
  /// Minimum character: 8
  static Pattern passwordNormal2 = r'^(?=.*[A-Za-z])(?=.*\d)[a-zA-Z0-9]{8,}$';
  static String passwordNormal2Error = '''  /// Password (Normal) Regex
  /// Allowing LETTER and NUMBER only
  /// Must contains at least: 1 letter & 1 number
  /// Minimum character: 8''';
  static PatternModel passwordNormal2Model =
      PatternModel(passwordNormal2, passwordNormal2Error);

  /// Password (Normal) Regex
  /// Allowing LETTER and NUMBER only
  /// Must contains: 1 letter & 1 number
  /// Minimum character: 8
  static Pattern passwordNormal2AllowedWhitespace =
      r'^(?=.*[A-Za-z])(?=.*\d)[a-zA-Z0-9 ]{8,}$';
  static String passwordNormal2AllowedWhitespaceError =
      '''/// Password (Normal) Regex
  /// Allowing LETTER and NUMBER only
  /// Must contains: 1 letter & 1 number
  /// Minimum character: 8''';
  static PatternModel passwordNormal2AllowedWhitespaceModel = PatternModel(
      passwordNormal2AllowedWhitespace, passwordNormal2AllowedWhitespaceError);

  /// Password (Normal) Regex
  /// Allowing all character except 'whitespace'
  /// Must contains at least: 1 uppercase letter, 1 lowecase letter & 1 number
  /// Minimum character: 8
  static Pattern passwordNormal3 = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)\S{8,}$';
  static String passwordNormal3Error = '''/// Password (Normal) Regex
  /// Allowing all character except 'whitespace'
  /// Must contains at least: 1 uppercase letter, 1 lowecase letter & 1 number
  /// Minimum character: 8''';
  static PatternModel passwordNormal3Model =
      PatternModel(passwordNormal3, passwordNormal3Error);

  /// Password (Normal) Regex
  /// Allowing all character
  /// Must contains at least: 1 uppercase letter, 1 lowecase letter & 1 number
  /// Minimum character: 8
  static Pattern passwordNormal3AllowedWhitespace =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[\S ]{8,}$';
  static String passwordNormal3AllowedWhitespaceError =
      '''/// Password (Normal) Regex
  /// Allowing all character
  /// Must contains at least: 1 uppercase letter, 1 lowecase letter & 1 number
  /// Minimum character: 8''';
  static PatternModel passwordNormal3AllowedWhitespaceModel = PatternModel(
      passwordNormal3AllowedWhitespace, passwordNormal3AllowedWhitespaceError);

  /// Password (Hard) Regex
  /// Allowing all character except 'whitespace'
  /// Must contains at least: 1 uppercase letter, 1 lowecase letter, 1 number, & 1 special character (symbol)
  /// Minimum character: 8
  static Pattern passwordHard =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])\S{8,}$';
  static String passwordHardError = '''/// Password (Hard) Regex
  /// Allowing all character except 'whitespace'
  /// Must contains at least: 1 uppercase letter, 1 lowecase letter, 1 number, & 1 special character (symbol)
  /// Minimum character: 8''';
  static PatternModel passwordHardModel =
      PatternModel(passwordHard, passwordHardError);

  /// Password (Hard) Regex
  /// Allowing all character
  /// Must contains at least: 1 uppercase letter, 1 lowecase letter, 1 number, & 1 special character (symbol)
  /// Minimum character: 8
  static Pattern passwordHardAllowedWhitespace =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[\S ]{8,}$';
  static String passwordHardAllowedWhitespaceError =
      '''/// Password (Hard) Regex
  /// Allowing all character
  /// Must contains at least: 1 uppercase letter, 1 lowecase letter, 1 number, & 1 special character (symbol)
  /// Minimum character: 8''';
  static PatternModel passwordHardAllowedWhitespaceModel = PatternModel(
      passwordHardAllowedWhitespace, passwordHardAllowedWhitespaceError);
}

class PatternModel {
  final Pattern? pattern;
  final String? errorText;

  PatternModel(this.pattern, this.errorText);
}

PatternModel toTextStringPatternModel(String action) {
  switch (action) {
    case 'RegexPattern.usernameModel':
      return RegexPattern.usernameModel;
    case 'RegexPattern.emailModel':
      return RegexPattern.emailModel;
    case 'RegexPattern.urlModel':
      return RegexPattern.urlModel;
    case 'RegexPattern.phoneModel':
      return RegexPattern.phoneModel;
    case 'RegexPattern.hexadecimalModel':
      return RegexPattern.hexadecimalModel;
    case 'RegexPattern.vectorModel':
      return RegexPattern.vectorModel;
    case 'RegexPattern.imageModel':
      return RegexPattern.imageModel;
    case 'RegexPattern.audioModel':
      return RegexPattern.audioModel;
    case 'RegexPattern.videoModel':
      return RegexPattern.videoModel;
    case 'RegexPattern.txtModel':
      return RegexPattern.txtModel;
    case 'RegexPattern.docModel':
      return RegexPattern.docModel;
    case 'RegexPattern.excelModel':
      return RegexPattern.excelModel;
    case 'RegexPattern.pptModel':
      return RegexPattern.pptModel;
    case 'RegexPattern.apkModel':
      return RegexPattern.apkModel;
    case 'RegexPattern.pdfModel':
      return RegexPattern.pdfModel;
    case 'RegexPattern.htmlModel':
      return RegexPattern.htmlModel;
    case 'RegexPattern.basicDateTimeModel':
      return RegexPattern.basicDateTimeModel;
    case 'RegexPattern.binaryModel':
      return RegexPattern.binaryModel;
    case 'RegexPattern.md5Model':
      return RegexPattern.md5Model;
    case 'RegexPattern.sha1Model':
      return RegexPattern.sha1Model;
    case 'RegexPattern.imageModel':
      return RegexPattern.imageModel;
    case 'RegexPattern.sha256Model':
      return RegexPattern.sha256Model;
    case 'RegexPattern.ssnModel':
      return RegexPattern.ssnModel;
    case 'RegexPattern.ipv4Model':
      return RegexPattern.ipv4Model;
    case 'RegexPattern.ipv6Model':
      return RegexPattern.ipv6Model;
    case 'RegexPattern.isbnModel':
      return RegexPattern.isbnModel;
    case 'RegexPattern.githubModel':
      return RegexPattern.githubModel;
    case 'RegexPattern.passportModel':
      return RegexPattern.passportModel;
    case 'RegexPattern.currencyModel':
      return RegexPattern.currencyModel;
    case 'RegexPattern.numericOnlyModel':
      return RegexPattern.numericOnlyModel;
    case 'RegexPattern.alphabetOnlyModel':
      return RegexPattern.alphabetOnlyModel;
    case 'RegexPattern.passwordEasyModel':
      return RegexPattern.passwordEasyModel;
    case 'RegexPattern.passwordNormal1Model':
      return RegexPattern.passwordNormal1Model;
    case 'RegexPattern.passwordNormal2Model':
      return RegexPattern.passwordNormal2Model;
    case 'RegexPattern.passwordNormal3Model':
      return RegexPattern.passwordNormal3Model;
    case 'RegexPattern.passwordHardModel':
      return RegexPattern.passwordHardModel;
    case 'RegexPattern.passwordEasyAllowedWhitespaceModel':
      return RegexPattern.passwordEasyAllowedWhitespaceModel;
    case 'RegexPattern.passwordNormal1AllowedWhitespaceModel':
      return RegexPattern.passwordNormal1AllowedWhitespaceModel;
    case 'RegexPattern.passwordNormal2AllowedWhitespaceModel':
      return RegexPattern.passwordNormal2AllowedWhitespaceModel;
    case 'RegexPattern.passwordNormal3AllowedWhitespaceModel':
      return RegexPattern.passwordNormal3AllowedWhitespaceModel;
    case 'RegexPattern.passwordHardAllowedWhitespaceModel':
      return RegexPattern.passwordHardAllowedWhitespaceModel;
  }
  throw FlutterError.fromParts(
      <DiagnosticsNode>[ErrorSummary('Unknown text input action: $action')]);
}
