import 'dart:io';

String fixture(String name) => File('test/weather/$name').readAsStringSync();
