require 'spec_helper'

describe Tenon::Asset do
  describe '.with_type' do
    %w(images videos).each do |type|
      context "when type is #{type}" do
        it 'should receive the proper args' do
          args = ['attachment_content_type LIKE ?', "%#{type.singularize}%"]
          expect(Tenon::Asset).to receive(:where).with(*args)
          Tenon::Asset.with_type(type)
        end
      end
    end

    context 'when the type is anything else' do
      it 'should fall back on to .documents' do
        expect(Tenon::Asset).to receive(:documents)
        Tenon::Asset.with_type('foo')
      end
    end
  end

  describe '#is_image?' do
    let(:asset) { Tenon::Asset.new(attachment_content_type: content_type) }
    context 'when it is an image' do
      let(:content_type) { 'image/jpeg' }
      it 'should be true' do
        expect(asset.is_image?).to be_true
      end
    end

    context 'when it is not an image' do
      let(:content_type) { 'application/pdf' }
      it 'should not be true' do
        expect(asset.is_image?).not_to be_true
      end
    end
  end

  describe '#dimensions' do
    let(:asset) { Tenon::Asset.new }
    let(:attachment) { double(styles: { thumbnail: 'foo' }) }
    before do
      asset.stub(:attachment) { attachment }
    end

    context 'when the style is :original' do
      it 'should use the Paperclip.io_adapters.for chain to get a file from the attachment' do
        stub_const('Paperclip::Geometry', double.as_null_object)
        io = double
        expect(Paperclip).to receive(:io_adapters) { io }
        expect(io).to receive(:for).with(attachment)
        asset.dimensions
      end

      it 'should use Paperclip::Geometry to get the dimensions' do
        Paperclip.stub(:io_adapters) { double.as_null_object }
        stub_const('Paperclip::Geometry', double.as_null_object)
        expect(Paperclip::Geometry).to receive(:from_file)
        asset.dimensions
      end
    end

    context 'when the style is :something else' do
      it 'should use the Paperclip.io_adapters.for chain to get a file from the style' do
        stub_const('Paperclip::Geometry', double.as_null_object)
        io = double
        expect(Paperclip).to receive(:io_adapters) { io }
        expect(io).to receive(:for).with(attachment.styles['thumbnail'])
        asset.dimensions(:thumbail)
      end

      it 'should use Paperclip::Geometry to get the dimensions' do
        Paperclip.stub(:io_adapters) { double.as_null_object }
        stub_const('Paperclip::Geometry', double.as_null_object)
        expect(Paperclip::Geometry).to receive(:from_file)
        asset.dimensions
      end
    end
  end

  describe '#cropping?' do
    let(:asset) { Tenon::Asset.new }

    context 'when #crop_x is present' do
      it 'should be true' do
        asset.stub(:crop_x) { true }
        expect(asset.cropping?).to be_true
      end
    end

    context 'when #crop_x is not present' do
      it 'should not be true' do
        expect(asset.cropping?).not_to be_true
      end
    end
  end
end
