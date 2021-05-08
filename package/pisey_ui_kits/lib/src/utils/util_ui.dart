part of pisey_ui_kits;

EdgeInsets myMargin({
  double? left,
  double? right,
  double? bottom,
  double? top,
}) {
  return EdgeInsets.only(
      top: top ?? 5, bottom: bottom ?? 5, left: left ?? 15, right: right ?? 15);
}

DecorationImage myDecorationImage(
    {@required String? url, @required String? assetImage}) {
  if (url == null) {
    return DecorationImage(
        image: AssetImage(assetImage ?? ''), fit: BoxFit.cover);
  } else {
    return DecorationImage(image: NetworkImage(url), fit: BoxFit.cover);
  }
}

BoxDecoration myBoxDecorationShadow(
    {Color? color,
    double? borderRadius,
    Color? borderColor,
    List<BoxShadow>? boxShadow}) {
  return BoxDecoration(
    color: color ?? Colors.white,
    borderRadius: BorderRadius.circular(borderRadius ?? 12),
    border: Border.all(color: borderColor ?? Colors.transparent),
    boxShadow: boxShadow ??
        <BoxShadow>[
          BoxShadow(
              color: Colors.grey[300]!, blurRadius: 10, offset: Offset(3, 3))
        ],
  );
}

BoxDecoration myBoxDecorationOutline(
    {Color? color,
    double? borderRadius,
    Color? borderColor,
    List<BoxShadow>? boxShadow}) {
  return BoxDecoration(
    color: color ?? Colors.white,
    borderRadius: BorderRadius.circular(borderRadius ?? 10),
    border: Border.all(color: borderColor ?? Colors.grey[200]!),
    boxShadow: boxShadow ??
        <BoxShadow>[
          BoxShadow(
              color: Colors.transparent, blurRadius: 0, offset: Offset(0, 0))
        ],
  );
}
