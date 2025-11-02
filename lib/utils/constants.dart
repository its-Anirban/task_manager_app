import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Constants {
  static String get baseUrl {
    // For Web (Flutter web or Chrome)
    if (kIsWeb) {
      return 'http://localhost:8080';
    }

    // For Android Emulator
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080';
    }

    // For iOS Simulator
    if (Platform.isIOS) {
      return 'http://localhost:8080';
    }

    // For Desktop (Windows, macOS, Linux)
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return 'http://localhost:8080';
    }

    // Default fallback (if some other platform)
    return 'http://localhost:8080';
  }

  static const String tokenKey = 'auth_token';
}
