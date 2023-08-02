Value = {}
Value.mt = {}

function Value:new(data, children, op)
  local o = {
    data = data,
    grad = 0,
    _children = children or {},
    _op = op,
  }
	setmetatable(o, self)
	self.__index = self
	return o
end

Value.mt.__add = function(self, other)
	if type(self) == "number" then
		self = Value:new(self)
	end
  if type(other) == "number" then
    other = Value:new(other)
  end

  local result = Value:new(self.data + other.data)
	local function _backward()
		self.grad = self.grad + result.grad
		other.grad = other.grad + result.grad
	end

	result._backward = _backward
	return result
end

Value.__add = Value.mt.__add

Value.mt.__mul = function(self, other)
	if type(self) == "number" then
		self = Value:new(self)
	end

  if type(other) == "number" then
    other = Value:new(other)
  end

	local result = Value:new(self.data * other.data)
	local function _backward()
		self.grad = self.grad * result.grad
		other.grad = other.grad * result.grad
	end

	result._backward = _backward
	return result
end

Value.__mul = Value.mt.__mul

Value.mt.__pow = function(x, y)
  assert(type(y) == "number", "only support int/float powers for now")
	local result = Value:new(x.data ^ y)
	local function _backward()
		x.grad = y * x.grad ^ (y - 1) * result.grad
	end

	result._backward = _backward
	return result
end

Value.__pow = Value.mt.__pow

Value.mt.relu = function(self)
	if type(self) == "number" then
		self = Value:new(self)
	end
  local result = Value:new(math.max(self.data, 0))

  local function _backward()
    self.grad = self.grad + result.data > 0 * result.grad
  end

  result._backward = _backward
  return result
end

Value.relu = Value.mt.relu

Value.mt.__unm = function(self)
	if type(self) == "number" then
		self = Value:new(self)
	end
  return self * -1
end

Value.__unm = Value.mt.__unm

Value.mt.__sub = function(self, other)
	if type(self) == "number" then
		self = Value:new(self)
	end

	return self.data + (-other)
end

Value.__sub = Value.mt.__sub

-- Value.mt.backward = function(x)
--   local topo = {}
--   local visited = {} -- Needs a set class/type
--
--   local build_topo = function(v)
--     -- if v not in visited
--     -- Add v to visited
--     -- traverse children in v._prev and call recursively
--     table.insert(topo, v)
--   end
--
--   build_topo(x)
--
--   x.grad = 1
--   -- foreach in reversed topo
--   for i=1,#topo do  -- reversed??? NEEDS
--     print(i)
--     -- Won't work, but illustrates the point, except reveresed
--     -- table.sort(a, function(a,b)
  --
  --     end
--     topo[i]._backward()
--   end
-- end
