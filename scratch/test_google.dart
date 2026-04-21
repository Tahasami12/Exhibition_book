import 'package:google_sign_in/google_sign_in.dart';

void main() {
  try {
    final g = (GoogleSignIn as dynamic).instance;
    print("Instance exists: ${g != null}");
  } catch (e) {
    print(e);
  }
}
