import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowPictureBottomSheet {
  static Future openModalBottomSheet({@required BuildContext context}) async {
    final _picker = ImagePicker();

    return await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              height: 180.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ListTile(
                    title: Text('拍摄', textAlign: TextAlign.center, style: TextStyle(color: Color(0xff979797))),
                    onTap: () async {
                      PickedFile imageFile =
                          await _picker.getImage(source: ImageSource.camera, maxHeight: 1920, maxWidth: 1080);
                      Navigator.pop(context, imageFile);
                    },
                  ),
                  ListTile(
                    title: Text('从相册选择', textAlign: TextAlign.center, style: TextStyle(color: Color(0xff979797))),
                    onTap: () async {
                      PickedFile imageFile =
                          await _picker.getImage(source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);
                      Navigator.pop(context, imageFile);
                    },
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Text('取消', textAlign: TextAlign.center, style: TextStyle(color: Color(0xff979797)))),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
