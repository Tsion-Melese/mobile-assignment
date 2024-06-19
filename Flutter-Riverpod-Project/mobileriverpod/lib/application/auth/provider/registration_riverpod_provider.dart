import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/infrastructure/auth/data_provider/registration_data_provider.dart';
import 'package:mobileriverpod/domain/auth/model/registration_model.dart';
import 'package:mobileriverpod/infrastructure/auth/repository/registration_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataProvider = ref.watch(authDataProviderProvider);
  return AuthRepository(dataProvider: dataProvider);
});

final authDataProviderProvider = Provider<AuthDataProvider>((ref) {
  return AuthDataProvider();
});

final registrationDataNotifierProvider =
    StateNotifierProvider<RegistrationDataNotifier, RegistrationData>((ref) {
  return RegistrationDataNotifier();
});

class RegistrationDataNotifier extends StateNotifier<RegistrationData> {
  RegistrationDataNotifier() : super(RegistrationData.empty());

  void updateData(RegistrationData newData) {
    state = newData;
  }

  
}
