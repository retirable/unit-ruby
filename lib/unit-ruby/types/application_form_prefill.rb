module Unit
  module Types
    class ApplicationFormPrefill
      attr_reader :application_type, :full_name, :ssn, :passport, :nationality, :date_of_birth,
                  :email, :address, :phone, :occupation

      def initialize(
        application_type: nil,
        full_name: nil,
        ssn: nil,
        passport: nil,
        nationality: nil,
        date_of_birth: nil,
        email: nil,
        address: nil,
        phone: nil,
        occupation: nil
      )
        @application_type = application_type
        @full_name = full_name
        @ssn = ssn
        @passport = passport
        @nationality = nationality
        @date_of_birth = date_of_birth
        @email = email
        @address = address
        @phone = phone
        @occupation = occupation
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(
          application_type: val[:application_type],
          full_name: val[:full_name],
          ssn: val[:ssn],
          passport: val[:passport],
          nationality: val[:nationality],
          date_of_birth: val[:date_of_birth],
          email: val[:email],
          address: val[:address],
          phone: val[:phone],
          occupation: val[:occupation]
        )
      end

      def as_json_api
        {
          application_type: application_type,
          full_name: full_name&.as_json_api,
          ssn: ssn,
          passport: passport,
          nationality: nationality,
          date_of_birth: date_of_birth,
          email: email,
          address: address&.as_json_api,
          phone: phone&.as_json_api,
          occupation: occupation
        }.compact
      end
    end
  end
end
