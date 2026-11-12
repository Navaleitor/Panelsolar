import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Configuración regional para formatear números, fechas y dinero.
///
/// Los textos de la app solo existen en `es` y `en`, pero los formatos
/// deben respetar el país del teléfono (p. ej. `es-MX` escribe `3,600` y
/// `es-ES` escribe `3600`). Si el idioma del teléfono coincide con el de la
/// app, se usa la región del teléfono; si no, el idioma de la app.
String formatLocale(BuildContext context) {
  final app = Localizations.localeOf(context);
  final device = PlatformDispatcher.instance.locale;
  return device.languageCode == app.languageCode
      ? device.toLanguageTag()
      : app.toLanguageTag();
}
