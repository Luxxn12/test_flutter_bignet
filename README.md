# TEST FLUTTER BIGNET


---
 ### Dart Functions for HTTP Requests

- GET Request with Authorization Token:

```dart
Future<http.Response> getUserData(String token) {
  return http.get(
    Uri.parse('https://dummyjson.com/auth/me'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
}
```
---
- POST Request with JSON Body:

```dart
Future<http.Response> loginUser(String username, String password) {
  return http.post(
    Uri.parse('https://dummyjson.com/auth/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'password': password,
    }),
  );
}

```

---

- GET Request with Query Parameters:

```dart
Future<http.Response> searchUser(String query) {
  return http.get(
    Uri.parse('https://dummyjson.com/users/search?q=$query'),
  );
}
```

---

## Screenshot Application
<img src="/assets/login.png" alt="login" width="700" />
<img src="/assets/dashboard.png" alt="dashboard" width="700" />
