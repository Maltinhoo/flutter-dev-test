import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/app_imports.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocProvider(
          create: (context) => ServiceLocator.locator<LoginCubit>(),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              BotToast.closeAllLoading();
              if (state is LoginLoading) {
                BotToast.showLoading();
              } else if (state is LoginSuccess) {
                context.go(HomePage.route);
              } else if (state is LoginUnauthorized) {
                CustomSnackBar.show(
                  context,
                  content: const CustomText(
                    'Credenciais inválidas',
                    color: Colors.white,
                  ),
                );
              } else if (state is LoginTOTPInvalid) {
                context.push(
                  RecoverySecretPage.route,
                  extra: {
                    'email': emailController.text,
                    'password': passwordController.text,
                  },
                );
              } else if (state is LoginError) {
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
              final cubit = BlocProvider.of<LoginCubit>(context);
              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .1),
                  children: [
                    const LoginImage(),
                    const Gap(37),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          CustomTextField(
                            hint: 'E-mail',
                            focusNode: emailFocus,
                            controller: emailController,
                            onFieldSubmitted: (p0) {
                              passwordFocus.requestFocus();
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                          ),
                          const Gap(10),
                          CustomPasswordField(
                            hint: 'Senha',
                            focusNode: passwordFocus,
                            controller: passwordController,
                            onFieldSubmitted: (p0) {
                              if (_formKey.currentState!.validate()) {
                                cubit.onLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          const Gap(20),
                          CustomButton(
                            onTap: () {
                              cubit.onLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            },
                            width: MediaQuery.of(context).size.width,
                            label: 'Entrar',
                          ),
                          Gap(MediaQuery.of(context).size.height * .2),
                          TextButton(
                            onPressed: () {},
                            child: const CustomText(
                              'Esqueci a senha',
                              color: Color(0xff7A5D3E),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
