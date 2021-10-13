const queryReservations = r'''
  query Reservations {
    reservations {
      _id
      restaurant {
        photo
      }
    }
  }
''';
