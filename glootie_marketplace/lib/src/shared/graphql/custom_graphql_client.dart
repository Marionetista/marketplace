import 'package:graphql_flutter/graphql_flutter.dart';

class CustomGraphQLClient extends GraphQLClient {
  CustomGraphQLClient(
    Link link,
    GraphQLCache cache,
  ) : super(link: link, cache: cache);

  @override
  Future<QueryResult> query(QueryOptions options) {
    return super.query(options).timeout(Duration(seconds: 10));
  }

  @override
  Future<QueryResult> mutate(MutationOptions options) {
    return super.mutate(options).timeout(Duration(seconds: 10));
  }
}
