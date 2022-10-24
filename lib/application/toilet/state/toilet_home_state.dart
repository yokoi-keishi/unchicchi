import 'package:unchicchi/application/toilet/dto/toilet_dto.dart';

class ToiletHomeState {
  List<ToiletDto> toilets;
  bool isLoading;

  ToiletHomeState(this.toilets, this.isLoading);

  factory ToiletHomeState.init() => ToiletHomeState([], false);

  ToiletHomeState copyWith({
    List<ToiletDto>? toilets,
    bool? isLoading,
  }) {
    return ToiletHomeState(
      toilets ?? this.toilets,
      isLoading ?? this.isLoading,
    );
  }
}
