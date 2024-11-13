// lib/widgets/projects_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controlers/portfolio_controller.dart';
import '../models/project.dart';
import 'project_card.dart';
import 'dart:html' as html;
class ProjectsSection extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            'My Projects',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth > 1200 ? 3 : 
                                constraints.maxWidth > 800 ? 2 : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.3,
                ),
                itemCount: controller.projects.length,
                itemBuilder: (context, index) {
                  final project = controller.projects[index];
                  return  GestureDetector(
                    onTap: (){
                      _launchURL(project.link);
                    },
                    child:  ProjectCard(project: project));
                },
              );
            }
          ),
        ],
      ),
    );
  }
}

 void _launchURL(String url) {
    html.window.open(url, '_blank');
  }
/*
class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                project.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    project.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.technologies.map((tech) => Chip(
                      label: Text(tech),
                      backgroundColor: Colors.blue[100],
                    )).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/