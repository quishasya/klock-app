import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // untuk memastikan semua widget ke render
  await initializeDateFormatting('id');
  Object? startupError; // variabel error yg bertipe object
  try {
    // TODO-F01: Tambahkan import firebase_core dan inisialisasi Firebase.
    await Firebase.initializeApp(); 
  } catch (error) {
    startupError = error;
  }
  runApp(ProviderScope(child: KlockApp(startupError: startupError)));
}
