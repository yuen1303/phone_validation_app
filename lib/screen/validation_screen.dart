import 'package:flutter/material.dart';
import 'package:phone_validation/stores/phone_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:phone_validation/configuration/theme.dart';
import 'package:phone_validation/configuration/string.dart';

final PhoneStore _phoneStore = PhoneStore();

class ValidationScreen extends StatefulWidget {
  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  @override
  void initState() {
    super.initState();
    _phoneStore.loadJson();
    _phoneStore.loadRecord();
    _phoneStore.loadApiKeys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appTitle)),
      body: SizerUtil.deviceType == DeviceType.Mobile
          ? validationScreen(
              mobileValidationScreenWidth, mobileValidationScreenHeight)
          : Row(
              children: [
                leftScreen(),
                rightScreen(),
              ],
            ),
    );
  }

  void validate() async {
    if (!_phoneStore.isLoading) {
      int status = await _phoneStore.validatePhoneNumber();
      if (status == 404) {
        ///Fail
        showPopupDialog(validationErrorTitle, validationErrorContent,
            popUpDialogueConfirmButton);
      } else {
        ///Success
        if (_phoneStore.isExisted) {
          showPopupDialog(validationExistedTitle, validationExistedContent,
              popUpDialogueConfirmButton);
        } else {
          showPopupDialog(validationSuccessTitle, validationSuccessContent,
              popUpDialogueConfirmButton);
        }
      }
    }
  }

  void showPopupDialog(String title, String content, String actionText) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          PlatformDialogAction(
              child: Text(actionText),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }

  /*Widgets*/

  ///For tablet size
  Expanded rightScreen() {
    return Expanded(
      flex: tabletFlexRightScreenRatio,
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
            color: basicBackground,
            child: Observer(
              builder: (_) => ListView.builder(
                  itemCount: _phoneStore.validatedPhoneNumber.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${_phoneStore.validatedPhoneNumber[index]}'),
                    );
                  }),
            )),
      ),
    );
  }

  ///For tablet size
  Expanded leftScreen() {
    return Expanded(
      flex: tabletFlexLeftScreenRatio,
      child: LayoutBuilder(
          builder: (context, constraints) => validationScreen(
              tabletValidationScreenWidth, tabletValidationScreenHeight)),
    );
  }

  Container loadingPage() {
    return Container(
      color: loadingPageBackgroundColour,
      child: SpinKitRotatingCircle(
        color: loadingIconColour,
        size: loadingIconSize,
      ),
    );
  }

  SizedBox dropdownCountryCode(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: DropDownField(
        enabled: _phoneStore.isLoading ? false : true,
        onValueChanged: (dynamic value) => _phoneStore.setDialCode(value),
        value: _phoneStore.dialCode,
        required: false,
        labelText: diaCodeLabel,
        items: _phoneStore.dialCodeList,
        strict: false,
      ),
    );
  }

  Center validationButton() {
    return Center(
      child: Padding(
        padding: buttonPadding,
        child: SizedBox(
          width: buttonWidthRatio,
          height: buttonHeightRatio,
          child: ElevatedButton(
            onPressed: () => validate(),
            child: Text(validationButtonText),
          ),
        ),
      ),
    );
  }

  SizedBox phoneNumberTextField(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        enabled: _phoneStore.isLoading ? false : true,
        onChanged: (String value) => _phoneStore.setPhoneNumber(value),
        decoration: InputDecoration(
            border: UnderlineInputBorder(), labelText: phoneNumberLabel),
      ),
    );
  }

  Center listButton() {
    return Center(
      child: Padding(
        padding: buttonPadding,
        child: SizedBox(
          width: buttonWidthRatio,
          height: buttonHeightRatio,
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PhoneNumberScreen()));
              },
              child: Text(listButtonText, textAlign: TextAlign.center,)),
        ),
      ),
    );
  }

  Observer validationScreen(double width, double height) {
    return Observer(
      builder: (_) => Stack(children: <Widget>[
        _phoneStore.isLoading ? loadingPage() : Container(),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dropdownCountryCode(width, height),
                  phoneNumberTextField(width, height)
                ],
              ),
              validationButton(),
              SizerUtil.deviceType == DeviceType.Mobile
                  ? listButton()
                  : Container()
            ],
          ),
        ),
      ]),
    );
  }
}

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(validatedListPageAppTitle),
      ),
      body: Observer(
        builder: (_) => ListView.builder(
            itemCount: _phoneStore.validatedPhoneNumber.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${_phoneStore.validatedPhoneNumber[index]}'),
              );
            }),
      ),
    );
  }
}
