import 'package:flutter/material.dart';
import 'package:flutter_supabase_auth_app/services/auth.dart';
import 'package:flutter_supabase_auth_app/views/login_ui.dart';

class UpdatePasswordUi extends StatefulWidget {
  const UpdatePasswordUi({super.key});

  @override
  State<UpdatePasswordUi> createState() => _UpdatePasswordUiState();
}

class _UpdatePasswordUiState extends State<UpdatePasswordUi> {
  //สร้างตัวควบคุม
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Update Password',
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
                'แก้ไขรหัสผ่านใหม่',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: otpController,
                decoration: InputDecoration(
                  labelText: 'OTP',
                  hintText: 'ตรวจสอบ OTP จาก Email ของคุณ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.safety_check),
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
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
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  //validate ui
                  if (otpController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('กรุณากรอก OTP'),
                      ),
                    );
                    return;
                  }
                  if (emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('กรุณากรอก Email'),
                      ),
                    );
                    return;
                  }
                  if (passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('กรุณากรอกรหัสผ่าน'),
                      ),
                    );
                    return;
                  }
                  if (passwordController.text.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('กรุณากรอกรหัสผ่านอย่างน้อย 6 ตัวอักษร'),
                      ),
                    );
                    return;
                  }
                  //ส่งข้อมูลupdate และไปยัง login
                  Auth()
                      .updatePassword(otpController.text,
                          passwordController.text, emailController.text)
                      .then((value) {
                    if (value == 'success') {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                            SnackBar(
                              content: Text('แก้ไขรหัสผ่านสำเร็จ'),
                              backgroundColor: Colors.green,
                            ),
                          )
                          .closed
                          .then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginUi(),
                          ),
                        );
                      });
                    }
                  });
                },
                child: Text(
                  'บันทึกแก้ไขรหัสผ่าน',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
