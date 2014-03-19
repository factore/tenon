include ActionDispatch::TestProcess
path = File.join(Tenon::Engine.root, 'spec', 'fixtures', 'files/test.png')

FactoryGirl.define do
  factory :asset, class: Tenon::Asset do
    attachment { fixture_file_upload(path) }
  end
end
