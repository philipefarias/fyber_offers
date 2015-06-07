using FyberOffers::Utils

module FyberOffers
  module Web

    class OffersForm
      Input = Struct.new(:name, :type, :value, :required)

      attr_reader :params, :inputs, :errors

      def initialize(params = {}, fetcher: Fetcher)
        @params  = params.symbolize_keys
        @errors  = {}
        @fetcher = fetcher.new(params)

        @inputs  = [
            Input.new(:uid,  :text,   nil, true),
            Input.new(:pub0, :text,   nil, false),
            Input.new(:page, :number, nil, false)
        ]

        assign_input_values if params.present?
      end

      def submit
        validate_input_values

        errors.blank? ? fetch_offers : []
      end

      def error_messages
        errors.inject([]) do |messages, (input, message)|
          msg = (input == :base) ? message : "#{input} #{message}"
          messages << msg
          messages
        end
      end

      private

      def assign_input_values
        inputs.each do |input|
          param = params[input.name]
          input.value = param if param.present?
        end
      end

      def validate_input_values
        validate_require_inputs
        validate_number_inputs
      end

      def validate_require_inputs
        required_inputs.each do |input|
          errors[input.name] = "can't be blank" if input.value.to_s.empty?
        end
      end

      def validate_number_inputs
        number_inputs.each do |input|
          value = input.value.to_s
          errors[input.name] = "must be a number" if value.present? && !value.number?
        end
      end

      def required_inputs
        inputs.select { |input| input.required }
      end

      def number_inputs
        inputs.select { |input| input.type == :number }
      end

      def fetch_offers
        @fetcher.call
      rescue FyberOffers::API::Error => e
        @errors = detect_error(e)
        []
      end

      def detect_error(exception)
        case exception.class.to_s
          when /Invalid(Uid|Appid|Page)/
            { $1.downcase.to_sym => "is invalid" }
          else
            { base: "internal error: #{exception}" }
        end
      end
    end

  end
end