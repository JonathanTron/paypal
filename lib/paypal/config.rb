module Paypal
  module Config

    class << self
      attr_accessor :ipn_urls, :mode, :paypal_sandbox_cert, :paypal_production_cert, :business_cert, :business_key, :business_cert_id

      def ipn_urls
        @ipn_urls ||= {
          :sandbox => "https://www.sandbox.paypal.com/cgi-bin/webscr",
          :production => "https://www.paypal.com/cgi-bin/webscr"
        }
      end

      def mode=(new_mode)
        raise ArgumentError.new("Paypal::Config.mode should be either :sandbox or :production (you tried to set it as : #{new_mode})") unless [:sandbox, :production].include?(new_mode.to_sym)
        @mode = new_mode.to_sym
      end
      def mode
        @mode ||= :sandbox
      end

      def ipn_url
        ipn_urls[mode]
      end

      def ipn_validation_path
        URI.parse(ipn_url).path + "?cmd=_notify-validate"
      end

      def ipn_validation_url
      "#{ipn_url}?cmd=_notify-validate"
      end

      def paypal_sandbox_cert
        @paypal_sandbox_cert ||= File.read(File.join(File.dirname(__FILE__), 'certs', 'paypal_sandbox.pem'))
      end

      def paypal_cert
        case mode
        when :sandbox
          paypal_sandbox_cert
        when :production
          raise StandardError.new("You should set Paypal::Config.paypal_production_cert with your paypal production certificate") unless paypal_production_cert
          paypal_production_cert
        end
      end
    end
  end
end
