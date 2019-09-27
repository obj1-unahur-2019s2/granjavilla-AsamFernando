class Maiz {
	var regado=false
	method image() {
		if(regado) { return "corn_adult.png" }
		else { return "tomaco.png"}
	}
	method regar() {
		regado=true
	}
}

class Trigo {
	var etapa=0
	method image() {
		if(etapa==0) { return "wheat_0.png" }
		else if(etapa==1) { return "wheat_1.png" }
		else if(etapa==2) { return "wheat_2.png" } 
		else if(etapa==3) { return "wheat_3.png" }
		else { return "wheat_0.png" }
	}
	method regar() {
		if (etapa>3) { etapa=0 } 
		else{ etapa+=1 }
	}
}

class Tomaco {
	var regado=false
	method image() {
		if(regado) { return "tomaco.png" }
		else { return "tomaco_baby.png"}
	}
	method regar() {
		regado=true	
	}
}