import 'package:tugas_akhir/models/question.dart';

List<Question> sampelQuizMatematika() {
  const subjectId = 1; // Assuming subjectId for Matematika is 1
  return [
    Question(
      subjectId: subjectId,
      questionText: 'Hasil dari 2 + 2 = ?',
      options: ['3', '4', '5', '6'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Hasil dari 5 × 3 = ?',
      options: ['8', '15', '10', '20'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Hasil dari 12 : 4 =?',
      options: ['2', '3', '4', '5'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Hasil dari 10 × 5 = ?',
      options: ['6', '7', '30', '50'],
      correctAnswerIndex: 3,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Hasil dari 10 - 6  = ?',
      options: ['2', '3', '4', '5'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Hasil dari 7 + 8 = ?',
      options: ['14', '15', '16', '13'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Hasil dari 9 × 1 = ?',
      options: ['7', '8', '9', '10'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Hasil dari 6 + 2 = ?',
      options: ['6', '8', '7', '9'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Hasil dari 5 × 5 = ?',
      options: ['10', '15', '25', '20'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Hasil dari 100 - 25 = ?',
      options: ['75', '65', '85', '90'],
      correctAnswerIndex: 0,
    ),
  ];
}

List<Question> sampleQuizBahasaIndonesia() {
  const int subjectId = 2; // Assuming subjectId for Bahasa Indonesia is 2
  return [
    Question(
      subjectId: subjectId,
      questionText: 'Antonim dari kata “besar” adalah?',
      options: ['Kecil', 'Panjang', 'Lebar', 'Tinggi'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Kata “bermain” termasuk jenis kata?',
      options: ['Kata benda', 'Kata sifat', 'Kata kerja', 'Kata depan'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Sinonim dari kata “indah” adalah?',
      options: ['Kotor', 'Buruk', 'Cantik', 'Tinggi'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Kalimat yang digunakan untuk menanyakan sesuatu disebut?',
      options: [
        'Kalimat tanya',
        'Kalimat perintah',
        'Kalimat ajakan',
        'Kalimat berita',
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Cerita khayalan yang mengandung pesan moral disebut?',
      options: ['Cerpen', 'Dongeng', 'Berita', 'Puisi'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Kalimat yang mengandung perintah disebut?',
      options: [
        'Kalimat tanya',
        'Kalimat ajakan',
        'Kalimat perintah',
        'Kalimat berita',
      ],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Kata "pelajar" berasal dari kata dasar?',
      options: ['Belajar', 'Ajar', 'Pelajaran', 'Mengajar'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Contoh kata benda adalah?',
      options: ['Meja', 'Berjalan', 'Cepat', 'Cantik'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Kalimat “Sinta pergi ke sekolah” adalah contoh kalimat?',
      options: ['Tanya', 'Berita', 'Perintah', 'Ajakan'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Kata "rajin" termasuk jenis kata?',
      options: ['Kata benda', 'Kata kerja', 'Kata sifat', 'Kata tanya'],
      correctAnswerIndex: 2,
    ),
  ];
}

List<Question> sampleQuizIPA() {
  const int subjectId = 3; // Assuming subjectId for IPA is 2
  return [
    Question(
      subjectId: subjectId,
      questionText: 'Bagian tumbuhan yang berfungsi menyerap air adalah?',
      options: ['Batang', 'Daun', 'Akar', 'Bunga'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Hewan yang berkembang biak dengan cara bertelur disebut?',
      options: ['Vivipar', 'Ovipar', 'Ovovivipar', 'Mamalia'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Alat pernapasan pada ikan adalah?',
      options: ['Paru-paru', 'Insang', 'Kulit', 'Trakea'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Contoh benda yang termasuk konduktor panas adalah?',
      options: ['Kayu', 'Kertas', 'Besi', 'Plastik'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Benda langit yang memancarkan cahaya sendiri adalah?',
      options: ['Bulan', 'Bumi', 'Matahari', 'Planet'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Air yang dipanaskan akan berubah menjadi?',
      options: ['Es', 'Awan', 'Uap', 'Minyak'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Fungsi daun pada tumbuhan adalah untuk?',
      options: ['Bernapas', 'Berjalan', 'Menyerap air', 'Fotosintesis'],
      correctAnswerIndex: 3,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Alat yang digunakan untuk mengukur suhu adalah?',
      options: ['Penggaris', 'Termometer', 'Timbangan', 'Stopwatch'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Planet tempat manusia tinggal adalah?',
      options: ['Mars', 'Venus', 'Bumi', 'Yupiter'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Organ pernapasan manusia adalah?',
      options: ['Hidung', 'Lidah', 'Paru-paru', 'Telinga'],
      correctAnswerIndex: 2,
    ),
  ];
}

List<Question> sampleQuizPPKN() {
  const subjectId = 4;
  return [
    Question(
      subjectId: subjectId,
      questionText: 'Apa lambang negara Indonesia?',
      options: [
        'Garuda Pancasila',
        'Bendera Merah Putih',
        'Burung Elang',
        'Harimau',
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Sila pertama Pancasila adalah?',
      options: ['Kemanusiaan', 'Ketuhanan', 'Keadilan', 'Persatuan'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Contoh sikap gotong royong adalah?',
      options: [
        'Bekerja sendiri',
        'Menyontek',
        'Membersihkan kelas bersama',
        'Berbohong',
      ],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Warna bendera Indonesia adalah?',
      options: ['Merah-Putih', 'Putih-Biru', 'Merah-Kuning', 'Hijau-Merah'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Hari kemerdekaan Indonesia diperingati setiap?',
      options: ['10 November', '17 Agustus', '1 Juni', '20 Mei'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Presiden pertama Indonesia adalah?',
      options: ['Jokowi', 'Soekarno', 'Soeharto', 'BJ Habibie'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Sikap menghargai pendapat orang lain disebut?',
      options: ['Egois', 'Toleransi', 'Marah', 'Iri'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Tempat membuat undang-undang di Indonesia adalah?',
      options: ['Polisi', 'Presiden', 'DPR', 'RT'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Apa bunyi sila ke-2 Pancasila?',
      options: [
        'Persatuan Indonesia',
        'Kemanusiaan yang adil dan beradab',
        'Ketuhanan',
        'Keadilan sosial',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Apa arti demokrasi?',
      options: [
        'Kekuasaan di tangan rakyat',
        'Kekuasaan raja',
        'Kekuasaan tentara',
        'Kekuasaan presiden',
      ],
      correctAnswerIndex: 0,
    ),
  ];
}

List<Question> sampleQuizSeniBudaya() {
  const subjectId = 6;
  return [
    Question(
      subjectId: subjectId,
      questionText: 'Apa alat musik tradisional dari Jawa Barat?',
      options: ['Angklung', 'Gamelan', 'Sasando', 'Kolintang'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Tari Piring berasal dari?',
      options: ['Jawa', 'Bali', 'Sumatera Barat', 'Sulawesi'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Seni melukis termasuk dalam seni?',
      options: ['Tari', 'Musik', 'Rupa', 'Drama'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Wayang adalah seni tradisional dari?',
      options: ['Kalimantan', 'Jawa', 'Sulawesi', 'Papua'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Sasando adalah alat musik dari?',
      options: ['Jawa Timur', 'NTT', 'Bali', 'Aceh'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Alat musik yang dimainkan dengan cara dipetik adalah?',
      options: ['Gitar', 'Piano', 'Drum', 'Suling'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Apa warna primer?',
      options: [
        'Merah, Kuning, Biru',
        'Hijau, Putih, Hitam',
        'Biru, Ungu, Coklat',
        'Merah, Hitam, Abu',
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Tari Saman berasal dari?',
      options: ['Aceh', 'Bali', 'Papua', 'Jawa'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Seni yang dapat dilihat dan diraba adalah?',
      options: ['Musik', 'Tari', 'Rupa', 'Drama'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Gambar yang menceritakan sebuah cerita disebut?',
      options: ['Lukisan', 'Komik', 'Poster', 'Iklan'],
      correctAnswerIndex: 1,
    ),
  ];
}

List<Question> sampleQuizPJOK() {
  const subjectId = 7;
  return [
    Question(
      subjectId: subjectId,
      questionText: 'Senam lantai dilakukan di atas?',
      options: ['Tanah', 'Rumput', 'Matras', 'Kursi'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Contoh olahraga air adalah?',
      options: ['Renang', 'Lari', 'Basket', 'Sepak bola'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Berapa jumlah pemain sepak bola dalam satu tim?',
      options: ['11', '10', '12', '9'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Pemain basket memasukkan bola ke?',
      options: ['Net', 'Gawang', 'Ring', 'Keranjang'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Olahraga yang dilakukan dengan raket adalah?',
      options: ['Renang', 'Bulu tangkis', 'Sepak bola', 'Gulat'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Pemanasan sebelum olahraga bertujuan untuk?',
      options: [
        'Meningkatkan rasa lapar',
        'Menghindari cedera',
        'Biar cepat capek',
        'Memulai pelajaran',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Gerakan lompat jauh dilakukan dengan?',
      options: ['Melompat', 'Berlari', 'Melempar', 'Menendang'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Permainan tradisional yang menggunakan bola kecil adalah?',
      options: ['Kasti', 'Sepak bola', 'Basket', 'Catur'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Apa manfaat olahraga bagi tubuh?',
      options: [
        'Membuat lelah',
        'Menjaga kesehatan',
        'Membuat ngantuk',
        'Mengurangi makan',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Lari cepat disebut juga?',
      options: [
        'Lari jarak jauh',
        'Lari estafet',
        'Lari maraton',
        'Lari sprint',
      ],
      correctAnswerIndex: 3,
    ),
  ];
}

List<Question> sampleQuizBahasaInggris() {
  const subjectId = 8;
  return [
    Question(
      subjectId: subjectId,
      questionText: 'What is the English word for "merah"?',
      options: ['Green', 'Blue', 'Red', 'Yellow'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'How do you say "Saya makan nasi" in English?',
      options: ['I eat rice', 'You eat rice', 'We eat rice', 'He eat rice'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'What is the opposite of "hot"?',
      options: ['Cold', 'Warm', 'Cool', 'Heat'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Number after five is?',
      options: ['Six', 'Four', 'Seven', 'Ten'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'What is "kucing" in English?',
      options: ['Dog', 'Cat', 'Bird', 'Fish'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'How do you say "Selamat pagi"?',
      options: ['Good night', 'Good afternoon', 'Good morning', 'Goodbye'],
      correctAnswerIndex: 2,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'Color of the sky is?',
      options: ['Blue', 'Black', 'Red', 'Yellow'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'What is "book" in Bahasa Indonesia?',
      options: ['Buku', 'Pensil', 'Kertas', 'Meja'],
      correctAnswerIndex: 0,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'What is "Happy" in Bahasa Indonesia?',
      options: ['Sedih', 'Senang', 'Lapar', 'Kenyang'],
      correctAnswerIndex: 1,
    ),
    Question(
      subjectId: subjectId,
      questionText: 'What is the plural of "child"?',
      options: ['Childs', 'Childes', 'Children', 'Childrens'],
      correctAnswerIndex: 2,
    ),
  ];
}
