import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_button.dart';
import 'package:themar/core/design/widget/app_input.dart';
import 'package:themar/core/design/widget/auth_body.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/feature/cities/view.dart';
import 'package:themar/feature/phone_input/view.dart';
import 'package:themar/view/auth/login/view.dart';
import 'package:themar/view/auth/register/bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: AuthBody(
          widgetForm: Builder(
            builder: (context) {
              RegisterBloc bloc = BlocProvider.of<RegisterBloc>(context);
              return Form(
                key: bloc.formKey,
                child: Column(
                  children: [
                    //user name
                    AppInput(
                      autofillHints: const [AutofillHints.name],
                      label: DataString.name,
                      image: DataAssets.iconUser,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return DataString.empty(DataString.name);
                        }
                        return null;
                      },
                      controller: bloc.nameController,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),
                    //phone
                    PhoneInput(bloc.phoneController),
                    const SizedBox(height: 16),
                    //city
                    StatefulBuilder(
                      builder: (context, setState) => GestureDetector(
                        onTap: () async {
                          print(bloc.nameController.text);
                          final result = await showModalBottomSheet(
                            context: context,
                            builder: (context) => const CitiesSheet(),
                          );
                          print("result ${result?.name}");
                          if (result != null) {
                            bloc.selectedCity = result;
                            setState(() {});

                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: AbsorbPointer(
                                absorbing: true,
                                child: AppInput(
                                  isEnable: false,
                                  label: bloc.selectedCity?.name ??
                                      DataString.country,
                                  image: DataAssets.iconFlag,
                                  validator: (String? value) {
                                    if (bloc.selectedCity == null) {
                                      return DataString.empty(DataString.country);
                                    }
                                    return null;
                                  },
                                  controller: null,
                                ),
                              ),
                            ),
                            if (bloc.selectedCity != null)
                              IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  size: 24,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  bloc.selectedCity = null;
                                  setState(() {});
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    //password
                    AppInput(
                      autofillHints: const [AutofillHints.password],
                      label: DataString.password,
                      image: DataAssets.iconPassword,
                      isPassword: true,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return DataString.empty(DataString.password);
                        }
                        if (value!.length < 7) {
                          return DataString.passwordError;
                        }

                        return null;
                      },
                      controller: bloc.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 16),
                    //rePassword
                    AppInput(
                      autofillHints: const [AutofillHints.password],
                      label: DataString.password,
                      image: DataAssets.iconPassword,
                      isPassword: true,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return DataString.empty(DataString.password);
                        }
                        if (value != bloc.passwordController.text) {
                          return DataString.rePasswordError;
                        }

                        return null;
                      },
                      controller: bloc.rePasswordController,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 20),
                    //register button
                    BlocBuilder(
                      bloc: bloc,
                      builder: (BuildContext context, state) => SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          text: DataString.register,
                          onPressed: () {
                            bloc.add(RegisterEvent());
                          },
                          isLoading: state is RegisterLoadingState,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
          title: DataString.welcomeLoginTittle,
          subTitle: DataString.welcomeSubRegisterTittle,
          onPress: () {
            navigateTo(const LoginView());
          },

        ),

      ),
    );
  }
}
