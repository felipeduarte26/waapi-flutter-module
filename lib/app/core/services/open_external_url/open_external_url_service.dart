/// This interface describes all the methods necessary to work with communication with external apps
///
abstract class OpenExternalUrlService {
  Future<bool> openUrl({
    required String externalUrl,
  });
}
