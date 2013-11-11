class StressTestUniversal
  include ActiveModel::Validations
  include ActiveModel::Conversions
  extend ActiveModel::Naming

  attr_accessor :provider_name, :api_version, :url, :hotels_per_request, :concurrency, :number_of_repeats

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end
    @unchecked = true
  end

  def run
    stress_test_response = run_test
    handle_test_response(stress_test_response)
  end

  def handle_test_response(response)
    if @unchecked
      check_for_errors(response)
    else
      test_statistics(stress_test_response)
    end
  end


  def persisted?
    false
  end

  private
  def run_test
    case @unchecked
      when true
        run_basic_test
      else
        run_stress_test
    end
  end

  def check_for_errors(response)
    if errors?(response)
      highlight_errors(response)
    else
      @unchecked = false
      run
    end
  end

  def run_stress_test
    `ruby $HACTOP/toolbox/stress_test_universal -p #{provider_name} -u #{url} -a #{api_version} -o #{hotels_per_request} -c #{concurrency} -t #{number_of_repeats}`
  end


  def run_basic_test
    `ruby $HACTOP/toolbox/stress_test_universal -p #{provider_name} -u #{url} -a #{api_version} -o 1 -c 1 -t 1`
  end

  def errors?(response)

  end

  def test_statistics(response)

  end

  def highlight_errors(response)

  end
end