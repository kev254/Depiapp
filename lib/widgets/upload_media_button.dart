import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadMediaButton extends StatefulWidget {
  const UploadMediaButton({super.key, required this.onMediaSelected, required this.label, required this.icon});
  final Function? onMediaSelected;
  final IconData icon;
  final String label;

  @override
  State<UploadMediaButton> createState() => _UploadMediaButtonState();
}

class _UploadMediaButtonState extends State<UploadMediaButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () async {
              final ImagePicker picker = ImagePicker();

              final pickedImage = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (pickedImage != null) {
                final imageFile = File(pickedImage.path);
                widget.onMediaSelected!(imageFile);
              }
            },
            icon:  Icon(widget.icon),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
         Text(
          widget.label,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
