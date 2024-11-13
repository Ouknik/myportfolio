import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controlers/portfolio_controller.dart';
import 'dart:math';
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
          AnimatedBuilder(
            animation: controller.particleAnimation,
            builder: (context, child) {
              return Positioned.fill(
                child: CustomPaint(
                  painter: ParticlesPainter(animation: controller.particleAnimation),
                ),
              );
            }
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
                              blurRadius: controller.isImageHovered.value ? 25 : 15,
                              spreadRadius: controller.isImageHovered.value ? 8 : 5,
                              offset: Offset(0, controller.isImageHovered.value ? 8 : 5),
                            ),
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.2),
                              blurRadius: controller.isImageHovered.value ? 45 : 0,
                              spreadRadius: controller.isImageHovered.value ? 15 : 0,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            controller.personalInfo['profileImage'] ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.person, size: 100, color: Colors.white);
                            },
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
                // Social links
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
                      onTap: () => _launchURL(controller.personalInfo['github'] ?? ''),
                    ),
                    SizedBox(width: 20),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _launchURL(controller.personalInfo['playstore'] ?? ''),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: CircleBorder(),
                            onTap: () => _launchURL(controller.personalInfo['playstore'] ?? ''),
                            splashColor: Color(0xFF1A237E).withOpacity(0.3),
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
                              child: Image.asset(
                                "assets/images/googleplay.png",
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // CV Button
                MouseRegion(
                  onEnter: (_) => controller.updateCVButtonHover(true),
                  onExit: (_) => controller.updateCVButtonHover(false),
                  child: Obx(() {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      transform: Matrix4.identity()
                        ..scale(controller.isCVButtonHovered.value ? 1.05 : 1.0),
                      child: Material(
                        color: Colors.transparent,
                        child: ElevatedButton.icon(
                          onPressed: () => _viewCV(),
                          icon: Icon(Icons.visibility, color: Color(0xFF1A237E)),
                          label: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            child: Text(
                              'View CV',
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 1,
                                color: Color(0xFF1A237E),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: onTap,
          splashColor: Color(0xFF1A237E).withOpacity(0.3),
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
      ),
    );
  }

  void _launchURL(String url) {
    html.window.open(url, '_blank');
  }

void _viewCV() {
try {
// افتح السيرة الذاتية في تبويب جديد
html.window.open('assets/files/cv.pdf', '_blank');

} catch (e) {
// إظهار رسالة خطأ في حالة فشل فتح الملف
Get.snackbar(
'Error',
'Unable to open CV. Please try again later.',
snackPosition: SnackPosition.BOTTOM,
backgroundColor: Colors.red,
colorText: Colors.white,
duration: Duration(seconds: 3),
);
}}
}

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

class _AnimatedTypewriterTextState extends State<AnimatedTypewriterText> 
    with SingleTickerProviderStateMixin {
  String _displayText = '';
  int _charIndex = 0;
  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _startAnimation();
  }

  void _startAnimation() async {
    while (_charIndex < widget.text.length) {
      await Future.delayed(Duration(milliseconds: 100));
      if (mounted) {
        setState(() {
          _displayText += widget.text[_charIndex];
          _charIndex++;
        });
      }
    }
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _displayText,
          style: widget.textStyle,
        ),
        if (_charIndex < widget.text.length)
          AnimatedBuilder(
            animation: _cursorController,
            builder: (context, child) {
              return Opacity(
                opacity: _cursorController.value,
                child: Text(
                  '|',
                  style: widget.textStyle,
                ),
              );
            },
          ),
      ],
    );
  }
}

class Particle {
  final double dx;
  final double dy;
  final double radius;
  final double opacity;
  final double speed;

  Particle.random()
      : dx = Random().nextDouble(),
        dy = Random().nextDouble(),
        radius = Random().nextDouble() * 3 + 1,
        opacity = Random().nextDouble() * 0.2 + 0.1,
        speed = Random().nextDouble() * 2 + 0.5;

  Offset position(Size size, double t) {
    final x = (dx * size.width + cos(t * speed) * 20) % size.width;
    final y = (dy * size.height + sin(t * speed) * 20) % size.height;
    return Offset(x, y);
  }
}

class ParticlesPainter extends CustomPainter {
  final Animation<double> animation;
  final List<Particle> particles;

  ParticlesPainter({required this.animation}) 
    : particles = List.generate(100, (index) => Particle.random());

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    particles.forEach((particle) {
      final position = particle.position(size, animation.value);
      paint.color = Colors.white.withOpacity(particle.opacity);
      canvas.drawCircle(position, particle.radius, paint);
    });
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => true;
}