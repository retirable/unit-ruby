require 'unit-ruby/util/connection'
require 'unit-ruby/util/error'
require 'unit-ruby/util/api_resource'
require 'unit-ruby/util/resource_operations'
require 'unit-ruby/util/schema'

require 'unit-ruby/types/account_limits'
require 'unit-ruby/types/ach_limits'
require 'unit-ruby/types/address'
require 'unit-ruby/types/application_form_prefill'
require 'unit-ruby/types/application_form_settings_override'
require 'unit-ruby/types/array'
require 'unit-ruby/types/boolean'
require 'unit-ruby/types/card_limits'
require 'unit-ruby/types/check_deposit_limits'
require 'unit-ruby/types/coordinates'
require 'unit-ruby/types/counterparty'
require 'unit-ruby/types/date_time'
require 'unit-ruby/types/date'
require 'unit-ruby/types/float'
require 'unit-ruby/types/full_name'
require 'unit-ruby/types/hash'
require 'unit-ruby/types/integer'
require 'unit-ruby/types/phone'
require 'unit-ruby/types/string'

require 'unit-ruby/ach_payment'
require 'unit-ruby/application_form'
require 'unit-ruby/atm_location'
require 'unit-ruby/authorization'
require 'unit-ruby/ach_counterparty'
require 'unit-ruby/customer_token_verification'
require 'unit-ruby/customer_token'
require 'unit-ruby/deposit_account'
require 'unit-ruby/individual_application'
require 'unit-ruby/individual_customer'
require 'unit-ruby/individual_debit_card'
require 'unit-ruby/institution'
require 'unit-ruby/customer_bank_migration'
require 'unit-ruby/outreach_settings'
require 'unit-ruby/received_payment'
require 'unit-ruby/pin_status'
require 'unit-ruby/statement'
require 'unit-ruby/transaction'
require 'unit-ruby/version'
require 'unit-ruby/white_label_theme'

module Unit
  # Usage:
  #   Unit.configure do |config|
  #     config.api_key = '<your api key>'
  #     config.base_url = 'https://api.s.unit.sh'
  #     config.trust_token = '<your trust token key>'
  #   end
  def self.configure
    yield(Connection)
  end
end
