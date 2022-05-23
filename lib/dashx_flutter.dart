import 'dart:io';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'dashx_flutter_platform_interface.dart';

class DashXPlugin {
  Future<DashX> get dashX async => await DashXPlatform.instance.getDashX();
}

class DashX {
  final String? publicKey;
  final String? baseUri;
  final String? targetEnvironment;

  DashX({
    required this.publicKey,
    this.baseUri,
    this.targetEnvironment,
  });

  Future<DashX> getDashX() {
    return DashXPlatform.instance.getDashX();
  }

  Future<String> getUuid() async {
    String? uuidValue;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('uuid') != null) {
      uuidValue = prefs.getString('uuid');
    } else {
      uuidValue = const Uuid().v4();
      prefs.setString('uuid', uuidValue);
    }
    return uuidValue!;
  }

  Future<void> identify() async {
    final HttpLink httpLink = HttpLink(baseUri!, defaultHeaders: {
      'content-type': 'application/json',
      'x-target-environment': targetEnvironment!,
      'x-public-key': publicKey!
    });

    /// only uuid is required for identifyAccount
    String identifyAccount(String id) {
      return '''
            mutation{
              identifyAccount(input: {
                anonymousUid:"$id"
              }) {
                id

                }
                }
                ''';
    }

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
        document: gql(identifyAccount('<YOUR_UUID4>')),
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
