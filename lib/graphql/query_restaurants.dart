const queryRestaurants = r'''
  query Query {
      restaurants {
          _id
          name
          description
          hours
          photo
          version
      }
  }
''';
