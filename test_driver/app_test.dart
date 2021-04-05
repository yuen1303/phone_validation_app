import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Phone Validation', () {
    final emptyPhoneNumberFinder = find.text("Phone number should be filled!");
    final phoneNumberInput = find.byValueKey('phoneNumberInput');
    final validationErrorFinder = find.text("Validation Error");
    final validationSuccessFinder = find.text("Validation Success");
    final validationDuplicated = find.text("Number Validated!");
    final okFinder = find.text('ok');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Empty Phone Number', () async {
      await driver.tap(find.text('Validate'));
      await driver.waitFor(emptyPhoneNumberFinder);
    });

    test('Enter Invalid Numbers', () async {
      await driver.tap(phoneNumberInput);
      await driver.enterText('00000000');
      await driver.tap(find.text('Validate'));
      await driver.waitFor(validationErrorFinder);
      await driver.tap(okFinder);
    });

    test('Enter Valid Numbers', () async {
      await driver.tap(phoneNumberInput);
      await driver.enterText('21800000');
      await driver.tap(find.text('Validate'));
      await driver.waitFor(validationSuccessFinder);
      await driver.tap(okFinder);
    });

    test('Enter Duplicate Numbers', () async {
      await driver.tap(phoneNumberInput);
      await driver.enterText('21800000');
      await driver.tap(find.text('Validate'));
      await driver.waitFor(validationDuplicated);
      await driver.tap(okFinder);
    });

    test('Check History', () async {
      await driver.tap(find.text("list of saved numbers"));
      await driver.tap(find.text('21800000'));
    });



  });
}
