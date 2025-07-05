import 'package:flutter/material.dart';
import 'package:link_verse/control/collections.dart';
import 'package:link_verse/control/validators.dart';
import 'package:link_verse/models/collection.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/overlay_loading.dart';
import 'package:link_verse/views/components/text_field.dart';
import 'package:link_verse/views/layouts/nav_layout.dart';

class NewCollectionView extends StatefulWidget {
  const NewCollectionView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewCollectionViewState();
  }
}

class _NewCollectionViewState extends State<NewCollectionView> {
  Collection collection = Collection();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _changeName(String value) {
    collection.name = value;
  }

  void _changeDescription(String value) {
    collection.description = value;
  }

  void _changeImageUrl(String value) {
    collection.imageUrl = value;
  }

  void _exit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NavLayout(selectedIndex: 0),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final loading = showLoadingOverlay(context);
      createCollectionDoc(collection).then((value) {
        loading.remove();
        _exit();
      });
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
      body: SingleChildScrollView(
        child: Padding(
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
                const SizedBox(height: 16.0),
                XTextField(
                  onChanged: _changeImageUrl,
                  placeholder: 'Image URL',
                  prefixIcon: Icons.image,
                  validator: uRlValidator,
                ),
                const SizedBox(height: 32,),
                XButton(
                  onPressed: _submitForm,
                  child: const Text('Create Collection'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
