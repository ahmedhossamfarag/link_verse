import 'package:flutter/material.dart';
import 'package:link_verse/control/validators.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/text_field.dart';

class NewCollectionView extends StatefulWidget {
  const NewCollectionView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewCollectionViewState();
  }
}

class _NewCollectionViewState extends State<NewCollectionView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _changeName(String p1) {}

  void _changeDescription(String p1) {}

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle form submission logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4999B6),
      appBar: AppBar(
        title: const Text('New Collection'),
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
                onChanged: _changeName,
                placeholder: 'Name',
                prefixIcon: Icons.title,
                validator: nameValidator,
              ),
              const SizedBox(height: 16.0),
              XTextField(
                onChanged: _changeDescription,
                placeholder: 'Description',
                prefixIcon: Icons.description,
                validator: descriptionValidator,
                maxLines: 3,
              ),
              Expanded(child: SizedBox()),
              XButton(
                onPressed: _submitForm,
                child: const Text('Create Collection'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
