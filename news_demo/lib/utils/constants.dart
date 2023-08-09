

class Constants {

  static String TOP_HEADLINES_URL =  "https://newsapi.org/v2/top-headlines?country=us&apiKey=299906d13ff2422ca9c4a5aad26a1af7";

  static String headlinesFor(String keyword) {

    return  "https://newsapi.org/v2/everything?q=$keyword&apiKey=299906d13ff2422ca9c4a5aad26a1af7";

  }

  

}