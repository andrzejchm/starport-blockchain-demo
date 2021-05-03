import 'package:dartz/dartz.dart';

import 'model/failures/biometric_authentication_failure.dart';

abstract class BiometricAuthenticator {
  Future<Either<BiometricAuthenticationFailure, Unit>> authenticate();
}
