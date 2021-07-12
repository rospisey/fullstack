part of pisey_services;

TextInputType toTextInputType(String action) {
  switch (action) {
    case 'TextInputType.text':
      return TextInputType.text;
    case 'TextInputType.multiline':
      //must use with TextInputAction.newline
      return TextInputType.multiline;
    case 'TextInputType.number':
      return TextInputType.number;
    case 'TextInputType.phone':
      return TextInputType.phone;
    case 'TextInputType.datetime':
      return TextInputType.datetime;
    case 'TextInputType.emailAddress':
      return TextInputType.emailAddress;
    case 'TextInputType.url':
      return TextInputType.url;
    case 'TextInputType.visiblePassword':
      return TextInputType.visiblePassword;
    case 'TextInputType.name':
      return TextInputType.name;
    case 'TextInputType.streetAddress':
      return TextInputType.streetAddress;
  }
  throw FlutterError.fromParts(
      <DiagnosticsNode>[ErrorSummary('Unknown text input action: $action')]);
}

TextInputAction toTextInputAction(String action) {
  switch (action) {
    case 'TextInputAction.none':
      return TextInputAction.none;

    case 'TextInputAction.unspecified':
      return TextInputAction.unspecified;
    case 'TextInputAction.go':
      return TextInputAction.go;
    case 'TextInputAction.search':
      return TextInputAction.search;
    case 'TextInputAction.send':
      return TextInputAction.send;
    case 'TextInputAction.next':
      return TextInputAction.next;
    case 'TextInputAction.previous':
      return TextInputAction.previous;
    case 'TextInputAction.continueAction':
      //for ios
      return TextInputAction.continueAction;
    case 'TextInputAction.join':
      //android not support
      return TextInputAction.join;
    case 'TextInputAction.route':
      //android not support
      return TextInputAction.route;
    case 'TextInputAction.emergencyCall':
      //android not support
      return TextInputAction.emergencyCall;
    case 'TextInputAction.done':
      return TextInputAction.done;
    case 'TextInputAction.newline':
      //must use with TextInputType.multiline
      return TextInputAction.newline;
  }
  throw FlutterError.fromParts(
      <DiagnosticsNode>[ErrorSummary('Unknown text input action: $action')]);
}
