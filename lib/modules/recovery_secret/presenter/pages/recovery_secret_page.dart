import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/app_imports.dart';

class RecoverySecretPage extends StatefulWidget {
  static const String route = '/recoverySecret';
  final String email, password;
  const RecoverySecretPage(
      {super.key, required this.email, required this.password});

  @override
  State<RecoverySecretPage> createState() => _RecoverySecretPageState();
}

class _RecoverySecretPageState extends State<RecoverySecretPage> {
  late final TextEditingController pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => ServiceLocator.locator<RecoverySecretCubit>(),
        child: BlocConsumer<RecoverySecretCubit, RecoverySecretState>(
          listener: (context, state) {
            BotToast.closeAllLoading();
            if (state is RecoverySecretLoading) {
              BotToast.showLoading();
            } else if (state is RecoverySecretSuccess) {
              context.go(LoginPage.route);
            } else if (state is RecoverySecretError) {
              CustomSnackBar.show(
                context,
                content: CustomText(
                  state.error,
                  color: Colors.white,
                ),
              );
            }
          },
          builder: (context, state) {
            final recoveryCubit = BlocProvider.of<RecoverySecretCubit>(context);
            return Scaffold(
              body: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(14),
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20,
                          color: Color(0xff7A5D3E),
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                'Verificação',
                                size: 20,
                                color: Color(0xff212229),
                              ),
                              const Gap(5),
                              const CustomText(
                                'Insira o código que foi enviado:',
                                size: 14,
                                color: Color(0xff9496AA),
                              ),
                              const Gap(73),
                              Pinput(
                                onCompleted: (value) {
                                  recoveryCubit.onRecoverySecret(
                                    email: widget.email,
                                    password: widget.password,
                                    code: value,
                                  );
                                },
                                controller: pinController,
                                length: 6,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                followingPinTheme: PinTheme(
                                  height: 52,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff6f6f8),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: const Color(0xffe7e7ef)),
                                  ),
                                ),
                                cursor: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 1,
                                      height: 22,
                                      color: const Color(0xff7a5d3e),
                                    ),
                                  ],
                                ),
                                focusedPinTheme: PinTheme(
                                  height: 52,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: const Color(0xff7A5D3E)),
                                  ),
                                ),
                                submittedPinTheme: PinTheme(
                                  height: 52,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: const Color(0xff7A5D3E)),
                                  ),
                                ),
                              ),
                              const Gap(32),
                              CustomButton(
                                enabled: pinController.text.length >= 6,
                                onTap: () {
                                  recoveryCubit.onRecoverySecret(
                                    email: widget.email,
                                    password: widget.password,
                                    code: pinController.text,
                                  );
                                },
                                width: MediaQuery.of(context).size.width,
                                label: 'Confirmar',
                              ),
                              const Gap(40),
                              Center(
                                child: InkWell(
                                  onTap: () {},
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Vector(Vectors.message_question),
                                      Gap(8),
                                      CustomText(
                                        'Não recebi o código',
                                        size: 14,
                                        color: Color(0xff494A57),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
