import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controlers/portfolio_controller.dart';

class ExperienceSection extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[50]!,
            Colors.white,
            Colors.grey[50]!,
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          _buildSectionHeader(),
          SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth > 1000 ? 1000 : constraints.maxWidth,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.experience.length,
                  itemBuilder: (context, index) {
                    final exp = controller.experience[index];
                    return ExperienceCard(
                      experience: exp,
                      index: index,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Text(
          'Work Experience',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [
                  Color(0xFF1A237E),
                  Color(0xFF0D47A1),
                ],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          ),
        ),
        SizedBox(height: 15),
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1A237E),
                Color(0xFF0D47A1),
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class ExperienceCard extends StatefulWidget {
  final Map<String, String> experience;
  final int index;

  const ExperienceCard({
    Key? key,
    required this.experience,
    required this.index,
  }) : super(key: key);

  @override
  _ExperienceCardState createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            child: MouseRegion(
              onEnter: (_) {
                setState(() => isHovered = true);
                _controller.forward();
              },
              onExit: (_) {
                setState(() => isHovered = false);
                _controller.reverse();
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isHovered
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.1),
                      spreadRadius: isHovered ? 5 : 2,
                      blurRadius: isHovered ? 15 : 5,
                      offset: Offset(0, isHovered ? 5 : 3),
                    ),
                  ],
                ),
                child: _buildCardContent(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardContent() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.experience['company']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        background: Paint()
                          ..shader = LinearGradient(
                            colors: [
                              Color(0xFF1A237E),
                              Color(0xFF0D47A1),
                            ],
                          ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF1A237E).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.experience['duration']!,
                      style: TextStyle(
                        color: Color(0xFF1A237E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF1A237E).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.experience['position']!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF1A237E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                widget.experience['description']!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 15,
          top: 15,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: isHovered ? 1.0 : 0.0,
            child: Icon(
              Icons.work_outline,
              color: Color(0xFF1A237E).withOpacity(0.2),
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}