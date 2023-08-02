require "engine"

describe('Value', function()
	it('adds two Values', function()
		local a = Value:new(2.0)
		local b = Value:new(-4.0)
		local c = a + b
		assert.equal(c.data, -2.0)
	end)
end)
