class Endpoints {
  static const host = 'https://msketchup.azurewebsites.net/';
  static final klogin = '${Endpoints.host}ketchup/authenticate';
  static final kgetAllCategories = '${Endpoints.host}categories/';
  static final kgetAllEvents = '${Endpoints.host}events/';
  static final kgetEventMessages = (dynamic eventId) {
    return '${Endpoints.host}messages/$eventId';
  };
  static Function kgetUserCategories = (dynamic userId) {
    return '${Endpoints.host}users/$userId/categories/';
  };

  static Function kgetUserEvents = (dynamic userId) {
    return '${Endpoints.host}events?userId=$userId';
  };

  static Function kgetAllUserUpcomingEvents = (dynamic userId) {
    return 'http://ketchuprequestsfunctions-20200129102746440.azurewebsites.net/api/HttpTrigger-Java?code=HXlNyP13u1ffHaBWKta6m8AxiflCccjXug/h8s9tcXVkBei7QiOlRQ==&userId=$userId';
  };

  static final kcreateEvent = '${Endpoints.host}events';
}
