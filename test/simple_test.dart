import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_architecture/data/api/posts_api.dart';

class MockHttpProvider extends Mock implements PostsApi {}

void main() {
  test('add', () {
    final result = 2 + 1;
    expect(result, 3);
  });

  test("split", () {
    final string = "a,b,c";
    //expect(string.split(","), ['a', 'b', 'c']);
    expect(string.split(","),
        allOf(
            [
              equals(['a', 'b', 'c']),
              //contains(['a']),
              //isNot(contains([','])),
            ]
        )
    );
  });

  test("fail", () {
    expect(int.parse('X'), throwsFormatException);
  });

  test("catch fails as success", () {
    expect(() => int.parse('X'), throwsFormatException);
  });

  test('net', () async {
    MockHttpProvider().getPosts().then((value) =>
        print("DONE")
    );
  });
}
