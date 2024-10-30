import 'package:flutter/material.dart';
import 'package:minimal_1/pages/chat_screen.dart';
import 'package:minimal_1/services/auth/auth_service.dart';
import 'package:minimal_1/services/chat/chat_services.dart';

import '../components/my_drawer.dart';
import '../components/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });
  final _chatService = ChatServices();
  final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          title: const Text(
            'Home Page',
          ),
        ),
        drawer: const MyDrawer(),
        body: _buildUserList(),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          // error..
          if (snapshot.hasError) {
            return const Text('Error');
          }

          // loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.green,
              value: 0.5,
            ));
          }

          //return listview..
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserData(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserData(Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user.

    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                  receiverEmail: userData['email'],
                  receiverId: userData['uid']),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
