// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:season3_team1_mainproject/components/logopic.dart';
import 'package:season3_team1_mainproject/model/genderModel.dart';
import 'package:kpostal/kpostal.dart';
import 'package:season3_team1_mainproject/util/agreement.dart';
import 'package:season3_team1_mainproject/util/regex.dart';

import '../../components/agreementViewWidget.dart';
import '../../model/disabledModel.dart';
import '../../vm/registerCtrl.dart';

class RegisterUser extends StatelessWidget {
  RegisterUser({super.key});
  final RegisterationController registerationController =
      Get.put(RegisterationController());

  DateTime selectedDate = DateTime.now();
  XFile? pick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const LogoPic(isappbar: false),
                  const Text("회원 가입"),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: registerationController.registerFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: registerationController.idController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'ID',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '내용을 적어주세요.';
                              }
                              if (!RegexForm.idpwRegExp.hasMatch(value)) {
                                return '영어 소문자와 숫자로만 이루어진 10글자 이하로 입력 가능합니다.';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller:
                                registerationController.passwordController,
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: '비밀번호',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '내용을 적어주세요.';
                              }
                              if (!RegexForm.idpwRegExp.hasMatch(value)) {
                                return '영어 소문자와 숫자로만 이루어진 10글자 이하로 입력 가능합니다.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: registerationController.nameController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: '이름',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '내용을 적어주세요.';
                              }
                              if (!RegexForm.nameRegExp.hasMatch(value)) {
                                return '한글로만 이루어진 2글자 이상으로 입력 가능합니다.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            controller: registerationController.emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: '이메일',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '내용을 적어주세요.';
                              }
                              if (!RegexForm.emailRegExp.hasMatch(value)) {
                                return '올바른 이메일 주소를 입력해주세요.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: registerationController.phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                labelText: '핸드폰', hintText: "'-'없이 입력하세요!"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '내용을 적어주세요.';
                              }
                              if (!RegexForm.phoneRegExp.hasMatch(value)) {
                                return '11자리의 숫자로만 이루어진 핸드폰 번호를 입력해주세요.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h),
                          Obx(
                            () => TextField(
                              onTap: () async {
                                showGenderPicker(context);
                              },
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration: InputDecoration(
                                labelText: '성별',
                                hintText: registerationController
                                            .selectedgender.value !=
                                        null
                                    ? registerationController
                                        .selectedgender.value!.name
                                    : '누르시면 입력 가능합니다.',
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Obx(
                            () => TextFormField(
                              onTap: () async {
                                showBirthPicker(context);
                              },
                              controller:
                                  registerationController.birthController,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: '생년월일',
                                hintText: registerationController
                                            .selectedBirth.value !=
                                        null
                                    ? "${registerationController.selectedBirth.value?.year.toString()}-${registerationController.selectedBirth.value?.month.toString()}-${registerationController.selectedBirth.value?.day.toString()}"
                                    : '누르시면 입력 가능합니다.',
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Obx(
                            () => TextField(
                              onTap: () async {
                                showDisabilityPicker(context);
                              },
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration: InputDecoration(
                                  labelText: '장애유형선택',
                                  hintText: registerationController
                                              .selectedDisability.value !=
                                          null
                                      ? registerationController
                                          .selectedDisability.value!.name
                                      : '누르시면 입력 가능합니다.'),
                            ),
                          ),
                          TextFormField(
                            onTap: () {
                              Get.to(
                                KpostalView(
                                  callback: (Kpostal result) {
                                    print(result.address);
                                    print(
                                        "경도: ${result.latitude} 위도: ${result.longitude}");
                                    registerationController.setAddress(
                                        result.address,
                                        result.latitude!,
                                        result.longitude!); // 주소를 설정
                                  },
                                ),
                              );
                            },
                            readOnly: true,
                            controller:
                                registerationController.addressController,
                            decoration: const InputDecoration(
                              labelText: '주소',
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("프로필 사진 설정"),
                              ElevatedButton(
                                  onPressed: () {
                                    registerationController.pick.value =
                                        imagePicker();
                                  },
                                  child: const Text("사진 선택"))
                            ],
                          ),
                          registerationController.pick.value == null
                              ? SizedBox(
                                  height: 200.h,
                                  child: CircleAvatar(
                                      radius: 100.h,
                                      backgroundImage: const AssetImage(
                                          "assets/images/user.png")),
                                )
                              : SizedBox(
                                  height: 200.h,
                                  child: CircleAvatar(
                                    radius: 100.h,
                                    backgroundImage: FileImage(File(
                                        registerationController
                                            .pick.value!.path)),
                                  ),
                                ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '개인정보 수집동의',
                                style: TextStyle(fontFamily: "NotoSansKR-Bold"),
                              ),
                              Obx(
                                () => Checkbox(
                                  value:
                                      registerationController.isConsentCollect,
                                  onChanged: (newValue) {
                                    registerationController
                                        .toggleConsentCollect(
                                            newValue ?? false);
                                  },
                                ),
                              ),
                            ],
                          ),
                          AgreementViewWidget(
                              agreement: agreement.personalCollection),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '개인정보 처리 동의',
                                style: TextStyle(fontFamily: "NotoSansKR-Bold"),
                              ),
                              Obx(
                                () => Checkbox(
                                  value:
                                      registerationController.isConsentProcess,
                                  onChanged: (newValue) {
                                    registerationController
                                        .toggleConsentProcess(
                                            newValue ?? false);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          AgreementViewWidget(
                              agreement: agreement.personalUseage),
                          SizedBox(height: 20.h),
                          ElevatedButton(
                            onPressed: () {
                              registerationController.onSaved();
                            },
                            child: const Text('회원가입'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 사진 업로드 하기 선택하면
  imagePicker() async {
    pick = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(pick);
    return pick;
  }

  Future<void> showDisabilityPicker(BuildContext context) async {
    double pickerItemHeight = 40.0;
    int itemCount = 10;

    double pickerHeight = pickerItemHeight * itemCount + 200;
    if (pickerHeight > MediaQuery.of(context).size.height * 0.3) {
      pickerHeight = MediaQuery.of(context).size.height * 0.3;
    }
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: pickerHeight,
          child: CupertinoPicker(
            itemExtent: pickerItemHeight,
            onSelectedItemChanged: (index) {
              registerationController
                  .setSelectedDisability(disabilities[index]);
            },
            children: disabilities
                .map((disability) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(disability.name),
                      ],
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  Future<void> showGenderPicker(BuildContext context) async {
    double pickerItemHeight = 40.0;
    int itemCount = 2;

    double pickerHeight = pickerItemHeight * itemCount + 200;
    if (pickerHeight > MediaQuery.of(context).size.height * 0.3) {
      pickerHeight = MediaQuery.of(context).size.height * 0.3;
    }

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: pickerHeight,
          child: CupertinoPicker(
            itemExtent: pickerItemHeight,
            onSelectedItemChanged: (index) {
              registerationController.setSelectedGender(genders[index]);
            },
            children: genders
                .map((gender) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(gender.name),
                      ],
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  Future<void> showBirthPicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: selectedDate,
            onDateTimeChanged: (DateTime newDate) {
              selectedDate = newDate; // Update the selected date
              registerationController.setBirthDate(selectedDate);
            },
          ),
        );
      },
    );
  }
}
