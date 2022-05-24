
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

String trackEventClick(String id) {
  return '''
            mutation {
              trackEvent(input:{
                event: "Clicked Button",
                 data: {gameName: "Tetris"}
                 accountAnonymousUid:"$id"}) {
                  id
                  }
                  }
                  ''';
}


