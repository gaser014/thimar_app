import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/views/auth/auth_body.dart';

import '../../../core/design/unit/app_string.dart';
import '../../../core/design/widget/app_button.dart';
import '../../../core/design/widget/app_input.dart';
import '../../../core/logic/get_it.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../features/auth/cities/model.dart';
import '../../../features/auth/register/bloc.dart';
import '../cities/view.dart';
import '../confirm_code/view.dart';
import '../login/view.dart';
import '../phone_input/view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final RegisterBloc bloc;
  CitiesModel? selectedCity;
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  @override
  void initState() {
    bloc = getIt<RegisterBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AuthBody(
          widgetForm: Form(
            key: formKey,
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
                  controller: nameController,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                //phone
                PhoneInput(phoneController: phoneController),
                SizedBox(height: 16.h),
                //city
                GestureDetector(
                  onTap: () async {
                    debugPrint(nameController.text);
                    final result = await showModalBottomSheet(
                      context: context,
                      builder: (context) => const CitiesSheet(),
                    );
                    debugPrint("result ${result?.name}");
                    if (result != null) {
                      selectedCity = result;
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
                            label: selectedCity?.name ?? DataString.country,
                            image: DataAssets.iconFlag,
                            validator: (String? value) {
                              if (selectedCity == null) {
                                return DataString.empty(DataString.country);
                              }
                              return null;
                            },
                            controller: null,
                          ),
                        ),
                      ),
                      if (selectedCity != null)
                        IconButton(
                          icon: Icon(
                            Icons.clear,
                            size: 24.sp,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            selectedCity = null;
                            setState(() {});
                          },
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
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
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 16.h),
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
                    if (value != passwordController.text) {
                      return DataString.rePasswordError;
                    }

                    return null;
                  },
                  controller: rePasswordController,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 20.h),
                //register button
                BlocConsumer(
                  listener: (context, state) {
                    if (state is RegisterSuccessState) {
                      navigateTo(
                          ConfirmCodeView(
                            phone: state.phone,
                            isActive: state.isActivated,
                          ),
                          removeHistory: true);
                    }
                  },
                  bloc: bloc,
                  builder: (BuildContext context, state) => SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      text: DataString.register,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          bloc.add(RegisterEvent(
                            phone: phoneController.text,
                            selectedCity: selectedCity,
                            name: nameController.text,
                            password: passwordController.text,
                            rePassword: rePasswordController.text,
                          ));
                        }
                      },
                      isLoading: state is RegisterLoadingState,
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: DataString.welcomeLoginTittle,
          subTitle: DataString.welcomeSubRegisterTittle,
          onPress: () {
            navigateTo(const LoginView(), removeHistory: true);
          },
        ),
      ),
    );
  }
}
