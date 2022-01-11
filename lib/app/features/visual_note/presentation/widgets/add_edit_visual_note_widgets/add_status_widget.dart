import 'package:flutter/material.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show
        AppColors,
        Constants,
        CustomRadioButtonWidget,
        CustomTextWidget,
        RadioModel,
        defaultConfiguration;

class AddStatusWidget extends StatefulWidget {
  final void Function(String?) onSelectedStatus;
  final String? defaultStatus;
  const AddStatusWidget({
    Key? key,
    required this.onSelectedStatus,
    required this.defaultStatus,
  }) : super(key: key);

  @override
  State<AddStatusWidget> createState() => _AddStatusWidgetState();
}

class _AddStatusWidgetState extends State<AddStatusWidget> {
  late ValueNotifier<dynamic> _statusValueNotifier;
  late List<RadioModel> _listOfTypes;
  late String _defaultType;

  @override
  void initState() {
    super.initState();
    _listOfTypes = RadioModel.getListOfRadioButtonsFromListOfJsons(
      defaultConfiguration["VisualNoteStatus"],
    );
    _defaultType = widget.defaultStatus ?? _listOfTypes.first.radioGroupValue;
    _statusValueNotifier = ValueNotifier<dynamic>(_defaultType);
  }

  @override
  void dispose() {
    _statusValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            CustomTextWidget("Status", textAlign: TextAlign.start),
            CustomTextWidget(" *", fontColor: AppColors.redBrown),
          ],
        ),
        Constants.verticalSpaceSmall,
        ValueListenableBuilder<dynamic>(
          valueListenable: _statusValueNotifier,
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _listOfTypes
                  .map(
                    (type) => CustomRadioButtonWidget(
                      radioValue: type.radioValue,
                      radioGroupValue: value,
                      title: type.titleKey,
                      onSelected: (status) => _pickStatus(status, value),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  void _pickStatus(dynamic currStatus, dynamic prevValue) {
    if (currStatus == prevValue) {
      _statusValueNotifier.value = "";
      widget.onSelectedStatus(null);
    } else {
      _statusValueNotifier.value = currStatus;
      widget.onSelectedStatus(currStatus);
    }
  }
}
