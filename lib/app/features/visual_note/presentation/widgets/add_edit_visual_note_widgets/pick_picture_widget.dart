import 'dart:convert';
import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show AppColors, Constants, CustomTextWidget;

class PickPictureWidget extends StatefulWidget {
  final String? defaultPicture;
  final void Function(String?) onSelectedPicture;
  const PickPictureWidget({
    Key? key,
    required this.onSelectedPicture,
    required this.defaultPicture,
  }) : super(key: key);

  @override
  State<PickPictureWidget> createState() => _PickPictureWidgetState();
}

class _PickPictureWidgetState extends State<PickPictureWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  File? _selectedImage;
  late ImagePicker _picker;

  late ValueNotifier<Map<String, dynamic>> _dataValueNotifier;

  late String _selectedImageKey;
  late Map<String, dynamic> _defaultData;

  @override
  void initState() {
    _selectedImageKey = "selected-image";
    _defaultData = {
      Constants.visualNotePictureKey: widget.defaultPicture,
      _selectedImageKey: _selectedImage,
    };
    _picker = ImagePicker();
    _dataValueNotifier = ValueNotifier<Map<String, dynamic>>(_defaultData);
    super.initState();
  }

  @override
  void dispose() {
    _dataValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder<Map<String, dynamic>>(
      valueListenable: _dataValueNotifier,
      builder: (context, value, child) {
        final defaultPic = value[Constants.visualNotePictureKey];
        final selectedPic = value[_selectedImageKey];
        return GestureDetector(
          onTap: () =>
              // show bottom navigation bar to let user choose what he needs
              _showPicker(context, (defaultPic != null || selectedPic != null)),
          child: CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.facegraphColor,
            child: defaultPic == null && selectedPic == null
                ? const _PlaceholderPictureWidget()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: defaultPic != null
                        ? Image.memory(
                            // decode image if comes to edit to show previous image
                            base64Decode(defaultPic),
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            // show selected image
                            selectedPic,
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                  ),
          ),
        );
      },
    );
  }

  _imgFromCamera() async {
    // pick image from camera
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    // if user doesn't select image, then image will be null
    if (image != null) {
      // pass File with path to show image
      _defaultData[_selectedImageKey] = File(image.path);
      // make default image null, to show selected image
      _defaultData[Constants.visualNotePictureKey] = null;
      _dataValueNotifier.value = _defaultData;
      // return value
      widget.onSelectedPicture(image.path);
    }
  }

  _imgFromGallery() async {
    // pick image from gallery
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      _defaultData[_selectedImageKey] = File(image.path);
      _defaultData[Constants.visualNotePictureKey] = null;
      _dataValueNotifier.value = _defaultData;
      // return value
      widget.onSelectedPicture(image.path);
    }
  }

  void _showPicker(context, bool isPictureExist) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              // remove image
              if (isPictureExist)
                Container(
                  color: AppColors.redBrown,
                  child: ListTile(
                    leading:
                        const Icon(Icons.delete_forever, color: Colors.white),
                    title: const CustomTextWidget(
                      "Remove",
                      fontColor: Colors.white,
                    ),
                    onTap: () {
                      // pass null to notifier, we indicate that null means no image to show
                      _defaultData[_selectedImageKey] = null;
                      _defaultData[Constants.visualNotePictureKey] = null;
                      _dataValueNotifier.value = _defaultData;
                      // return value
                      widget.onSelectedPicture(null);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              // from gallery
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const CustomTextWidget('Photo Library'),
                  onTap: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  }),
              // from camera
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const CustomTextWidget("Camera"),
                onTap: () {
                  _imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// placeholder if image not selected or no default image
class _PlaceholderPictureWidget extends StatelessWidget {
  const _PlaceholderPictureWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(60),
      ),
      width: 110,
      height: 110,
      child: Icon(
        Icons.camera_alt,
        color: Colors.grey[800],
      ),
    );
  }
}
