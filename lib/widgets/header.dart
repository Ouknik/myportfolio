// lib/widgets/header.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controlers/portfolio_controller.dart';

import 'dart:html' as html;

class Header extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1A237E),
            Color(0xFF0D47A1),
            Color(0xFF1565C0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Animated background particles
          Positioned.fill(
            child: CustomPaint(
              painter: ParticlesPainter(),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Image with animation
                MouseRegion(
                  onEnter: (_) => controller.updateImageHover(true),
                  onExit: (_) => controller.updateImageHover(false),
                  child: Obx(() {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      transform: Matrix4.identity()
                        ..scale(controller.isImageHovered.value ? 1.05 : 1.0),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 15,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profile.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 30),
                // Animated text
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.white, Colors.white70],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds),
                  child: Text(
                    controller.personalInfo['name']!,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                AnimatedTypewriterText(
                  text: controller.personalInfo['title']!,
                  textStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: Get.width * 0.6,
                  child: Text(
                    controller.personalInfo['description']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                // Social links and CV download
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(
                      icon: Icons.email,
                      onTap: () => _launchURL('mailto:${controller.personalInfo['email']}'),
                    ),
                    SizedBox(width: 20),
                    _buildSocialButton(
                      icon: Icons.code,
                      onTap: () => _launchURL('https://github.com/${controller.personalInfo['github']}'),
                    ),
                    SizedBox(width: 20),
                    _buildSocialButton(
                      icon: Icons.language,
                      onTap: () => _launchURL(controller.personalInfo['website'] ?? ''),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Download CV Button
                MouseRegion(
                  onEnter: (_) => controller.updateCVButtonHover(true),
                  onExit: (_) => controller.updateCVButtonHover(false),
                  child: Obx(() {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      transform: Matrix4.identity()
                        ..scale(controller.isCVButtonHovered.value ? 1.05 : 1.0),
                      child: ElevatedButton.icon(
                        onPressed: () => _downloadCV(),
                        icon: Icon(Icons.download),
                        label: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          child: Text(
                            'Download CV',
                            style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Color(0xFF1A237E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: controller.isCVButtonHovered.value ? 8 : 4,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Color(0xFF1A237E),
            size: 24,
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) {
    html.window.open(url, '_blank');
  }

  void _downloadCV() {
    // Replace with your CV file URL
    final cvUrl = 'assets/files/cv.pdf';
    html.AnchorElement(href: cvUrl)
      ..setAttribute('download', 'YourName_CV.pdf')
      ..click();
  }
}

// Animated typewriter text widget
class AnimatedTypewriterText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  AnimatedTypewriterText({
    required this.text,
    required this.textStyle,
  });

  @override
  _AnimatedTypewriterTextState createState() => _AnimatedTypewriterTextState();
}

class _AnimatedTypewriterTextState extends State<AnimatedTypewriterText> {
  String _displayText = '';
  int _charIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    while (_charIndex < widget.text.length) {
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        _displayText += widget.text[_charIndex];
        _charIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      style: widget.textStyle,
    );
  }
}

// Particles animation
class ParticlesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Add animated particles here
    // This is a simplified version, you might want to add more complex animations
    for (var i = 0; i < 50; i++) {
      canvas.drawCircle(
        Offset(
          size.width * (i / 50),
          size.height * ((i % 3) / 3),
        ),
        2,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}