import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const InitApp());
}

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  Future<void> _initializeGemini() async {
    const apiKey = 'AIzaSyA1cC66MZ0njtiNrqNYwKFppl2XTTW6Ryk';
    await Gemini.init(apiKey: apiKey, enableDebugging: true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeGemini(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LabPendidikanPage(),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}

class LabPendidikanPage extends StatelessWidget {
  const LabPendidikanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back,
              color: CupertinoColors.activeBlue),
          onPressed: () {
            context.go("/home");
          },
        ),
        middle: const Text(
          'Lab Pendidikan',
          style: TextStyle(
            color: CupertinoColors.activeBlue,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: CupertinoColors.systemGrey5,
        border: const Border(
          bottom: BorderSide(color: CupertinoColors.systemGrey4),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              SizedBox(height: 20),
              Text(
                'Silakan konsultasikan rencana pembelajaran Anda kepada kami.',
                style: TextStyle(
                  color: CupertinoColors.activeBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ChatScreenDuplicate(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatScreenDuplicate extends StatefulWidget {
  const ChatScreenDuplicate({super.key});

  @override
  State<ChatScreenDuplicate> createState() => _ChatScreenDuplicateState();
}

class _ChatScreenDuplicateState extends State<ChatScreenDuplicate> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  late Future<void> _geminiInitFuture;

  Future<void> _initializeGemini() async {
    const apiKey = 'AIzaSyA1cC66MZ0njtiNrqNYwKFppl2XTTW6Ryk';
    await Gemini.init(apiKey: apiKey, enableDebugging: true);
  }

  @override
  void initState() {
    super.initState();
    _geminiInitFuture = _initializeGemini();
  }

  void _sendMessage() async {
    final inputText = _controller.text.trim();
    if (inputText.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': inputText});
    });

    _controller.clear();

    final prompt = """
Berikut adalah rencana pembelajaran semester:
$inputText

Tolong analisis tingkat keberhasilan dari rencana tersebut berdasarkan:
- Kelengkapan
- Ketercapaian capaian pembelajaran
- Distribusi materi
- Metode evaluasi

Jawaban harus jelas, terstruktur, dan menggunakan bahasa yang mudah dipahami.
""";

    try {
      final response = await Gemini.instance.prompt(parts: [Part.text(prompt)]);
      setState(() {
        _messages.add({
          'role': 'ai',
          'text': response?.output ?? 'Tidak ada respons dari AI.',
        });
      });
    } catch (e) {
      setState(() {
        _messages.add({
          'role': 'ai',
          'text': 'Terjadi kesalahan: ${e.toString()}',
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _geminiInitFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        return SizedBox(
          height: 500,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = message['role'] == 'user';
                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue[100] : Colors.green[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          message['text'] ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      controller: _controller,
                      placeholder: 'Masukkan rencana pembelajaran semester ini',
                    ),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton(
                    color: CupertinoColors.activeGreen,
                    padding: const EdgeInsets.all(10),
                    child: const Icon(CupertinoIcons.arrow_up_circle),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
