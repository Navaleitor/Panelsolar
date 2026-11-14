import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

/// ID de cliente OAuth **web** de Google Cloud (lo exige el inicio de
/// sesión en Android). No es secreto. Pasos para obtenerlo:
/// `docs/guias/respaldo-google.md`. Se puede poner aquí (`defaultValue`)
/// o compilar con `--dart-define=GOOGLE_SERVER_CLIENT_ID=...`.
const String googleServerClientId = String.fromEnvironment(
  'GOOGLE_SERVER_CLIENT_ID',
);

/// Inicio de sesión con Google para el respaldo en Drive.
abstract interface class DriveAuth {
  /// `false` si falta configurar el ID de cliente (ver guía).
  bool get isConfigured;

  /// Inicia sesión (con pantalla de Google). Devuelve el correo.
  Future<String> signIn();

  /// Cliente HTTP autorizado sin mostrar nada (segundo plano), o `null`
  /// si hace falta volver a iniciar sesión.
  Future<http.Client?> silentClient();

  /// Cliente HTTP autorizado; si hace falta, muestra la pantalla de Google.
  Future<http.Client> interactiveClient();

  /// Cierra la sesión y revoca el permiso.
  Future<void> signOut();
}

/// [DriveAuth] con `google_sign_in` 7 y solo el scope `drive.appdata`
/// (no restringido: no requiere auditoría de seguridad de Google).
class GoogleDriveAuth implements DriveAuth {
  new({this.serverClientId = googleServerClientId});

  final String serverClientId;
  static const List<String> _scopes = [drive.DriveApi.driveAppdataScope];
  bool _initialized = false;

  @override
  bool get isConfigured => serverClientId.isNotEmpty;

  Future<GoogleSignIn> _instance() async {
    final signIn = GoogleSignIn.instance;
    if (!_initialized) {
      await signIn.initialize(serverClientId: serverClientId);
      _initialized = true;
    }
    return signIn;
  }

  @override
  Future<String> signIn() async {
    final signIn = await _instance();
    final account = await signIn.authenticate(scopeHint: _scopes);
    await account.authorizationClient.authorizeScopes(_scopes);
    return account.email;
  }

  @override
  Future<http.Client?> silentClient() async {
    if (!isConfigured) return null;
    final signIn = await _instance();
    final account = await signIn.attemptLightweightAuthentication();
    if (account == null) return null;
    final authz = await account.authorizationClient.authorizationForScopes(
      _scopes,
    );
    return authz?.authClient(scopes: _scopes);
  }

  @override
  Future<http.Client> interactiveClient() async {
    final silent = await silentClient();
    if (silent != null) return silent;
    final signIn = await _instance();
    final account = await signIn.authenticate(scopeHint: _scopes);
    final authz = await account.authorizationClient.authorizeScopes(_scopes);
    return authz.authClient(scopes: _scopes);
  }

  @override
  Future<void> signOut() async {
    final signIn = await _instance();
    await signIn.disconnect();
  }
}
