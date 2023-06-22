import 'package:flutter/material.dart';
import 'package:myflutterproject/FriendListScreen.dart';
import 'package:myflutterproject/Chat/chatingroom.dart';
import 'package:provider/provider.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

import 'package:myflutterproject/Login.dart';
import 'package:myflutterproject/SearchInternet.dart';
import 'package:myflutterproject/SignUp.dart';
import 'package:myflutterproject/UserProvider.dart';
import 'package:myflutterproject/FriendListProvider.dart';

// 하단 탭 바 고정 화면
class MyAppMenu extends StatefulWidget {
  const MyAppMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<MyAppMenu> createState() => _MyAppMenuState();
}

class _MyAppMenuState extends State<MyAppMenu> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    _pages = [
      user != null
          ? ChangeNotifierProvider<FriendListProvider>(
              create: (_) => FriendListProvider(
                username: user.username,
                phoneNumber: user.phoneNumber,
                nickname: user.nickname,
              ),
              child: FriendListScreen(user.loginId),
            )
          : CircularProgressIndicator(),
      Chating(username: user!.loginId), // 채팅목록 연결
      SearchInternet(), // 구글 검색창 연결
      SignUp(), // 커뮤니티 피드 연결
      user != null ? Login() : CircularProgressIndicator(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    if (user == null) {
      return CircularProgressIndicator(); // 로딩 중인 경우나 로그인되지 않은 경우
    }
    return Scaffold(
      body: Container(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.black54),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt),
              label: 'Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Chat_space',
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.earth_outline),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(IcoFontIcons.group),
              label: 'profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(BootstrapIcons.gear_fill),
              label: 'setting',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
