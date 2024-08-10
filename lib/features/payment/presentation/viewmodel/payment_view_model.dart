import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/features/payment/domain/entity/payment_entity.dart';
import 'package:final_assignment/features/payment/domain/usecases/payment_usecase.dart';
import 'package:final_assignment/features/payment/presentation/navigator/payment_navigator.dart';
import 'package:final_assignment/features/payment/presentation/state/payment_state.dart';
import 'package:final_assignment/features/pet/domain/usecases/pet_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentViewModelProvider =
    StateNotifierProvider<PaymentViewModel, PaymentState>((ref) {
  return PaymentViewModel(
    ref.read(paymentUsecaseProvider),
    ref.read(petUseCaseProvider),
    ref.read(paymentNavigatorProvider),
  );
});

class PaymentViewModel extends StateNotifier<PaymentState> {
  PaymentViewModel(this._paymentUsecase, this.petUseCase, this.navigator)
      : super(PaymentState.initial());

  final PaymentUsecase _paymentUsecase;
  final PetUseCase petUseCase;
  final PaymentViewNavigator navigator;

  Future<void> getPet(String id) async {
    state = state.copyWith(isLoading: true);
    final result = await petUseCase.getPetById(id);
    result.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
      showMySnackBar(message: l.error);
    }, (r) {
      state = state.copyWith(isLoading: false, petEntity: r, error: null);
    });
  }

  Future<void> createPayment(PaymentEntity entity) async {
    state = state.copyWith(isLoading: true);
    final result = await _paymentUsecase.createPayment(entity);
    result.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
      showMySnackBar(message: l.error);
    }, (r) {
      state = state.copyWith(isLoading: false, paymentEntity: r, error: null);
      if (r.paymentMethod == 'khalti') {
        initiateKhaltiPayment(r);
      } else {
        showMySnackBar(message: 'Payment Successful');
      }
    });
  }

  Future<void> initiateKhaltiPayment(PaymentEntity entity) async {
    state = state.copyWith(isLoading: true);
    final result = await _paymentUsecase.initiateKhaltiPayment(entity);
    result.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
      showMySnackBar(message: l.error);
    }, (r) {
      state = state.copyWith(isLoading: false, error: null);
      openKhaltiView(r);
    });
  }

  void changePaymentMethod(String method) {
    state = state.copyWith(paymentMethod: method);
  }

  void openKhaltiView(String pidx) {
    navigator.openKhaltiView(pidx);
  }
}
