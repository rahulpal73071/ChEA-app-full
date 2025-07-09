import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chea/pages/blogs_pages/blogs/blog_service.dart';

class PostBlogPage extends StatefulWidget {
  const PostBlogPage({super.key});

  @override
  State<PostBlogPage> createState() => _PostBlogPageState();
}

class _PostBlogPageState extends State<PostBlogPage> {
  File? _image;
  final picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _thoughtController = TextEditingController();
  String category = 'Internship';

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  Future<void> _uploadBlog() async {
    if (_image == null ||
        _nameController.text.isEmpty ||
        _titleController.text.isEmpty ||
        _thoughtController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields and pick an image")),
      );
      return;
    }

    final success = await BlogService().createBlog(
      name: _nameController.text,
      title: _titleController.text,
      thought: _thoughtController.text,
      blogType: category,
      imageFile: _image!,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Uploaded")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to upload blog")));
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.teal, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Post Blog"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: _inputDecoration("Name"),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: _inputDecoration("Title"),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _thoughtController,
                decoration: _inputDecoration("Thought"),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: category,
                decoration: _inputDecoration("Select Category"),
                items: ['Internship', 'Placement' , 'InternEra' , 'SemEx' , 'ICYDontKnow' , 'ThenVsNow']
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (val) => setState(() => category = val!),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Pick Image"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              if (_image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(_image!, height: 180),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _uploadBlog,
                child: const Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
