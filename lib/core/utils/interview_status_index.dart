int getInterviewStatusIndex(String status) {
  switch (status) {
    case 'pending':
      return 0;
    case 'accepted':
      return 1;
    case 'completed':
      return 2;
    case 'cancelled':
      return 3;
    default:
      return 0;
  }
}
