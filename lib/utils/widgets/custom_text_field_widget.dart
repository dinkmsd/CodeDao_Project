import 'package:flutter/material.dart';



class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required this.label, required this.text,this.maxLines = 1, required this.onChanged});
  final String label;
  final int maxLines;
  final String text;
  final ValueChanged<String> onChanged;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        
        ),
        const SizedBox(height: 5,),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),
          controller: _controller,
          maxLines:widget.maxLines,
        )
      ],
    );
  }
}