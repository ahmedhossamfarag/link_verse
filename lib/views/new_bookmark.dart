import 'package:flutter/material.dart';
import 'package:link_verse/control/validators.dart';
import 'package:link_verse/models/collection.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/text_field.dart';

class NewBookmarkView extends StatefulWidget {
  final Collection collection;
  const NewBookmarkView({super.key, required this.collection});

  @override
  State<StatefulWidget> createState() {
    return _NewBookmarkViewState();
  }
}

class _NewBookmarkViewState extends State<NewBookmarkView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _changeTitle(String value) {
    // Handle title change
  }

  void _changeDescription(String value) {
    // Handle description change
  }

  void _changeUrl(String value) {
    // Handle URL change
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle form submission logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4999B6),
      appBar: AppBar(
        title: const Text('New Bookmark'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              XTextField(
                onChanged: _changeTitle,
                placeholder: 'Title',
                prefixIcon: Icons.title,
                validator: titleValidator,
              ),
              const SizedBox(height: 16.0),
              XTextField(
                onChanged: _changeDescription,
                placeholder: 'Description',
                prefixIcon: Icons.description,
                validator: descriptionValidator,
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              XTextField(
                onChanged: _changeUrl,
                placeholder: 'URL',
                prefixIcon: Icons.link,
                validator: uRlValidator,
              ),
              const Expanded(child: SizedBox(),),
              XButton(
                onPressed: _submitForm,
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
