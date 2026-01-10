import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';
import 'package:sg_easy_hire/models/RelatedModelType.dart';

part 'ticket_state.freezed.dart';

enum TicketStateStatus {
  pending,
  success,
  failure,
  none,
}

enum TicketStateActions { createTicket, gettingModels, none }

@freezed
class TicketState with _$TicketState {
  factory TicketState({
    @Default(TicketStateStatus.none) status,
    @Default(TicketStateActions.none) actions,
    @Default(RelatedModelType.NONE) modelType,
    User? admin,
    @Default([]) List<HiredJob> hiredJobs,
    @Default([]) List<Transaction> transactions,
    @Default([]) List<GeneralDocument> documents,
  }) = _TicketState;
}
