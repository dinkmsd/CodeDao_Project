import 'package:helper/data/modules.dart';
import 'package:flutter/material.dart';
import 'package:helper/pages/read_page.dart';

class NewItemWidget extends StatefulWidget {
  final NewInfo newInfo;
  const NewItemWidget({super.key, required this.newInfo});
  @override
  State<NewItemWidget> createState() => _NewItemWidgetState();
}

class _NewItemWidgetState extends State<NewItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ReadPage(
                newInfo: widget.newInfo,
              );
            },
          ),
        );
      },
      child: IntrinsicHeight(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(5, 5))
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.newInfo.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.newInfo.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.newInfo.imageAddress,
                      height: MediaQuery.of(context).size.width / 5,
                      width: MediaQuery.of(context).size.width / 4,
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
