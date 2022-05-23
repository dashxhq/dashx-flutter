import 'dart:io';

import 'package:graphql/client.dart';
import 'package:path_provider/path_provider.dart';

import 'dashx_flutter_platform_interface.dart';

class DashXPlugin {
  Future<DashX> get dashX async => await DashXPlatform.instance.getDashX();
}

class DashX {
  final String? baseUri;
  final String? publicKey;
  final String? targetEnvironment;

  DashX({
    required this.baseUri,
    required this.publicKey,
    required this.targetEnvironment,
  });

  Future<DashX> getDashX() {
    return DashXPlatform.instance.getDashX();
  }

  Future<void> identify() async {
    final HttpLink httpLink = HttpLink(baseUri!, defaultHeaders: {
      'content-type': 'application/json',
      'x-target-environment': targetEnvironment!,
      'x-public-key': publicKey!
    });

    String identifyAccount(String id, String email) {
      return '''
            mutation{
              identifyAccount(input: {
                anonymousUid:"$id",
                email: "$email"
              }) {
                id
                email
                }
                }
                ''';
    }

    /// get temorary directory for hive to store data
    Directory tempDir = await getTemporaryDirectory();

    /// initialize Hive and wrap the default box in a HiveStore
    HiveStore.init(onPath: tempDir.path);
    final store = await HiveStore.open(path: tempDir.path);

    ///initializing GraphQLConfig
    GraphQLClient _client =
        GraphQLClient(link: httpLink, cache: GraphQLCache(store: store));
    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(identifyAccount('<YOUR_UUID4>', '<YOUR_EMAIL>')),
      ),
    );
    if (result.hasException) {
      print(result.exception?.graphqlErrors[0].message);
    } else if (result.data != null) {
      print(result.data);

      ///  parse your response here
    }
  }

  Future<void> update() async {}
}
