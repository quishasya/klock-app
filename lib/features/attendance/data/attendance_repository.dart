import 'dart:typed_data';


import 'package:cloud_firestore/cloud_firestore.dart';


import '../domain/attendance.dart';


abstract class AttendanceRepository {
  Stream<List<Attendance>> watch();
  Future<void> submit(Uint8List photo);
  Future<Uint8List> photo(String id);
}


class FirestoreAttendanceRepository implements AttendanceRepository {
  FirestoreAttendanceRepository(this.db, this.uid);
  final FirebaseFirestore db;
  final String uid;
  CollectionReference<Map<String, dynamic>> get records =>
      db.collection('students').doc(uid).collection('attendance');
  @override


  // TODO-F07: Urutkan createdAt desc, limit 60, snapshots, lalu map model.
  Stream<List<Attendance>> watch() => records
    .orderBy('createdAt', descending: true)
    .limit(60)
    .snapshots()
    .map((snapshot) => snapshot.docs.map(Attendance.fromDoc).toList());
    
  @override
  Future<void> submit(Uint8List photo) async {
    if (photo.isEmpty || photo.length > 102400) {
      throw StateError('Foto harus berukuran maksimal 100 KB. Ambil ulang foto.');
    }
    // TODO-F08: Satu batch: metadata + evidence/photo + guards/daily.
    // Gunakan serverTimestamp dan Blob. Commit sekali, bukan tiga set terpisah.


    // Rules yang ada pada firestore akan memaksa satu laporan per kalender Jakarta akan membatasi satu request per hari
    final batch = db.batch();
    final record = records.doc();
    batch.set(record, {'createdAt' : FieldValue.serverTimestamp()});
    batch.set(record.collection('evidence').doc('photo'), {'bytes' : Blob(photo)});


    final guard = db.collection('students').doc(uid)
    .collection('guards').doc('daily');


    batch.set(guard, {'lastAt' : FieldValue.serverTimestamp(), 'recordId' : record.id});
    await batch.commit();


  }


  @override
  Future<Uint8List> photo(String id) async {
    // TODO-F09: Ambil evidence/photo hanya untuk record yang diketuk.
    final doc = await records.doc(id).collection('evidence').doc('photo').get();
    return (doc.data()!['bytes'] as Blob).bytes;
  }
}