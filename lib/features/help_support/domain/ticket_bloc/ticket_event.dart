import 'package:sg_easy_hire/models/ModelProvider.dart';
import 'package:sg_easy_hire/models/RelatedModelType.dart';

class TicketEvent {}

class SelectTicketType extends TicketEvent {
  final String helperID;
  final RelatedModelType modelType;
  SelectTicketType({required this.helperID, required this.modelType});
}

class GetModels extends TicketEvent {
  final String helperID;
  GetModels({required this.helperID});
}
