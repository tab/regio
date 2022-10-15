# frozen_string_literal: true

module RegioHelpers
  def regio_stub_request(method, path)
    stub_request(method, /#{Regio::Core.base_uri}#{path}/)
  end

  private

  def regio_response(relative_path)
    {
      body: File.open("./spec/fixtures/#{relative_path}"),
      headers: {
        'Content-Type' => 'application/json'
      }
    }
  end
end
