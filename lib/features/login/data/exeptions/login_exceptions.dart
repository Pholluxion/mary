/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message =
        '''Lo sentimos, ha ocurrido una excepción desconocida. Por favor, inténtelo de nuevo más tarde o póngase en contacto con el equipo de soporte si el problema persiste.''',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          '''La dirección de correo electrónico proporcionada no es válida. Por favor, asegúrese de ingresar una dirección de correo electrónico correcta y vuelva a intentarlo.''',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          '''Lo sentimos, su cuenta de usuario está deshabilitada actualmente. Por favor, póngase en contacto con el equipo de soporte para obtener más información sobre cómo solucionar este problema.''',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          '''No se ha encontrado ningún usuario con la información proporcionada. Por favor, asegúrese de que la información sea correcta e inténtelo de nuevo.''',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          '''La contraseña ingresada es incorrecta. Por favor, asegúrese de que la contraseña sea la correcta e inténtelo de nuevo o solicite un restablecimiento de contraseña.''',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
class LogInWithGoogleFailure implements Exception {
  const LogInWithGoogleFailure([
    this.message =
        '''Lo sentimos, ha ocurrido una excepción desconocida. Por favor, inténtelo de nuevo más tarde o póngase en contacto con el equipo de soporte si el problema persiste.''',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          '''Ya existe una cuenta asociada con las credenciales proporcionadas. Por favor, intente iniciar sesión con las credenciales correctas o restablezca su contraseña si es necesario.''',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          '''Las credenciales proporcionadas no son válidas. Por favor, asegúrese de que las credenciales sean correctas e inténtelo de nuevo o solicite un restablecimiento de contraseña.''',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          '''Lo sentimos, esta operación no está permitida. Por favor, póngase en contacto con el equipo de soporte para obtener más información o ayuda adicional.''',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          '''Lo sentimos, su cuenta de usuario está deshabilitada actualmente. Por favor, póngase en contacto con el equipo de soporte para obtener más información sobre cómo solucionar este problema.''',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          '''No se ha encontrado ningún usuario con la información proporcionada. Por favor, asegúrese de que la información sea correcta e inténtelo de nuevo.''',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          '''La contraseña ingresada es incorrecta. Por favor, asegúrese de que la contraseña sea la correcta e inténtelo de nuevo o solicite un restablecimiento de contraseña.''',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          '''El código de verificación ingresado no es válido. Por favor, asegúrese de ingresar el código correcto y vuelva a intentarlo.''',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          '''El ID de verificación proporcionado no es válido. Por favor, asegúrese de que el ID de verificación sea correcto e inténtelo de nuevo.''',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
class SendPasswordResetEmailFailure implements Exception {
  const SendPasswordResetEmailFailure([
    this.message =
        '''Lo sentimos, ha ocurrido una excepción desconocida. Por favor, inténtelo de nuevo más tarde o póngase en contacto con el equipo de soporte si el problema persiste.''',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SendPasswordResetEmailFailure.fromCode(String code) {
    switch (code) {
      case 'expired-action-codel':
        return const SendPasswordResetEmailFailure('El codigo ha expirado');
      case 'user-disabled':
        return const SendPasswordResetEmailFailure(
          '''Lo sentimos, su cuenta de usuario está deshabilitada actualmente. Por favor, póngase en contacto con el equipo de soporte para obtener más información sobre cómo solucionar este problema.''',
        );
      case 'user-not-found':
        return const SendPasswordResetEmailFailure(
          '''No se ha encontrado ningún usuario con la información proporcionada. Por favor, asegúrese de que la información sea correcta e inténtelo de nuevo.''',
        );
      case 'invalid-action-code':
        return const SendPasswordResetEmailFailure('El codigo es invalido');
      default:
        return const SendPasswordResetEmailFailure();
    }
  }

  /// The associated error message.
  final String message;
}
