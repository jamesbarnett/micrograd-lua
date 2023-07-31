Value = {}
Value.mt = {}

function Value:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	self.data = o
	self.grad = 0
	return o
end

Value.mt.__add = function(x, y)
  local result = Value:new(x.data + y.data)
	local function _backward()
		x.grad = x.grad + result.grad
		y.grad = y.grad + result.grad
	end

	result._backward = _backward
	return result
end

Value.mt.__mul = function(x, y)
	local result = Value:new(x.data * y.data)
	local function _backward()
		x.grad = x.grad * result.grad
		y.grad = y.grad * result.grad
	end

	result._backward = _backward
	return result
end

Value.mt.__pow = function(x, y)
	local result = Value:new(x.data ^ y)
	local function _backward()
		x.grad = y * x.grad ^ (y - 1) * result.grad
	end

	result._backward = _backward
	return result
end

