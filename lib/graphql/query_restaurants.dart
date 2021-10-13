const queryRestaurants = r'''
  query Restaurants {
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
