import 'package:flutter/material.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show Constants, CustomIconButtonWidget, CustomTextWidget, Helpers;
import 'package:visual_notes/app/features/error/error_exports.dart'
    show
        NotFoundSubTitleWidget,
        NotFoundSupportAccountWidget,
        NotFoundTitleWidget;

class ErrorNotFoundScreen extends StatelessWidget {
  const ErrorNotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Helpers.backNavigationToSpecificScreen();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: CustomIconButtonWidget(
            btnPressed: () => Helpers.backNavigationToSpecificScreen(),
            materialIcon: Icons.arrow_back_ios_new,
            materialIconColor: Colors.white,
            materialIconSize: 20.0,
          ),
          centerTitle: true,
          title: const CustomTextWidget(
            "Page",
            fontColor: Colors.white,
            fontSize: 20,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.semiLargePadding,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                NotFoundTitleWidget(),
                Constants.verticalSpaceSmall,
                NotFoundSubTitleWidget(),
                Constants.verticalSpaceMedium,
                NotFoundSupportAccountWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
