module Tessera
  module Model
    class Ticket < Base
      attr_accessor :ticket_id, :lock_id, :real_till_time_not_used, :changed,
                    :customer_user_id, :queue_id, :escalation_solution_time, :owner_id,
                    :unlock_timeout, :priority_id, :escalation_time, :type, :queue,
                    :escalation_response_time, :escalation_update_time, :customer_id,
                    :age, :until_time, :responsible, :lock, :priority, :state_id,
                    :created_by, :state, :type_id, :ticket_number, :group_id, :created,
                    :service_id, :owner, :slaid, :state_type, :title, :responsible_id,
                    :create_tim_nix, :changed_by, :archive_flag

      # rubocop:disable Metrics/MethodLength
      # rubocop:disable Metrics/AbcSize
      def initialize(params)
        @ticket_id = params['TicketID']
        @lock_id = params['LockID']
        @real_till_time_not_used = params['RealTillTimeNotUsed']
        @changed = params['Changed']
        @customer_user_id = params['CustomerUserID']
        @queue_id = params['QueueID']
        @escalation_solution_time = params['EscalationSolutionTime']
        @owner_id = params['OwnerID']
        @unlock_timeout = params['UnlockTimeout']
        @priority_id = params['PriorityID']
        @escalation_time = params['EscalationTime']
        @type = params['Type']
        @queue = params['Queue']
        @escalation_response_time = params['EscalationResponseTime']
        @escalation_update_time = params['EscalationUpdateTime']
        @customer_id = params['CustomerID']
        @age = params['Age']
        @until_time = params['UntilTime']
        @responsible = params['Responsible']
        @lock = params['Lock']
        @priority = params['Priority']
        @state_id = params['StateID']
        @created_by = params['CreateBy']
        @state = params['State']
        @type_id = params['TypeID']
        @ticket_number = params['TicketNumber']
        @group_id = params['GroupID']
        @created = params['Created']
        @service_id = params['ServiceID']
        @owner = params['Owner']
        @slaid = params['SLAID']
        @state_type = params['StateType']
        @title = params['Title']
        @responsible_id = params['ResponsibleID']
        @create_tim_nix = params['CreateTimeUnix']
        @changed_by = params['ChnageBy']
        @archive_flag = params['ArchiveFlag']
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/MethodLength
    end
  end
end
