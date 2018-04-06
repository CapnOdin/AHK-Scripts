
Is_OfType(val, lst*) {
	return __is(False, val, lst*)
}

Is_OfTypes(val, lst*) {
	return __is(True, val, lst*)
}

__is(requireAll, val, lst*) {
	for i, type in lst {
		if(negate := SubStr(type, 1, 1) == "!") {
			type := SubStr(type, 2)
		}
		if(__check(val, type, negate) == !requireAll) {
			return !requireAll
		}
	}
	return requireAll
}

__check(val, type, negate := False) {
	if type in integer,float,number,digit,xdigit,alpha,upper,lower,alnum,space,time
		if val is %type%
			return negate ? False : True
		else
			return negate ? True : False
	return ((val ~= type) != 0) == !negate
}
