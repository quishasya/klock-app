# Firebase TODO — Klock Starter

Kerjakan berurutan. UI/domain/kamera sudah siap. Baca docs/BRIEF-SISWA.pdf.
Tanda selesai hanya setelah checkpoint diuji; F02/F11/F12 adalah tugas Console/QA.

- [✅] **TODO-F01 — Hubungkan proyek dan inisialisasi Firebase**
  - Lokasi: lib/main.dart; android/app/google-services.json
  - Checkpoint: File konfigurasi dikenali dan pemberitahuan startup Firebase hilang. Pesan sesi belum tersedia masih wajar sampai F03-F04 selesai.
- [✅] **TODO-F02 — Aktifkan Email/Password dan siapkan dua akun**
  - Lokasi: Firebase Console > Authentication
  - Checkpoint: Dua akun muncul pada Users dengan UID berbeda. Credential belum diuji lewat UI sampai F03-F04 selesai.
- [✅] **TODO-F03 — Implementasikan login pada repository**
  - Lokasi: lib/features/auth/auth_repository.dart > signIn
  - Checkpoint: Setelah F04 selesai: login salah menampilkan error dan login benar membuka beranda. F03 belum dapat diuji melalui UI bila stream sesi masih placeholder.
- [✅] **TODO-F04 — Dengarkan sesi dan baca identitas pengguna**
  - Lokasi: lib/features/auth/auth_repository.dart > watchSession, studentName
  - Checkpoint: Login benar membuka beranda, nama sesuai akun, dan restart tidak memaksa login lagi selama sesi masih valid.
- [✅] **TODO-F05 — Tutup sesi saat logout dikonfirmasi**
  - Lokasi: lib/features/auth/auth_repository.dart > signOut
  - Checkpoint: Batal tidak mengubah sesi, konfirmasi keluar menutup sesi, dan data di Console tetap ada.
- [✅] **TODO-F06 — Tulis tiga helper security rules dan publikasikan**
  - Lokasi: firestore.rules > owner, fresh, linked; Firebase Console > Firestore > Rules
  - Checkpoint: Rules terpublikasi, pemilik dapat membaca path-nya, akun lain dan request tanpa login ditolak. Batch lengkap diuji setelah F08.
- [✅] **TODO-F07 — Baca metadata absensi secara realtime**
  - Lokasi: lib/features/attendance/data/attendance_repository.dart > watch
  - Checkpoint: Akun baru menampilkan riwayat kosong, bukan error. Setelah F08, catatan baru muncul otomatis dan urut terbaru dahulu.
- [✅] **TODO-F08 — Tulis absensi dengan satu atomic batch**
  - Lokasi: lib/features/attendance/data/attendance_repository.dart > submit
  - Checkpoint: Satu kiriman membuat tiga dokumen konsisten; timestamp berasal dari server; kiriman ulang tidak menambah record.
- [✅] **TODO-F09 — Unduh bukti foto saat diperlukan**
  - Lokasi: lib/features/attendance/data/attendance_repository.dart > photo
  - Checkpoint: Foto yang dibuka sesuai record. Riwayat tetap hanya membaca metadata.
- [✅] **TODO-F10 — Baca dan simpan foto profil**
  - Lokasi: lib/features/profile/profile_repository.dart > watch, save
  - Checkpoint: Akun tanpa foto tampil placeholder; foto tersimpan dan terganti; akun A/B tetap terpisah.
- [✅] **TODO-F11 — Atur pengecualian indeks untuk bytes foto**
  - Lokasi: firestore.indexes.json; Firebase Console > Firestore > Indexes
  - Checkpoint: Dua exemption bytes terlihat di Console, JSON lokal sesuai, riwayat tetap terurut dan foto tetap terbaca.
- [✅] **TODO-F12 — Buktikan integrasi, keamanan, dan hasil akhir**
  - Lokasi: Firebase Console; evidence/hasil-uji.md
  - Checkpoint: Semua kriteria terpenuhi, data terisolasi, tidak ada TODO implementasi tersisa, dan peserta bisa menjelaskan UID/batch/serverTimestamp.
