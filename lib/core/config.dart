class AppConfig {
  final String baseUrl;

  const AppConfig({required this.baseUrl});

  const AppConfig.dev() : baseUrl = 'http://192.168.1.44:3000/';
  const AppConfig.prod() : baseUrl = 'https://api.example.com/';
}


