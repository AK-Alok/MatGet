import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class AuthController {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  Future<bool> signUpWithEmail(
      String name, String email, String password) async {
    final user =
        await _authService.signUpWithEmail(email, password);

    if (user == null) return false;

    await _userService.saveUser(
      UserModel(
        uid: user.uid,
        name: name,
        email: email,
      ),
    );

    return true;
  }

  Future<bool> loginWithEmail(
      String email, String password) async {
    final user =
        await _authService.loginWithEmail(email, password);

    return user != null;
  }
}