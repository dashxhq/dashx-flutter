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

String trackEvent(String id, String event, Map<String, dynamic> jsonData) {
  return '''
            mutation {
              trackEvent(input:{
                event: "$event",
                 data: $jsonData
                 accountAnonymousUid:"$id"}) {
                  id
                  }
                  }
                  ''';
}

// TODO: configure device token and fix mutation
String setIdentityAccount(String uid, String token) {
  return '''
            mutation
                ''';
}

String subscribeContact(String uid, String deviceToken, String device) {
  return '''
            mutation {
              subscribeContact(input:{
                value: "Subscribed",
                kind: "$device"
                accountAnonymousUid: "$uid"
                }) {
                id
                value
                }
                }
                ''';
}
