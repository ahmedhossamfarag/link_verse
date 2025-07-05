import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:link_verse/control/profile.dart';
import 'package:link_verse/control/validators.dart';
import 'package:link_verse/models/user.dart';
import 'package:link_verse/views/components/overlay_input.dart';
import 'package:link_verse/views/components/text.dart';
import 'package:link_verse/views/tags.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileViewState();
  }
}

class _ProfileViewState extends State<ProfileView> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = createUser();
    getCurrentUserProfile((user) {
      setState(() {
        this.user = user;
      });
    });
  }

  void _editAvatar() {
    XOverlayInput(
      context,
      placeholder: 'Avatar URL',
      validator: uRlValidator,
      callback: (value) {
        updateUserAvatar(
          value,
        ).then((_) => setState(() => user.avatar = value));
      },
    );
  }

  void _editName() {
    XOverlayInput(
      context,
      placeholder: 'Name',
      validator: nameValidator,
      callback: (value) {
        updateUserName(value).then((_) => setState(() => user.name = value));
      },
    );
  }

  void _editTags() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TagsView(tags: user.favoriteTags),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: user.avatar ??
                    'https://www.gravatar.com/avatar/placeholder?s=200&d=mp',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.person, size: 100,),
              ),
            ),
            Container(
              height: 100,
              alignment: Alignment.bottomCenter,
              child: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: _editAvatar,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user.name,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            IconButton(onPressed: _editName, icon: Icon(Icons.edit)),
          ],
        ),
        Divider(color: Colors.white70),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            XHeadingText('Favorite Tags'),
            IconButton(onPressed: _editTags, icon: Icon(Icons.edit)),
          ],
        ),
        Divider(color: Colors.white70),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: user.favoriteTags.map((tag) {
            return Chip(
              label: Text(tag),
              backgroundColor: Colors.blueAccent,
              labelStyle: const TextStyle(color: Colors.white),
            );
          }).toList(),
        ),
      ],
    );
  }
}
