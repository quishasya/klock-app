import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_providers.dart';

final profileRepositoryProvider = Provider.autoDispose<ProfileRepository>((
  ref,
) {
  ref.watch(sessionProvider);
  return ProfileRepository(
    FirebaseFirestore.instance,
    FirebaseAuth.instance.currentUser!.uid,
  );
});
final avatarProvider = StreamProvider.autoDispose<Uint8List?>(
  (ref) => ref.watch(profileRepositoryProvider).watch(),
);

class ProfileRepository {
  ProfileRepository(this.db, this.uid);
  final FirebaseFirestore db;
  final String uid;
  DocumentReference<Map<String, dynamic>> get document =>
      db.collection('students').doc(uid).collection('profile').doc('photo');
  Stream<Uint8List?> watch() {
    // TODO-F10: snapshots dokumen; null bila belum ada foto profil.
    return document.snapshots().map(
      (doc) => (doc.data()?['bytes'] as Blob)?.bytes,
    );
  }

  Future<void> save(Uint8List bytes) async {
    if (bytes.isEmpty || bytes.length > 102400)
      throw StateError('Foto maksimal 100 KB.');
    // TODO-F10: Simpan bytes sebagai Blob dan updatedAt sebagai serverTimestamp.
    await document.set({
      'bytes': Blob(bytes),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
