import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppk/bloc/add_goal_model/add_goal_bloc.dart';

class MainPhoto extends StatefulWidget {
  String photoAssets;
  Uint8List? bytesList;

  MainPhoto(this.photoAssets, {required this.bytesList});

  @override
  State<MainPhoto> createState() => _MainPhotoState();
}

class _MainPhotoState extends State<MainPhoto> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return InkWell(
        onTap: () async {
          var imagePicker = ImagePicker();
          XFile? image = await imagePicker.pickImage(
              source: ImageSource.gallery,
              imageQuality: 50,
              preferredCameraDevice: CameraDevice.front);
          if (image != null) {
            widget.bytesList = await image.readAsBytes();
            setState(() {});
            BlocProvider.of<AddGoalBloc>(context).add(AddMainPhoto(widget.bytesList!));
          }
        },
        child: Row(
          children: [
            Container(
                height: size.height / 3,
                width: size.width / 1.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/photo_pattern.png'))),
                child: widget.bytesList == null
                    ? Center(
                      child: RotationTransition(
                          turns: AlwaysStoppedAnimation(-4 / 360),
                          child: Container(
                            height: size.height / 4,
                            width: size.width / 2,
                            padding: EdgeInsets.only(bottom: size.height / 50),
                            child: Center(
                                child: Text(
                              'Добавьте\nглавное\nфото',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(color: theme.hoverColor),
                            )),
                          )),
                    )
                    : Center(
                      child: RotationTransition(
                          turns: AlwaysStoppedAnimation(-4 / 360),
                          child: Container(
                              height: size.height / 4,
                              width: size.width / 2,
                              child: Image.memory(widget.bytesList!))),
                    )),
          ],
        ));
  }
}
