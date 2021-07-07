function Log2(value as integer)
	value = log(value)/log(2.0)
endfunction value

function NextBitIndex(value as integer)
 value = Log2(value&&-value)
endfunction value

function BitIndex(value as integer, index as integer)
endfunction (value>>index)&&1
