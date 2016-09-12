RSpec.configure do |config|
  config.include FactoryGril::Syntax::Methods

  config.before(:suite) do
    begin
      DatbaseCleaner.start
      FactorGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end
