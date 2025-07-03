import 'package:flutter/material.dart';
import 'package:link_verse/models/collection.dart';
import 'package:link_verse/views/bookmarks.dart';
import 'package:link_verse/views/new_collection.dart';

class ActionHandler {
  void Function()? actionHandler;

  void handler() {
    if (actionHandler != null) {
      actionHandler!();
    }
  }
}

class CollectionsView extends StatefulWidget {
  final String? title = 'Collections';
  final IconData? actionIcon = Icons.add;
  final ActionHandler? actionHandler;

  CollectionsView({super.key}) : actionHandler = ActionHandler();

  @override
  State<StatefulWidget> createState() {
    return _CollectionsViewState();
  }
}

class _CollectionsViewState extends State<CollectionsView> {
  List<Collection> collections = [];

  @override
  void initState() {
    super.initState();
    // Initialize collections or fetch from a service
    collections = createCollections();
    widget.actionHandler?.actionHandler = addCollection;
  }

  void addCollection() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewCollectionView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < collections.length; i += 2)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CollectionCard(collection: collections[i], context: context),
              if (i + 1 < collections.length)
                CollectionCard(collection: collections[i + 1], context: context),
            ],
          ),
      ],
    );
  }
}

class CollectionCard extends StatelessWidget {
  final Collection collection;
  final BuildContext context;

  const CollectionCard({super.key, required this.collection, required this.context});

  void _viewCollection() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => BookmarksView(collection: collection)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _viewCollection,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                collection.imageUrl,
                height: 122,
                width: 136,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12),
            Text(
              collection.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF7F2F2),
              ),
            ),
            Text(
              '${collection.noItems} saved items',
              style: TextStyle(fontSize: 12, color: Color(0xFFBDE8F7)),
            ),
          ],
        ),
      ),
    );
  }
}
