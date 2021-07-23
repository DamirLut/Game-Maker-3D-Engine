///@interface Vector
function Vector(){
	x = 0; ///@is {number}
	y = 0; ///@is {number}
	z = 0; ///@is {number}
	static toString = function(){}
	static set = function(vector/*: Vector*/){}
	static toArray = function(){}
	static hash = function(){}
	static divide = function(){}
}

///@implements {Vector}
function Vector2(x,y) constructor{
	if (x == undefined) x = 0;
	if (y == undefined) y = 0;
	self.x = x; ///@is {number}
	self.y = y; ///@is {number}
	static toString = function(){
		return "Vec2("+string(floor(x))+","+string(floor(y))+")"
	}
	static set = function(vector/*: Vector2*/){
		self.x = vector.x
		self.y = vector.y
	}
	static toArray = function(){
		return [x,y]
	}
	static hash = function(){
		return md5_string_unicode(toString());
	}
	static divide = function(k){
		x = floor(x / k);
		y = floor(y / k);
		return self;
	}
}
///@implements {Vector}
function Vector3(x,y,z) : Vector2(x,y) constructor{
	if (z == undefined) z = 0;
	self.z = z; ///@is {number}
	static toString = function(){
		return "Vec3("+string(floor(x))+","+string(floor(y))+","+string(floor(z))+")"
	}
	static set = function(vector/*: Vector3*/){
		self.x = vector.x
		self.y = vector.y
		self.z = vector.z
	}
	static toArray = function(){
		return [x,y,z]
	}
	static hash = function(){
		return md5_string_unicode(toString());
	}
	static divide = function(k){
		x = floor(x / k);
		y = floor(y / k);
		z = floor(z / k);
		return self;
	}
}

function cross_product(a/*: Vector*/, b/*: Vector*/, result/*: Vector*/){
	var ax = a.x, ay = a.y, az = a.z,
		bx = b.x, by = b.y, bz = b.z;
	result.x = ay * bz - az * by;
	result.y = az * bx - ax * bz;
	result.z = ax * by - ay * bx;
}

function normalize(vec/*: Vector*/){
	var k = sqrt(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z);
	vec.x /= k;
	vec.y /= k;
	vec.z /= k;
}