import 'i_travel_details_state.dart';

class TravelDetailsError implements ITravelDetailsState {
  final String message;

  TravelDetailsError({required this.message});
}
