import 'package:flutter/material.dart';
import 'package:flutter_supabase_auth_app/services/auth.dart';

class SignupUi extends StatefulWidget {
  SignupUi({super.key});


  @override
  State<SignupUi> createState() => _SignupUiState();
}

class _SignupUiState extends State<SignupUi> {
  // สร้างตัวควบคุม text field สำหรับ email และ password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'SIGNUP',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
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
                'ลงทะเบียน',
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
                obscureText: true,
                controller: passwordController,
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
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  // VALIDATION UI 
                  if (emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('กรุณากรอก Email'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  if (passwordController.text.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('กรุณากรอกรหัสผ่านอย่างน้อย 6 ตัวอักษร'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  //ส่งข้อมูลๆไปยัง supabase ผ่านฟังก์ชัน signup ในไฟล์ auth.dart
                  //เสร็จแล้วแจ้งข้อความแล้วย้อนกลับไปหน้า login
                  Auth().signup(emailController.text, passwordController.text).then((value){
                    if(value == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('ลงทะเบียนสําเร็จ'),
                          backgroundColor: Colors.green,
                        ),
                      ).closed.then((value) {
                        Navigator.pop(context);
                      });                      
                    }
                  });
                },

                child: Text(
                  'ลงทะเบียน',
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
                  Text(
                    'มีบัญชีอยู่แล้ว?',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                        fontSize: 16,
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
