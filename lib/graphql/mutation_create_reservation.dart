const createReservation = r'''
  mutation CreateReservationMutation($restaurantId: ID!) {
    reservations: createReservation(restaurantId: $restaurantId) {
      _id
      restaurant {
        photo
      }
    }
  }
''';
