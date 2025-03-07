import 'package:final_project/style/color_style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  Map<String, dynamic> oldData = {};

  @override
  void initState() {
    super.initState();
    if (user != null) {
      nameController.text = user!.displayName ?? "";
      emailController.text = user!.email ?? "";
      fetchUserData();
    }
  }

  Future<void> fetchUserData() async {
    DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    if (userData.exists) {
      setState(() {
        oldData = userData.data() as Map<String, dynamic>;
        nameController.text = oldData['name'] ?? "";
        emailController.text = oldData['email'] ?? "";
        birthController.text = oldData['birth'] ?? "";
        countryController.text = oldData['countryRegion'] ?? "";
      });
    }
  }

  Future<void> updateProfile() async {
    if (user != null) {
      Map<String, dynamic> newData = {
        'name': nameController.text,
        'email': emailController.text,
        'birth': birthController.text,
        'countryRegion': countryController.text,
      };

      if (oldData.toString() == newData.toString()) {
        showPopup("No changes detected!");
        return;
      }

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set(newData, SetOptions(merge: true));
      showPopup("Profile updated successfully!");
      Get.toNamed("/home");
    }
  }

  void showPopup(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Notification"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        birthController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            buildTextField("Name", nameController),
            buildTextField("Email", emailController, isReadOnly: true),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: buildTextField("Date of Birth", birthController),
              ),
            ),
            buildTextField("Country/Region", countryController),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: updateProfile,
              child: Text("Save Changes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, {bool isReadOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}