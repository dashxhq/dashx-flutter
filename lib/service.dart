import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:graphql/client.dart';

void getRequest(String targetEnvironment, String publicKey, String baseUri,
    String doc) async {
  final HttpLink httpLink = HttpLink(baseUri, defaultHeaders: {
    'content-type': 'application/json',
    'x-target-environment': targetEnvironment,
    'x-public-key': publicKey
  });

  /// get temorary directory for hive to store data
  Directory tempDir = Directory.systemTemp;

  /// initialize Hive and wrap the default box in a HiveStore
  HiveStore.init(onPath: tempDir.path);
  final store = await HiveStore.open(path: tempDir.path);

  ///initializing GraphQLConfig
  GraphQLClient client =
      GraphQLClient(link: httpLink, cache: GraphQLCache(store: store));
  QueryResult result = await client.mutate(
    MutationOptions(
      document: gql(doc),
    ),
  );
  if (result.hasException) {
    debugPrint(result.exception?.graphqlErrors[0].message);
  } else if (result.data != null) {
    debugPrint("data: ${result.data}");
  }
}
