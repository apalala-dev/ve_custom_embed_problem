import 'package:flutter/material.dart';
import 'package:visual_editor/controller/controllers/editor-controller.dart';
import 'package:visual_editor/documents/models/nodes/embed.model.dart';
import 'package:visual_editor/main.dart';
import 'package:visual_editor/visual-editor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
  late EditorController _controller;

  @override
  void initState() {
    _controller = EditorController(
      document: DocumentM(),
      selection: const TextSelection.collapsed(offset: 0),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Custom embed for visual_editor',
          ),
          Expanded(
            child: VisualEditor(
              controller: _controller,
              config: EditorConfigM(embedBuilder: customEmbedBuilderButton),
              focusNode: FocusNode(),
              scrollController: ScrollController(),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                final index = _controller?.selection.baseOffset ?? 0;
// final length = ()_controller?.selection.extentOffset ?? 0 - index;
                setState(() {
                  _controller.document.insert(
                      index, const EmbeddableM('specialKey', 'someValue'));
                });
              },
              child: Text('Add Embed'))
        ],
      ),
    );
  }

  Widget customEmbedBuilderAlign(BuildContext context,
      EditorController controller, EmbedM node, bool readOnly) {
    switch (node.value.type) {
      case "specialKey":
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
              child: Text(node.value.data.toString()), color: Colors.green),
        );
    }
    return Container(width: 50, height: 50, color: Colors.purple);
  }

  Widget customEmbedBuilderButton(BuildContext context,
      EditorController controller, EmbedM node, bool readOnly) {
    switch (node.value.type) {
      case "specialKey":
        return ElevatedButton(
          onPressed: () {},
          child: Text(node.value.data.toString()),
        );
    }
    return Container(width: 50, height: 50, color: Colors.purple);
  }

  Widget customEmbedBuilder(BuildContext context, EditorController controller,
      EmbedM node, bool readOnly) {
    switch (node.value.type) {
      case "specialKey":
        return Container(
          color: Colors.red,
          child: Row(children: [
            Container(
                child: Text(node.value.data.toString()), color: Colors.green),
            const Spacer(),
          ]),
        );
    }
    return Container(width: 50, height: 50, color: Colors.purple);
  }
}
