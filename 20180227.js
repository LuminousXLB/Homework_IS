function divide(dividend, divisor) {
  // 3. (思考1.8(3))
  var quotinent = 0

  while (dividend >= divisor) {
    quotinent++
    dividend -= divisor
  }

  var remainder = dividend
  var divide = !Boolean(remainder)

  return { quotinent, remainder, divide }
  // quotinent Integer 不完全商
  // remainder Integer 余数
  // divide    Boolean 是否整除
}


function PrimeList(max = 10000) {
  // 4. (思考1.8(4))
  var arr = []
  var sup = parseInt(Math.sqrt(max) + 1)

  for (var i = 3; i <= sup; i += 2) {
    if (arr[i]) {continue;
    } else {
      for (var j = 3; i * j <= max; j += 2) {
        arr[i * j] = true;
      }
    }
  }

  var ret = [2]
  for (var i = 3; i <= max; i += 2) {
    if (!arr[i]) ret.push(i)
  }
  return ret
}

function isPrime(num) {
  // 2.（思考1.8(2)）

  var sup = parseInt(Math.sqrt(num) + 1)
  var arr = PrimeList(sup)

  for (var i = 0; i < arr.length; i++) {
    if (num % arr[i] == 0) {
      return false
    }
  }
  return true
}
