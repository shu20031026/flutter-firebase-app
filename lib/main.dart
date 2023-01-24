import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/service/firebase_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseService _service = FirebaseService();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                alignment: Alignment.topCenter,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _service.getItems(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('エラー');
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final List contents = snapshot.data!.docs.map((doc) {
                      Map value = doc.data() as Map<dynamic, dynamic>;
                      value['docId'] = doc.id;
                      return value;
                    }).toList();

                    return ListView.builder(
                      itemCount: contents.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map content = contents[index];
                        bool isCheckedValue = content["isChecked"];
                        return Column(
                          children: [
                            MyCheckBox(
                              defaultValue: isCheckedValue,
                              onChanged: (value) {
                                _service.updateItem(doc: content["docId"], isChecked: value);
                              },
                            ),
                            Text(content['content'], style: TextStyle(fontSize: 24)),
                            MaterialButton(
                              onPressed: () => _service.deleteItem(doc: content["docId"]),
                              color: Colors.redAccent,
                              child: const Text(
                                '削除',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                            // Text(content['isChecked'], style: TextStyle(fontSize: 18)),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _service.postItem(content: _controller.text);
                    setState(_controller.clear);
                  },
                  child: const Text('追加'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyCheckBox extends StatefulWidget {
  final bool defaultValue;
  final ValueChanged<bool?>? onChanged;

  const MyCheckBox({Key? key, required this.defaultValue, required this.onChanged}) : super(key: key);

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool _flag = false;
  @override
  void initState() {
    _flag = widget.defaultValue;
    super.initState();
  }

  void _handleCheckbox(bool? e) {
    setState(() {
      _flag = e!;
    });
    widget.onChanged!(e);
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      activeColor: Colors.blue,
      value: _flag,
      onChanged: _handleCheckbox,
    );
  }
}
