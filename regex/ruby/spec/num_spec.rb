# regex_spec.rb
SIZE_RE = /(?:[uU]?)(?:[lL]{0,2}|[zZ]?)/

RSpec.describe 'Regular Expression for decimal literal' do
  let(:nonzero_decimal_digit) { /[1-9]/ }
  let(:decimal_digit) { /[0-9]/ }
  let(:decimal) { /#{nonzero_decimal_digit}('?#{decimal_digit}+)*/ }

  let(:pattern) { /^-?#{decimal}#{SIZE_RE}$/ }

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
  let(:pattern) {/^0#{octal}*#{SIZE_RE}$/}

  let(:should_pass) { ["0", "077772", "0111", "01234567", "0'1'1'1", "0100'100", "00ll", "00ul", "077ULL", "077uZ", "011Z"]}
  let(:should_fail) {["1", "08", "9", "0'''1", "'000", "0'", "0LLLL", "0UUU", "0111u111", "01uZll", "02zl", "02zz"]}
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
  let (:pattern) {/^#{hex_start}#{hex_digit}#{hex}*#{SIZE_RE}$/}
  let (:should_pass) {["0Xfffff", "0xfffff", "0x123ab'c", "0x1", "0xabcdef", "0x1'1'1", "0x1ll", "0x22ull", "0x33ul", "0x3uZ", "0x3z"]}
  let (:should_fail) {["fffff", "0x", "0X", "12345", "abcdef", "x133f", "0xzzzzz", "0'x11", "0x'", "0xffff'", "0xf'''f", "0x1UU", "0xlllll", 
  "0x11uLLZ"]}

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
  let(:pattern) {/^#{binary_start}#{binary_digit}#{binary}*#{SIZE_RE}$/}

  let(:should_pass) { ["0B10101001", "0b1", "0B0", "0B0'0'0000'000000000", "0b1'11111111111111111111111", "0b1010100101001", "0b11ll", "0b11u",
  "0b1Z", "0b0uz", "0b1uZ"]}
  let(:should_fail) {["4", "0b", "0B", "10101001", "0b2", "0B34", "0b'1", "0b1''1", "0b1uuu", "0blllU", "0b1uZll"]}
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

