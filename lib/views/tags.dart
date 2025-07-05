import 'package:flutter/material.dart';
import 'package:link_verse/control/profile.dart';
import 'package:link_verse/control/tags.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/overlay_loading.dart';
import 'package:link_verse/views/components/text.dart';
import 'package:link_verse/views/components/text_field.dart';
import 'package:link_verse/views/home.dart';
import 'package:link_verse/views/layouts/nav_layout.dart';
import 'package:link_verse/views/layouts/padding_layout.dart';

class TagsView extends StatefulWidget {
  final List<String>? tags;
  const TagsView({super.key, this.tags});

  @override
  State<TagsView> createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> {
  List<String> tags = [];
  List<String> filteredTags = [];
  String searchQuery = '';
  List<String> selectedTags = [];

  @override
  void initState() {
    super.initState();
    tags = [
      'Technology',
      'Science',
      'Health',
      'Education',
      'Entertainment',
      'Sports',
      'Travel',
      'Food',
      'Lifestyle',
      'Business',
    ];
    selectedTags = widget.tags ?? [];
    getTags().then((value) => setState(() => tags.addAll(value)));
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
      filteredTags = tags
          .where((tag) => tag.toLowerCase().contains(searchQuery))
          .toList();
    });
  }

  void _exit(){
    if(widget.tags != null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const NavLayout(selectedIndex: 4,)));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView()));
    }
  }

  void _saveTags() {
    final loading = showLoadingOverlay(context);
    updateUserTags(selectedTags).then((value){
      loading.remove();
      _exit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PaddingLayout(
      child: Column(
        children: [
          const XHeadingText('Select Your Tags', fontSize: 18),
          const SizedBox(height: 16),
          XTextField(
            onChanged: _onSearchChanged,
            placeholder: 'Search Tags',
            prefixIcon: Icons.search,
          ),
          const SizedBox(height: 16),
          // Expanded(
          // child: ListView.builder(
          //   itemCount: searchQuery.isEmpty ? tags.length : filteredTags.length,
          //   itemBuilder: (context, index) {
          //     String tag = searchQuery.isEmpty ? tags[index] : filteredTags[index];
          //     bool isSelected = selectedTags.contains(tag);
          //     return ListTile(
          //       title: Text(tag),
          //       trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
          //       onTap: () {
          //         setState(() {
          //           if (isSelected) {
          //             selectedTags.remove(tag);
          //           } else {
          //             selectedTags.add(tag);
          //           }
          //         });
          //       },
          //     );
          //   },
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                children: (searchQuery.isEmpty ? tags : filteredTags).map((
                  tag,
                ) {
                  bool isSelected = selectedTags.contains(tag);
                  return ChoiceChip(
                    label: Text(tag),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedTags.add(tag);
                        } else {
                          selectedTags.remove(tag);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          XButton(onPressed: _saveTags, child: const Text('Continue')),
        ],
      ),
    );
  }
}
