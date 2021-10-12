const createReservation = r'''
  mutation CreateReservationMutation($restaurantId: ID!) {
    reservations: createReservation(restaurantId: $restaurantId) {
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
