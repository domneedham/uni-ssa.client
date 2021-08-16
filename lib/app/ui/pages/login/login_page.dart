import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ssa_app/app/controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Email"),
                  controller: controller.emailController,
                  validator: controller.validateEmail,
                  autocorrect: false,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
