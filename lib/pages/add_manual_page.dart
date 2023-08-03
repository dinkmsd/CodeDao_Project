import 'package:helper/data/modules.dart';
import 'package:helper/utils/api_helper.dart';
import 'package:flutter/material.dart';

class AddManualPage extends StatefulWidget {
  const AddManualPage({super.key});

  @override
  State<AddManualPage> createState() => _AddManualPageState();
}

class _AddManualPageState extends State<AddManualPage> {
  final TextEditingController _wordTextController = TextEditingController();
  final TextEditingController _meaningTextController = TextEditingController();
  final TextEditingController _describeTextController = TextEditingController();
  final TextEditingController _typeTextController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _wordTextController.dispose();
    _meaningTextController.dispose();
    _describeTextController.dispose();
    _typeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Manual'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Add Word',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: _wordTextController,
                decoration: InputDecoration(
                  hintText: 'Enter word',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _meaningTextController,
                decoration: InputDecoration(
                  hintText: 'Enter meaning',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _describeTextController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Enter describe',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _typeTextController,
                decoration: InputDecoration(
                  hintText: 'Enter type',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        NewWordInfo dummy = NewWordInfo(
                            id: 'null',
                            word: _wordTextController.text,
                            meaning: _meaningTextController.text,
                            favourite: false,
                            type: _typeTextController.text,
                            describe: _describeTextController.text);
                        ApiHelper.addListWords('dinkmsd', dummy);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: const Text('Add Word'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Colors.blueGrey[900]!, width: 2)),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
