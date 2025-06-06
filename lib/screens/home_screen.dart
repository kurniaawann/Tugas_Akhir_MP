import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir/providers/quiz_provider.dart';
import 'package:tugas_akhir/screens/quiz_screen.dart';
import 'package:tugas_akhir/utils/enum_home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false).getDataQuizSubject();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context);

    final subjects = provider.getAllSubjects;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Pilih Kuis Yang Kamu Sukai'),
        backgroundColor: Colors.blue[50],
        // foregroundColor: Colors.blue[800],
        surfaceTintColor: Colors.blue[50],
      ),
      body:
          provider.isLoadingQuizSubject
              ? Center(
                child: CircularProgressIndicator(color: Colors.blue[800]),
              )
              : subjects.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sentiment_dissatisfied,
                      size: 60,
                      color: Colors.blue[800],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Tidak ada pelajaran tersedia',
                      style: TextStyle(fontSize: 18, color: Colors.blue[800]),
                    ),
                  ],
                ),
              )
              : Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    final imageAsset = getImageAsset(subject.name);
                    final cardColor = getCardColor(subject.name);

                    return Card(
                      color: cardColor,
                      // borderRadius: BorderRadius.circular(20),
                      elevation: 5,
                      shadowColor: Colors.black.withOpacity(0.2),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () async {
                          final questions = await provider
                              .getQuestionsForSubject(subject.id);
                          if (!context.mounted) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => QuizScreen(
                                    subjectName: subject.name,
                                    questions: questions,
                                  ),
                            ),
                          );
                        },
                        onHighlightChanged: (value) {
                          setState(() {});
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(imageAsset.path),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                subject.name.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue[900],
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                      color: Colors.white,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Mulai Kuis',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }

  HomeImageAsset getImageAsset(String subjectName) {
    switch (subjectName.toLowerCase()) {
      case 'bahasa indonesia':
        return HomeImageAsset.bahasaIndonesia;
      case 'matematika':
        return HomeImageAsset.matematika;
      case 'ipa':
        return HomeImageAsset.ipa;
      case 'ppkn':
        return HomeImageAsset.ppkn;
      case 'seni budaya':
        return HomeImageAsset.seniBudaya;
      case 'pjok':
        return HomeImageAsset.pjok;
      case 'bahasa inggris':
        return HomeImageAsset.bahasaInggris;
      default:
        return HomeImageAsset.bahasaIndonesia;
    }
  }

  Color getCardColor(String subjectName) {
    switch (subjectName.toLowerCase()) {
      case 'bahasa indonesia':
        return Colors.green[100]!;
      case 'matematika':
        return Colors.purple[100]!;
      case 'ipa':
        return Colors.blue[100]!;
      case 'ppkn':
        return Colors.orange[100]!;
      case 'seni budaya':
        return Colors.pink[100]!;
      case 'pjok':
        return Colors.teal[100]!;
      case 'bahasa inggris':
        return Colors.red[100]!;
      default:
        return Colors.yellow[100]!;
    }
  }
}
