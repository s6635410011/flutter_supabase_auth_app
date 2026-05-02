import 'package:flutter/material.dart';
import 'package:flutter_supabase_auth_app/services/auth.dart';
import 'package:flutter_supabase_auth_app/views/forget_password_ui.dart';
import 'package:flutter_supabase_auth_app/views/home_ui.dart';

import 'package:flutter_supabase_auth_app/views/signup_ui.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 80,
          left: 40,
          right: 40,
        ),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/images.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                'เข้าใช้งานระบบ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'เช่น sau@gmail.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'ต้องไม่ต่ำกว่า 6 ตัวอักษร',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    //เปิดไปหน้า ForgotPasswordUi แบบย้อนกลับได้
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordUi(),
                      ),
                    );
                  },
                  child: Text(
                    'ลืมรหัสผ่าน',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  // Validation UI
                  if (emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('กรุณากรอก Email'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  if (passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('กรุณากรอกรหัสผ่าน'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  // login
                  Auth()
                      .login(emailController.text, passwordController.text)
                      .then((Value) {
                    // Handle login result
                    if (Value == 'success') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeUi(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text(Value ?? 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  });
                },
                child: Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ยังไม่มีบัญชี?'),
                  TextButton(
                    onPressed: () {
                      //เปิดไปหน้า SignupUi แบบย้อนกลับได้
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupUi(),
                        ),
                      );
                    },
                    child: Text(
                      'ลงทะเบียน',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),  
      ),
    );
  }
}
