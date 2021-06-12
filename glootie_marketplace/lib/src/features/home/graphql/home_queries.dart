class HomeQueries {
  static const String customer = '''
query customer {
  viewer {
    ... on Customer {
      id
      name
      balance
      offers {
        id
        price
        product {
          id
          description
          image
          name
        }
      }
    }
  }
}
  ''';
}
