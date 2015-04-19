require 'spec_helper'

describe 'mailman' do

  let :params do
    { :password => 'password', :admin_email => 'admin@email.com' }
  end

  it 'installs mailman' do
    is_expected.to contain_class('mailman::install')
  end

  it 'configures mailman' do
    is_expected.to contain_class('mailman::config')
  end

  it 'runs the mailman service' do
    is_expected.to contain_class('mailman::service')
  end

  it 'creates the mailman mailing lists' do
    is_expected.to contain_class('mailman::lists')
  end

end
