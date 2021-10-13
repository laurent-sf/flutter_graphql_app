const queryReservations = r'''
  query Reservations {
    reservations {
      _id
      restaurant {
        _id
        name
        photo
      }
    }
  }
''';
