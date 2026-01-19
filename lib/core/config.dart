class AppConfig {
  final String baseUrl;

  const AppConfig({required this.baseUrl});

  // const AppConfig.dev() : baseUrl = 'http://192.168.1.44:3000/';
  //const AppConfig.dev() : baseUrl = 'https://seasonal-job-matctching-ff74a4d37cbc.herokuapp.com/api/';
  const AppConfig.dev()
    : baseUrl = 'https://seasonal-job-matching-898a9d15a9e5.herokuapp.com/api/';
  const AppConfig.prod() : baseUrl = 'https://api.example.com/';
}

