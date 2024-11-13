// lib/models/project.dart
class Project {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String link;

  Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    required this.link,
  });
}

// lib/data/static_data.dart
class StaticData {
  static final personalInfo = {
    'name': 'Abdellh ouknik',
    'profileImage':'assets/images/profile.jpg',
    'title': 'Flutter & Backend Developer',
    'description': 'Passionate freelance developer with expertise in Flutter, Laravel, and Golang.',
    'email': 'ouknikabdeallah@gmail.com',
    'location': 'Marrakech',
    'github': 'ouknik',
    'website':"https://play.google.com/store/apps/developer?id=DeV+Step&hl=ar"
  };

  static final List<Project> projects = [
    Project(
      title: 'Book Library App',
      description: 'Developed a user-friendly book application enabling users to publish, manage, download, and read books. Utilized Flutter for frontend development and Firebase for backend services, ensuring seamless user experience and real-time data management. Demonstrated strong skills in mobile app development and database integration.',
      imageUrl: 'assets/images/project1.png',
      technologies: ['Flutter', 'Firebase'],
      link: 'https://play.google.com/store/apps/details?id=com.app.ouknik.arak&hl=ar',
    ),


    Project(
      title: 'MyMoroccanUniv App',
      description: 'Developed the "MyMoroccanUniv" app, a government-backed application designed to help students access university events, view grades, manage timetables, and request official documents. The app streamlines university services and enhances student engagement through an easy-to-use interface and real-time data integration.',
      imageUrl: 'assets/images/project2.png',
      technologies: ['Flutter', 'Laravel','MySql','Firebase','oracle'],
      link: 'https://www.uca.ma/fssm/fr/news/lapplication-mobile-nationale-mymoroccanuniv',
    ),

     Project(
      title: 'Frah-immobiler App',
      description: 'Developed a real estate advertising app for property sales and rentals, allowing users to post and manage listings. The app facilitates communication between sellers or landlords and potential buyers or renters, offering a simple platform to streamline property transactions.',
      imageUrl: 'assets/images/project3.png',
      technologies: ['Flutter', 'golang','MySql','Firebase'],
      link: 'https://github.com/Ouknik/farah_immobile-/blob/main/README.md',
    ),


    Project(
      title: 'Frah-immobiler web',
      description: 'Developed the web version of the "Farah Immobile" app for posting and managing real estate advertisements for property sales and rentals. The platform allows users to easily create listings, interact with potential buyers or renters, and manage their property offers, providing a streamlined experience for both sellers and clients.',
      imageUrl: 'assets/images/project4.png',
      technologies: ['HTML',"CSS","JS","MaterialZCss","Bootstrap", 'golang','MySql','Firebase'],
      link: 'https://github.com/Ouknik/farah_wep',
    ),

    // Add more projects
  ];

  static final List<Map<String, String>> experience = [
  {
    'company': 'Itic-Solution',
    'position': 'Mobile Developer Intern',
    'duration': 'May 2021 - July 2021',
    'description': 'Developed mobile applications using Flutter and Dart. Integrated APIs and worked with WordPress and WooCommerce for e-commerce solutions.',
  },
  {
    'company': 'It-Exvivo',
    'position': 'Mobile Developer Intern',
    'duration': 'January 2022 - July 2022',
    'description': 'Gained experience with JSON handling, Firebase, Hive, and SQLite in Flutter. Focused on UI/UX and integrated external functionalities through APIs.',
  },
  {
    'company': 'Techpool',
    'position': 'Full Stack Mobile Developer',
    'duration': 'September 2022 - September 2023',
    'description': 'Advanced in Go and MySQL. Created mobile applications with Flutter, designed UI/UX, and built a custom backend with GoLang.',
  },
  {
    'company': 'Université Cadi Ayyad',
    'position': 'Full Stack Mobile Developer',
    'duration': 'December 11 - Present',
    'description': 'Dedicated programmer in creating mobile applications and control panels.',
  },
];

}
