import 'package:unchicchi/application/toilet/dto/toilet_dto.dart';

class ToiletSummaryState {
  List<ToiletDto> toilets;
  bool isLoading;

  ToiletSummaryState(this.toilets, this.isLoading);

  factory ToiletSummaryState.init() => ToiletSummaryState([], false);

  ToiletSummaryState copyWith({
    List<ToiletDto>? toilets,
    bool? isLoading,
  }) {
    return ToiletSummaryState(
      toilets ?? this.toilets,
      isLoading ?? this.isLoading,
    );
  }
}
