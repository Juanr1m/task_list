import 'package:aliftech_test/repositories/repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void locatorSetUp() {
  locator.registerSingleton(DataRepository());
}
