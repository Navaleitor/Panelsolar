/// Nombre del .zip exportado: `panelsolar-respaldo-AAAA-MM-DD-HHMM.zip`
/// (hora local).
String backupFileName(DateTime now) {
  String two(int v) => v.toString().padLeft(2, '0');
  return 'panelsolar-respaldo-${now.year}-${two(now.month)}-${two(now.day)}-'
      '${two(now.hour)}${two(now.minute)}.zip';
}
