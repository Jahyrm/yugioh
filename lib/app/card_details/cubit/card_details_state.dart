part of 'card_details_cubit.dart';

class CardDetailsState extends Equatable {
  const CardDetailsState({
    this.loading = true,
    this.frenchName,
    this.germanName,
  });

  final bool loading;
  final String? frenchName;
  final String? germanName;

  @override
  List<Object?> get props => [
        loading,
        frenchName,
        germanName,
      ];

  CardDetailsState copyWith({
    bool? loading,
    String? frenchName,
    String? germanName,
  }) {
    return CardDetailsState(
      loading: loading ?? this.loading,
      frenchName: frenchName ?? this.frenchName,
      germanName: germanName ?? this.germanName,
    );
  }
}
