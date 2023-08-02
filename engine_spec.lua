require "engine"

describe('Value', function()
	describe('Addition', function()
		it('works with two Values', function()
			local a = Value:new(2.0)
			local b = Value:new(-4.0)
			local c = a + b
			assert.equal(c.data, -2.0)
		end)

		it('works with simple numbers', function()
			local a = Value:new(2.0)
			local b = a + 5.0
			assert.equal(b.data, 7.0)
			local c = 3.0 + a
			assert.equal(c.data, 5.0)
		end)
	end)

	describe('Multlplication', function()
		it('works with two Values', function()
			local a = Value:new(4.0)
			local b = Value:new(7.0)
			local c = a * b
			assert.equal(c.data, 28.0)
		end)

		it('works with simple numbers', function()
			local a = Value:new(2.5)
			local b = a * 4
			assert.equal(b.data, 10.0)
			local c = 2 * a
			assert.equal(c.data, 5.0)
		end)
	end)
end)
