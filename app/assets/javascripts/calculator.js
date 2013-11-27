GPW.Calculator = (function(){
	var result = 0;
	var calculator = {
		add: function(a, b) {
			if (typeof a === "number" && typeof b === "number") {
				result = a+b;
			}
			return this;
		},
		multiplyPercent: function(a, b) {
			if (typeof a === "number" && typeof b === "number") {
				result = a*b/100;
			}
			return this;
		},
        multiply: function(a, b) {
			if (typeof a === "number" && typeof b === "number") {
				result = a*b;
			}
			return this;
		},
        percent: function(w, a){
            var temp;
            if(typeof w === "number" && typeof a === "number"){
                temp = w/a;
                result = temp * 100;
            }    
            return this;
        },
		divide: function(a,b) {
			if (typeof b === "number" && b !== 0 && 
                typeof a === "number") {
				result = a/b;
			}
			return this;
		},
		getResult: function() {
			return result;
		}
	};
	return calculator;
})();
