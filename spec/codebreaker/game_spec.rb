require '../spec_helper'

module Codebreaker
  RSpec.describe Game do

    let(:game) { Game.new }

    context '#initialize' do
      it 'saves secret code' do
        expect(subject.instance_variable_defined?(:@secret_code)).to be true
      end

      it "sets secret code equal ''" do
        expect(subject.instance_variable_get(:@secret_code)).to eq('')
      end

      it 'saves hint' do
        expect(subject.instance_variable_defined?(:@hint)).to be true
      end

      it "sets hint equal true" do
        expect(subject.instance_variable_get(:@hint)).to be true
      end

      it 'sets available attempts equal ATTEMPTS NUMBER' do
        expect(subject.instance_variable_get(:@available_attempts)).to eq(10)
      end

      it "sets result equal ''" do
        expect(subject.instance_variable_get(:@result)).to eq('')
      end
    end

    context '#start' do

      before do
        subject.start
      end

      it 'saves secret code' do
        expect(subject.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        expect(subject.instance_variable_get(:@secret_code).length).to eq(4)
      end

      it 'saves secret code with numbers from 1 to 6' do
        expect(subject.instance_variable_get(:@secret_code)).to match(/^[1-6]{4}$/)
      end
    end

    context '#check_enter' do

      let(:not_valid_code) {'aaaaa'}
      let(:valid_code) {'1234'}
      let(:hint_code) {'h'}

      it 'throw the warning if user_code is not valid' do
        expect(subject.check_enter(not_valid_code)).to eq 'Incorrect format'
      end

      it 'throw the warning if there are no attempts left' do
        subject.instance_variable_set(:@available_attempts, 0)
        expect(subject.check_enter(valid_code)).to eq 'There are no attempts left'
      end

      it 'reduces available_attempts by 1' do
        subject.instance_variable_set(:@available_attempts, 10)
        allow(subject).to receive(:check_matches).with(valid_code).and_return('+')
        expect { subject.check_enter(valid_code) }.to change { subject.available_attempts }.from(10).to(9)
      end

      it 'returns hint if user entered h' do
        allow(subject).to receive(:hint).and_return('2')
        expect(subject.check_enter(hint_code)).to eq('2')
      end

      it 'returns the result of matching' do
        allow(subject).to receive(:check_matches).with(valid_code).and_return('+')
        expect(subject.check_enter(valid_code)).to eq '+'
      end
    end

    context '#hint' do

      it 'returns one number from secret code' do
        subject.instance_variable_set(:@secret_code, '1234')
        expect(subject.hint).to match(/^[1-4]{1}$/)
      end

      it 'change hint to false' do
        subject.hint
        expect(subject.instance_variable_get(:@hint)).to be false
      end

      it 'returns no hint if hint was asked once more' do
        subject.instance_variable_set(:@hint, false)
        expect(subject.hint).to eq 'No hints left'
      end
    end

    context '#check_matches' do
      let(:user_code) {'1234'}

      before do
        subject.start
      end

      it 'return ++++ if user_code matches secret_code exactly' do
        subject.instance_variable_set(:@secret_code, '1234')
        subject.check_matches(user_code)
        expect(subject.instance_variable_get(:@result)).to eq '++++'
      end

      it 'returns plus if one number matches exactly' do
        subject.instance_variable_set(:@secret_code, '1556')
        subject.check_matches(user_code)
        expect(subject.instance_variable_get(:@result)).to eq '+'
      end

      it 'returns minus if one number just matches' do
        subject.instance_variable_set(:@secret_code, '4566')
        subject.check_matches(user_code)
        expect(subject.instance_variable_get(:@result)).to eq '-'
      end

      it 'returns +- if one number matches exactly and one number just matches' do
        subject.instance_variable_set(:@secret_code, '1456')
        subject.check_matches(user_code)
        expect(subject.instance_variable_get(:@result)).to eq '+-'
      end

      it 'returns no_matches if nothing matches' do
        subject.instance_variable_set(:@secret_code, '5566')
        subject.check_matches(user_code)
        expect(subject.instance_variable_get(:@result)).to eq ''
      end

    end
  end
end