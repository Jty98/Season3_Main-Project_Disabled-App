import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/login/login.dart';

import '../../binding/Binding.dart';
import '../../vm/loginCtrl.dart';
import '../register/register.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find<LoginController>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
            accountName: Obx(
              () => loginController.isLogged.value
                  ? Text('환영합니다, ${loginController.userName.value}님!',
                      style: const TextStyle(
                          fontFamily: "NotoSansKR-Bold", color: Colors.black))
                  : const Text("로그인이 필요합니다",
                      style: TextStyle(
                          fontFamily: "NotoSansKR-Bold", color: Colors.black)),
            ),
            accountEmail: Obx(
              () => loginController.isLogged.value
                  ? Text(loginController.userId.value,
                      style: const TextStyle(
                          fontFamily: "NotoSansKR-Bold", color: Colors.black))
                  : const Text(""),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(
                RegisterUser(),
              );
            },
            leading: Icon(Icons.emoji_people_sharp,
                color: Theme.of(context).colorScheme.secondary),
            title: const Text('회원가입 하기'),
          ),
          ListTile(
            onTap: () {
              Get.to(
                const LoginUser(),
                binding: LoginBinding(),
              );
            },
            leading: Icon(Icons.login,
                color: Theme.of(context).colorScheme.secondary),
            title: const Text('로그인 하기'),
          ),
          OutlinedButton(
            onPressed: () {
              Get.changeTheme(
                Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
              );
            },
            child: const Text('테마변경'),
          ),
        ],
      ),
    );
  }
}
