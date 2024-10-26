# regex_spec.rb
RSpec.describe 'Regular Expression for decimal literal' do
  let(:nonzero_decimal_digit) { /[1-9]/ }
  let(:decimal_digit) { /[0-9]/ }
  let(:decimal) { /#{nonzero_decimal_digit}('?#{decimal_digit}+)*/ }
  let(:size) { /[uU]?[lL]{0,2}/ }

  let(:pattern) { /^-?#{decimal}#{size}$/ }

  let(:should_pass) { [ "1", "-33'000", "4525235", "10'080", "123'456'789", "1ul", "1u", "1ll" ] }
  let(:should_fail) { ["'1'", "1'''3", "afed", "+33", "0", "ul", "lll", "3lll", "3uuull" ] }

  describe 'should pass' do
    it 'matches all expected strings' do
      should_pass.each do |str|
        expect(str).to match(pattern)
      end
    end
  end

  describe 'should fail' do
    it 'does not match any of the strings' do
      should_fail.each do |str|
        expect(str).not_to match(pattern)
      end
    end
  end
end

RSpec.describe 'Regular Expression for octal literal' do
  let(:octal_digit) {  /[0-7]/ }
  let (:octal) {/'?#{octal_digit}+/}
  let(:pattern) {/^0#{octal}*$/}

  let(:should_pass) { ["0", "077772", "0111", "01234567", "0'1'1'1", "0100'100"]}
  let(:should_fail) {["1", "08", "9", "0'''1", "'000", "0'"]}
  describe 'should pass' do
    it 'matches all expected strings' do
      should_pass.each do |str|
        expect(str).to match(pattern)
      end
    end
  end
    describe 'should fail' do
      it 'does not match any of the strings' do
        should_fail.each do |str|
          expect(str).not_to match(pattern)
        end
      end
    end
end

RSpec.describe 'Regular Expression for hex literal' do
  let(:hex_digit) {  /[0-9]|[A-F]|[a-f]/ }
  let(:hex_start) {/0[xX]/}
  let (:hex) {/'?#{hex_digit}+/}
  let (:pattern) {/^#{hex_start}#{hex_digit}#{hex}*$/}
  let (:should_pass) {["0Xfffff", "0xfffff", "0x123ab'c", "0x1", "0xabcdef", "0x1'1'1"]}
  let (:should_fail) {["fffff", "0x", "0X", "12345", "abcdef", "x133f", "0xzzzzz", "0'x11", "0x'", "0xffff'", "0xf'''f"]}

  describe 'should pass' do
    it 'matches all expected strings' do
      should_pass.each do |str|
        expect(str).to match(pattern)
      end
    end
  end
    describe 'should fail' do
      it 'does not match any of the strings' do
        should_fail.each do |str|
          expect(str).not_to match(pattern)
        end
      end
    end

end
RSpec.describe 'Regular Expression for binary literal' do
  let(:binary_digit) {  /[0-1]/ }
  let (:binary_start) {/0[bB]/}
  let (:binary) {/'?#{binary_digit}+/}
  let(:pattern) {/^#{binary_start}#{binary_digit}#{binary}*$/}

  let(:should_pass) { ["0B10101001", "0b1", "0B0", "0B0'0'0000'000000000", "0b1'11111111111111111111111", "0b1010100101001"]}
  let(:should_fail) {["4", "0b", "0B", "10101001", "0b2", "0B34", "0b'1", "0b1''1"]}
  describe 'should pass' do
    it 'matches all expected strings' do
      should_pass.each do |str|
        expect(str).to match(pattern)
      end
    end
  end
    describe 'should fail' do
      it 'does not match any of the strings' do
        should_fail.each do |str|
          expect(str).not_to match(pattern)
        end
      end
    end
end

