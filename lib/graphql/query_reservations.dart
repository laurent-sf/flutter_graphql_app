const queryReservations = r'''
  query Query {
    reservations {
      _id
      restaurant {
        _id
        name
        description
        hours
        photo
        version
      }
    }
  }
''';
