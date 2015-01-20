require 'spec_helper'

describe 'wkhtmltopdf-update::binary' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
