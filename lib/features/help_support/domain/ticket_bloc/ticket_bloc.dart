import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/help_support/data/ticket_repository.dart';
import 'package:sg_easy_hire/features/help_support/domain/ticket_bloc/ticket_event.dart';
import 'package:sg_easy_hire/features/help_support/domain/ticket_bloc/ticket_state.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';
import 'package:sg_easy_hire/models/RelatedModelType.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketRepository repository;
  TicketBloc(this.repository) : super(TicketState()) {
    on<SelectTicketType>(_selectTicketType);
    on<GetModels>(_onGetModels);
    //on<SelectModel>(_onSelectModel);
  }

  FutureOr<void> _selectTicketType(
    SelectTicketType event,
    Emitter<TicketState> emit,
  ) {
    emit(state.copyWith(modelType: event.modelType));
    add(GetModels(helperID: event.helperID));
  }

  FutureOr<void> _onGetModels(
    GetModels event,
    Emitter<TicketState> emit,
  ) async {
    emit(state.copyWith(status: TicketStateStatus.pending));
    try {
      switch (state.modelType) {
        case RelatedModelType.HIRED_JOB:
          final response = await repository.getHiredJobs(event.helperID);
          emit(
            state.copyWith(
              status: TicketStateStatus.success,
              hiredJobs: response,
            ),
          );
          break;
        case RelatedModelType.TRANSACTION:
          final response = await repository.getTransactions(event.helperID);
          emit(
            state.copyWith(
              status: TicketStateStatus.success,
              transactions: response,
            ),
          );
          break;
        case RelatedModelType.DOCUMENT:
          final response = await repository.getDocuments(event.helperID);
          emit(
            state.copyWith(
              status: TicketStateStatus.success,
              documents: response,
            ),
          );
          break;
        case RelatedModelType.ACCOUNT:
          break;
        case RelatedModelType.GENERAL:
          break;
        default:
      }
    } catch (e) {
      emit(state.copyWith(status: TicketStateStatus.failure));
    } finally {
      emit(state.copyWith(status: TicketStateStatus.none));
    }
  }

  /*  FutureOr<void> _onSelectModel(
    SelectModel<Model> event,
    Emitter<TicketState> emit,
  ) async {
    //create ticket
    //create chatroom with ticket
    final ticket = SupportTicket(subject: subject, status: status);
  }
 */
}

/* String relatedModelTypeToSubject(RelatedModelType type,Model model){
  switch (type) {
    case RelatedModelType.HIRED_JOB:
      return "Hired Job: ${model.}"
      break;
    default:
  }
} */
