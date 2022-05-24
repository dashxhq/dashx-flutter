String identifyAccount(String id) {
  return '''
            mutation{
              identifyAccount(input: {
                anonymousUid:"$id"}) {
                id
                }
                }
                ''';
}

String trackEvent(String id, String event, {required String gameName}) {
  return '''
            mutation {
              trackEvent(input:{
                event: "$event",
                 data: {gameName: "$gameName"}
                 accountAnonymousUid:"$id"}) {
                  id
                  }
                  }
                  ''';
}
