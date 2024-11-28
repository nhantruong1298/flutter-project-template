abstract class ServiceConfigProvider {
  //* Auth0 config

  final String apiEndPoint;
  final String environment;
  final String webUrl;

  const ServiceConfigProvider({
    required this.apiEndPoint,
    required this.environment,
    required this.webUrl,
  });
}
