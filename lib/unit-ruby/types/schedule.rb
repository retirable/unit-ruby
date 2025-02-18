module Unit
  module Types
    class Schedule
      attr_reader :start_time, :end_time, :interval,
                  :day_of_month, :day_of_week,
                  :total_number_of_payments, :next_scheduled_action

      def initialize(schedule_params)
        @start_time = schedule_params[:start_time]
        @end_time = schedule_params[:end_time]
        @interval = schedule_params[:interval]
        @day_of_month = schedule_params[:day_of_month]
        @day_of_week = schedule_params[:day_of_week]
        @total_number_of_payments = schedule_params[:total_number_of_payments]
        @next_scheduled_action = schedule_params[:next_scheduled_action]
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(
          start_time: ::Date.parse(val[:start_time]),
          end_time: ::Date.parse(val[:end_time]),
          interval: val[:interval],
          day_of_month: val[:day_of_month],
          day_of_week: val[:day_of_week],
          total_number_of_payments: val[:total_number_of_payments],
          next_scheduled_action: val[:next_scheduled_action]
        )
      end

      def as_json_api
        {
          start_time: start_time&.to_s,
          end_time: end_time&.to_s,
          interval: interval,
          day_of_month: day_of_month,
          day_of_week: day_of_week,
          total_number_of_payments: total_number_of_payments
        }.compact
      end
    end
  end
end