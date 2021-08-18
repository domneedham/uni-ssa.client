import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssa_app/app/controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Staff Skill Auditor",
              style: Get.textTheme.headline4,
            ),
            Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: Key("email"),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                    ),
                    controller: controller.emailController,
                    validator: controller.validateEmail,
                    autocorrect: false,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    key: Key("password"),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    controller: controller.passwordController,
                    validator: controller.validatePassword,
                    autocorrect: false,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: controller.login,
                    child: Text("Login"),
                  ),
                  SizedBox(height: Get.height / 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
