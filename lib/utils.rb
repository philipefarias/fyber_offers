module FyberOffers
  module Utils

    refine Object do
      def present?
        !blank?
      end

      def blank?
        respond_to?(:empty?) ? !!empty? : !self
      end
    end

    refine NilClass do
      def blank?() true end
    end

    refine FalseClass do
      def blank?() true end
    end

    refine TrueClass do
      def blank?() false end
    end

    refine Numeric do
      def blank?() false end
    end

    refine Array do
      def blank?() empty? end
    end

    refine Hash do
      def blank?() empty? end
    end

    refine String do
      def blank?() self !~ /\S/ end
    end

    refine Regexp do
      def blank?() self == // end
    end

    refine Array do
      def extract_options
        last.is_a?(::Hash) ? last : {}
      end

      def extract_options!
        last.is_a?(::Hash) ? pop : {}
      end
    end

    refine Hash do
      def except(*keys)
        dup.except!(*keys)
      end

      def except!(*keys)
        keys.each { |key| delete(key) }
        self
      end

      def symbolize_keys
        result = self.class.new
        each_key do |key|
          result[(key.to_sym rescue key)] = self[key]
        end
        result
      end

      def symbolize_keys!
        keys.each do |key|
          self[(key.to_sym rescue key)] = delete(key)
        end
        self
      end
    end

    refine String do
      def number?
        !!match(/\A\d+\z/)
      end
    end

  end
end
