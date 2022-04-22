import 'package:get/get.dart';

class PostsProvider extends GetConnect {
   Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqZG9lIiwiaWF0IjoxNjUwMzYwMDEyLCJleHAiOjE2NTA0NDY0MTIsInJvbGVzIjpbeyJuYW1lIjoiQkVUVE9SIiwiYXV0aG9yaXR5IjoiUk9MRV9CRVRUT1IifV19.e5S0Yuri2L8_0iIaMtv_j_5MwRxPUztNf3UGHSocxmFIAj7sfP6uGOzKbMQ-pffFI8MEQ2He41HBsrY6ACm9Fw",
      };

  Future<Response> getPosts() =>
      get('https://swxcanary.com/transactions', headers: headers);

  Future<Response> sendPost(Map data) => post(
        'https://jsonplaceholder.typicode.com/posts',
        data,
        contentType: 'application/json; charset=UTF-8',
      );
}
