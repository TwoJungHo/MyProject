import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kakaomessage/project.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  const Chat({required this.username1, required this.username2, required this.title, required this.Chatmessage, Key? key})
      : super(key: key);
  final String username1;
  final String username2;
  final String title;
  final List<dynamic> Chatmessage;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  //final channel = IOWebSocketChannel.connect('ws://10.0.2.2:9000');
  TextEditingController _textEditingController = TextEditingController();

  void _sendMessage() {
    String message = _textEditingController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        widget.Chatmessage.add(message);
      });
      _textEditingController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.brown,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.Chatmessage.length,
              itemBuilder: (context, index) {
                return Bubble(message: widget.Chatmessage[index], isMe: index % 2 == 0);
              },
            ),
          ),
          Divider(
            height: 2,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                    child:
                        Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            controller: _textEditingController,
                            decoration: InputDecoration.collapsed(hintText: '메시지를 입력해주세요'),
                          ),
                        ),
                ),
                IconButton(onPressed: _sendMessage, icon: Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const Bubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isMe ? Colors.yellow : Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}

