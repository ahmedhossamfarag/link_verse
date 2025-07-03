import 'package:flutter/material.dart';
import 'package:link_verse/views/collections.dart';
import 'package:link_verse/views/components/text.dart';
import 'package:link_verse/views/explore.dart';
import 'package:link_verse/views/likes.dart';
import 'package:link_verse/views/profile.dart';
import 'package:link_verse/views/search.dart';

class NavLayout extends StatefulWidget {
  final String? title;
  final Widget? body;
  final IconData? actionIcon;
  final void Function()? actionHandler;
  final int selectedIndex;
  const NavLayout({
    super.key,
    this.title,
    this.body,
    this.actionIcon,
    this.actionHandler,
    required this.selectedIndex,
  });

  @override
  State<StatefulWidget> createState() {
    return _NavLayoutState();
  }
}

class _NavLayoutState extends State<NavLayout> {
  String? title = '';
  IconData? actionIcon;
  void Function()? actionHandler;
  int selectedIndex = 0;
  Widget? body;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
    title = widget.title;
    actionIcon = widget.actionIcon;
    actionHandler = widget.actionHandler;
    body = widget.body;
  }

  void _setBody() {
    if (body != null) {
      return;
    }
    switch (selectedIndex) {
      case 0:
        var view = CollectionsView();
        body = view;
        title = view.title;
        actionIcon = view.actionIcon;
        actionHandler = view.actionHandler?.handler;
        break;
      case 1:
        body = SearchView();
        title = null;
        actionIcon = null;
        actionHandler = null;
        break;
      case 2:
        body = ExploreView();
        title = null;
        actionIcon = null;
        actionHandler = null;
        break;
      case 3:
        const view = LikesView();
        body = view;
        title = view.title;
        actionIcon = null;
        actionHandler = null;
        break;
      case 4:
        body = ProfileView();
        title = null;
        actionIcon = null;
        actionHandler = null;
        break;
      default:
        body = Center(child: Text('Unknown View'));
    }
  }

  @override
  Widget build(BuildContext context) {
    _setBody();
    return Scaffold(
      appBar: title != null
          ? AppBar(
              backgroundColor: Colors.transparent,
              title: XHeadingText(title!),
              actions: [
                if (actionIcon != null)
                  IconButton(
                    icon: Icon(actionIcon, color: Colors.white, size: 40),
                    onPressed: actionHandler,
                  ),
              ],
            )
          : null,
      body: Padding(padding: const EdgeInsets.all(16), child: body),
      backgroundColor: Color(0xFF4999B6),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Color(0xFF00BAFD),
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.collections),
            label: 'Collections',
          ),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Likes'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
            body = null;
          });
        },
      ),
    );
  }
}
