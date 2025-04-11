import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bluxkart/constants/consts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: "Contact Us".text.white.make(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Contact Us",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                "We're always here to assist you. For any questions or concerns feel free to drop us a mail or WhatsApp us. We'll get back to you as soon as we can!"
                .text.white.size(22).bold.make(),
                20.heightBox,
                // Card(
                //   color: Colors.transparent,
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                //   elevation: 10,
                //   child: Padding(
                //     padding: const EdgeInsets.all(16),
                //     child: Column(
                //       children: [
                //         _darkInput("Your Name"),
                //         const SizedBox(height: 12),
                //         _darkInput("Email Address"),
                //         const SizedBox(height: 12),
                //         _darkInput("Message", maxLines: 4),
                //         const SizedBox(height: 20),
                //         ElevatedButton.icon(
                //           onPressed: () {
                //
                //           },
                //           icon: const Icon(Icons.send, color: Colors.white),
                //           label: const Text("Send Message", style: TextStyle(color: Colors.white)),
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: Colors.deepPurpleAccent,
                //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                const SizedBox(height: 30),

                _infoCard(Icons.phone, "Phone", "+91 6284925030"),
                _infoCard(Icons.email, "Email", "support@bluxkart.com"),
                _infoCard(Icons.location_on, "Address", "St.no.3 Machhiwara road, Kohara,ludhiana, PB-141112"),

                const SizedBox(height: 20),

                const Text(
                  "Follow Us",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _socialIcon(Icons.facebook, () {}),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _darkInput(String label, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepPurpleAccent),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String subtitle) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurpleAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }

  Widget _socialIcon(IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white10,
          child: Icon(icon, color: Colors.deepPurpleAccent),
        ),
      ),
    );




  }
}
