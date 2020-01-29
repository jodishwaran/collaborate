class Endpoints {
  static const host = 'https://msketchup.azurewebsites.net/';
  static final klogin = '${Endpoints.host}ketchup/authenticate';
  static final kgetAllCategories = '${Endpoints.host}categories/';
  static Function kgetUserCategories = (dynamic userId) {
    return '${Endpoints.host}users/$userId/categories/';
  };

  static Function kgetUserEvents = (dynamic userId) {
    return '${Endpoints.host}events?userId=$userId';
  };
}
