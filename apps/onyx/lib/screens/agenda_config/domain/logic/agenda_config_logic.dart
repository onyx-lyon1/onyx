class AgendaConfigLogic {
  static List<int> urlToIndexes(String url) {
    String resources =
        RegExp(r"resources=([0-9,]+)").firstMatch(url)!.group(0)!.split("=")[1];
    return resources.split(",").map((e) => int.parse(e)).toList();
  }
}
