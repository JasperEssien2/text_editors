import 'package:flutter/material.dart';
import 'package:text_editors/save_file_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Editor',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///TODO3: Replace [MethodChannelService] with [PigeonFileApiService]
  ///
  // ignore: prefer_final_fields
  late SaveFileService _saveFileService = MethodChannelService();

  final _textController = TextEditingController();
  final _fileNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editor"),
      ),
      body: Column(
        children: [
          _textField(hint: "File name", controller: _fileNameController),
          _textField(
            hint: "Write text...",
            maxLines: null,
            minLines: 7,
            controller: _textController,
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final messenger = ScaffoldMessenger.of(context);
          final successful = await _saveFileService.saveFile(
            fileName: _fileNameController.text,
            text: _textController.text,
          );

          messenger.showSnackBar(
            SnackBar(
              content: Text(
                successful ? "Saved file successfully" : "Error in saving file",
              ),
            ),
          );
        },
        tooltip: 'Save',
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _textField({
    required String hint,
    int? maxLines = 1,
    int? minLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
        maxLines: maxLines,
        minLines: minLines,
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _fileNameController.dispose();
    super.dispose();
  }
}
