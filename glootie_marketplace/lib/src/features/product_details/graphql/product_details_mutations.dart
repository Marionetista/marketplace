class Mutation {
  static String purchase(String offerId) => '''
    mutation purchase {
      purchase(offerId: "$offerId") {
        success
        errorMessage
        customer {
          id
          name
          balance
          offers {
            id
            price
            product {
              id
              name
              description
              image
            }
          }
        }
      }
    }
  ''';
}
