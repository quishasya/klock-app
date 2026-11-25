import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(FirebaseAuth.instance),
);

class AuthRepository {
  AuthRepository(this.auth);
  final FirebaseAuth auth;

  Future<void> signIn(String email, String password) async {
    // TODO-F03: Login Email/Password. Biarkan exception ditangani UI.
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Stream<User?> watchSession() {
    // TODO-F04: Dengarkan perubahan sesi; jangan simpan status login sendiri.
    return auth.authStateChanges();
  }

  String get studentName {
    // TODO-F04: Gunakan displayName, lalu email sebelum @, lalu "Siswi".
    final user = auth.currentUser;
    return user?.displayName ?? user?.email?.split('@').first ?? 'Siswi';
  }

  Future<void> signOut() async {
    // TODO-F05: Keluar dari Firebase Auth, bukan hanya pindah halaman.
    await auth.signOut();
  }
}
