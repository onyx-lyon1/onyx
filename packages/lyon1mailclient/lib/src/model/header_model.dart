Map<String, String> makeHeader(
    {String? canary,
    String? referer,
    String? action,
    String contentType = "application/json; charset=utf-8",
    String? connection,
    String accept = '*/*'}) {
  Map<String, String> response = {
    'User-Agent':
        'Mozilla/5.0 (X11; Linux x86_64; rv:105.0) Gecko/20100101 Firefox/105.0',
    'Accept': accept,
    'Origin': 'https://mail.univ-lyon1.fr',
    'Accept-Language': 'fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3',
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': contentType,
    'Upgrade-Insecure-RequestsPlus': '1',
    'X-Requested-With': 'XMLHttpRequest',
    'X-OWA-ActionName': 'ComposeForms',
    'Sec-Fetch-Dest': 'document',
    'Sec-Fetch-Mode': 'navigate',
    'Sec-Fetch-Site': 'same-origin',
    'Sec-Fetch-User': '?1',
  };
  if (canary != null) {
    response['X-OWA-CANARY'] = canary;
  }
  if (referer != null) {
    response['Referer'] = referer;
  }
  if (action != null) {
    response['Action'] = action;
  }
  if (connection != null) {
    response['Connection'] = connection;
  }
  return response;
}
