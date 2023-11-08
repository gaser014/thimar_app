part of 'bloc.dart';
class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {




  @override
  Widget build(BuildContext context) {
final bloc= BlocProvider.of<RegisterBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: AuthBody(
          widgetForm: Form(
            key: bloc._formKey,
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
                  controller: bloc._nameController,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                //phone
                PhoneInput(bloc._phoneController),
                SizedBox(height: 16.h),
                //city
                StatefulBuilder(
                  builder: (context, setState) => GestureDetector(
                    onTap: () async {
                      print(bloc._nameController.text);
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
                            icon:  Icon(
                              Icons.clear,
                              size: 24.sp,
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
                  controller: bloc._passwordController,
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
                    if (value != bloc._passwordController.text) {
                      return DataString.rePasswordError;
                    }

                    return null;
                  },
                  controller: bloc.rePasswordController,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 20.h),
                //register button
                BlocBuilder(
                  bloc: bloc,
                  builder: (BuildContext context, state) => SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      text: DataString.register,
                      onPressed: () {
                        bloc.add(RegisterEvent());
                        if (state is RegisterSuccessState)
                        {
                          print("success");
                          dispose();
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
            navigateTo(const LoginView());


          },

        ),

      ),
    );
  }
}
