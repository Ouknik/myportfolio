import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
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
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
          _controller.forward();
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
          _controller.reverse();
        });
      },
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isHovered ? 0.3 : 0.1),
                    blurRadius: isHovered ? 30 : 20,
                    spreadRadius: isHovered ? 7 : 5,
                    offset: Offset(0, isHovered ? 10 : 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Stack(
                  children: [
                    // Background Image
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      transform: Matrix4.identity()
                        ..translate(
                          isHovered ? -10.0 : 0.0,
                          isHovered ? -10.0 : 0.0,
                        ),
                      child: Image.asset(
                        widget.project.imageUrl,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(isHovered ? 0.9 : 0.7),
                          ],
                          stops: const [0.4, 1.0],
                        ),
                      ),
                    ),

                    // Content
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Project Title
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: isHovered ? 28 : 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: isHovered ? 1.2 : 1.0,
                            ),
                            child: Text(widget.project.title),
                          ),
                          
                          const SizedBox(height: 15),
                          
                          // Project Description
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: isHovered ? 1.0 : 0.7,
                            child: Text(
                              widget.project.description,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                height: 1.5,
                              ),
                              maxLines: isHovered ? 4 : 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Technologies Tags
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: widget.project.technologies.map((tech) => 
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isHovered ? 15 : 12,
                                  vertical: isHovered ? 8 : 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isHovered 
                                    ? Colors.white.withOpacity(0.3)
                                    : Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  tech,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isHovered ? 15 : 14,
                                    fontWeight: isHovered 
                                      ? FontWeight.w600 
                                      : FontWeight.normal,
                                  ),
                                ),
                              )
                            ).toList(),
                          ),
                          
                          // View Project Button
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: isHovered ? 45 : 0,
                            margin: EdgeInsets.only(top: isHovered ? 20 : 0),
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: isHovered ? 1.0 : 0.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your action here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 12,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      'View Project',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward_rounded),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}