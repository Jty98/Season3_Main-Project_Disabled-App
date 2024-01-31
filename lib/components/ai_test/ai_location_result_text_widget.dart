import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../vm/ai_test/ai_address_controller.dart';

class AiLocationResultTextWidget extends StatelessWidget {
  const AiLocationResultTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      builder: (controller) {
    // String adress1 = controller.addressResult ?? controller.userData!.address;
    // String adress2 = controller.subAddressResult ?? controller.userData!.address;
    // String adress3 = controller.subAddresses1Result ?? controller.userData!.address;
        return Center(
          child: Text(
            "${controller.addresses} ${controller.subAddresses} ${controller.subAddresses1}",
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
