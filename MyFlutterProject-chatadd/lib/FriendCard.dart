import 'package:flutter/material.dart';
import 'package:myflutterproject/UserDTO.dart';

class FriendCard extends StatelessWidget {
  final UserDto user;
  final ImageProvider<Object>? imageProvider;
  final VoidCallback? onTap;
  final ValueChanged<bool?>? onCheckChanged;

  FriendCard({
    required this.user,
    this.imageProvider,
    this.onTap,
    this.onCheckChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundImage:
                    imageProvider ?? AssetImage('assets/human.jpeg'),
                backgroundColor: Colors.blue[600],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.nickname} (${user.loginId})',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    user.statusMSG ?? '',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            if (onCheckChanged != null)
              Checkbox(
                value: user.checked,
                onChanged: onCheckChanged,
              ),
          ],
        ),
      ),
    );
  }
}
