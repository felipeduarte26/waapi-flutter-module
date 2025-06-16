import 'package:equatable/equatable.dart';

class GetShortUrlState extends Equatable {
  const GetShortUrlState();

  @override
  List<Object> get props => [];
}

final class InitialGetShortUrlState extends GetShortUrlState {}

final class LoadingGetShortUrlState extends GetShortUrlState {}

final class SuccessGetShortUrlState extends GetShortUrlState {
  final Map<String, String> mapUrlShorterner;

  const SuccessGetShortUrlState({
    required this.mapUrlShorterner,
  });

  @override
  List<Object> get props => [
        mapUrlShorterner,
      ];
}

class ErrorGetShortUrlState extends GetShortUrlState {}

class SaveDontShowMessageShortenLinkState extends GetShortUrlState {}

class ShowMessageShortenLinksState extends GetShortUrlState {
  final bool showMessageShortenLinks;

  const ShowMessageShortenLinksState({
    required this.showMessageShortenLinks,
  });

  @override
  List<Object> get props {
    return [
      showMessageShortenLinks,
    ];
  }
}
