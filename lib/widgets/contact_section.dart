import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../controlers/portfolio_controller.dart';
import 'dart:js' as js;

class ContactSection extends GetView<PortfolioController> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final RxBool isLoading = false.obs;

  final String apiUrl = 'https://26cb-196-200-176-254.ngrok-free.app/api/send-email';

  void _openLink(String url) {
    final Uri uri = Uri.parse(url);
    js.context.callMethod('open', [uri.toString(), '_blank']);
  }

  Future<void> _sendEmail() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode({
            'name': nameController.text,
            'email': emailController.text,
            'phone': phoneController.text,
            'message': messageController.text,
          }),
        );

        print(response.body);

        if (response.statusCode == 200) {
          Get.snackbar(
            'Success',
            'Message sent successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          _clearForm();
        } else {
          throw Exception('Failed to send message');
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to send message. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  void _clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Contact Me',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth > 800 ? 800 : constraints.maxWidth,
                child: Column(
                  children: [
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        ContactItem(
                          icon: Icons.email,
                          title: 'Email',
                          content: controller.personalInfo['email']!,
                          onTap: () {
                            final emailUrl = 'mailto:${controller.personalInfo['email']}';
                            _openLink(emailUrl);
                          },
                        ),
                        ContactItem(
                          icon: Icons.location_on,
                          title: 'Location',
                          content: controller.personalInfo['location']!,
                          onTap: () {
                            final mapsUrl = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(controller.personalInfo['location']!)}';
                            _openLink(mapsUrl);
                          },
                        ),
                        ContactItem(
                          icon: Icons.code,
                          title: 'GitHub',
                          content: controller.personalInfo['github']!,
                          onTap: () => _openLink(controller.personalInfo['github']!),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    _buildContactForm(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Stack(
      children: [
        Container(
          width: 600,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!GetUtils.isPhoneNumber(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    prefixIcon: Icon(Icons.message),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Obx(() => ElevatedButton.icon(
                  onPressed: isLoading.value ? null : () => _sendEmail(),
                  icon: isLoading.value 
                      ? Container(
                          width: 24,
                          height: 24,
                          padding: const EdgeInsets.all(2.0),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : Icon(Icons.send),
                  label: Text(isLoading.value ? 'Sending...' : 'Send Message'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
        Obx(() => isLoading.value 
          ? Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        'Sending your message...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : SizedBox.shrink(),
        ),
      ],
    );
  }
}

class ContactItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String content;
  final VoidCallback onTap;

  const ContactItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
    required this.onTap,
  }) : super(key: key);

  @override
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: 250,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isHovered ? Colors.blue.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                widget.icon,
                size: 30,
                color: Colors.blue[700],
              ),
              SizedBox(height: 15),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                widget.content,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}