String truncate(String source, int length, [bool trailingEllipses = true]) {
  if (source.length < length) {
    return source;
  }
  if (!trailingEllipses) {
    return source.substring(0, length);
  }
  return source.substring(0, length) + "...";
}
