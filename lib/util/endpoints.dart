class Endpoints {
  static const host = 'https://msketchup.azurewebsites.net/';
  static final klogin = '${Endpoints.host}ketchup/authenticate';
  static final kgetAllCategories = '${Endpoints.host}categories/';
  static final kgetAllEvents = '${Endpoints.host}events/';
  static Function kgetUserCategories = (dynamic userId) {
    return '${Endpoints.host}users/$userId/categories/';
  };

  static Function kgetUserEvents = (dynamic userId) {
    return '${Endpoints.host}events?userId=$userId';
  };

  static Function kgetAllUserUpcomingEvents = (dynamic userId) {
    return 'http://ketchuprequestsfunctions-20200129102746440.azurewebsites.net/api/HttpTrigger-Java?code=HXlNyP13u1ffHaBWKta6m8AxiflCccjXug/h8s9tcXVkBei7QiOlRQ==&userId=$userId';
  };

  static Function kSendCalendarInviteOnEventAcceptance = (dynamic startTime, dynamic endTime, dynamic eventName, dynamic eventDesc, dynamic recipientEmailId, dynamic organizerEmailId) {
return 'http://ketchuprequestsfunctions-20200129102746440.azurewebsites.net/api/SendOutlookInvite-Java?code=BfZBJmpqY/IykovwkqJKRO6yfTkjvIxKFz6cay4ikDNbMSi4gqmwJQ==&startTime=$startTime&endTime=$endTime&eventName=$eventName&eventDesc=$eventDesc&recipientEmailId=$recipientEmailId&organizerEmailId=$organizerEmailId';
  };

  static final kcreateEvent = '${Endpoints.host}events';
}
