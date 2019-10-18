import wollok.game.*
import hector.*


class Maiz {
	var property position
	var regado=false
	
	method esMercado() { return false }
	method image() {
		if(regado) { return "corn_adult.png" }
		else { return "corn_baby.png"}
	}
	method regar() {
			regado=true
	}
	method cosechar() {
		if(regado) {
			hector.cosecharUnaPlanta(self)
			game.removeVisual(self)
		}
		else{ game.say(hector, "no regate lo maice") }
	}
	method valor() { return 150 }
}

class Trigo {
	var property position
	var etapa=0
	
	method esMercado() { return false }
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
	method cosechar() {
		if(etapa>=2) {
			hector.cosecharUnaPlanta(self)
			game.removeVisual(self)
		}
		else{ game.say(hector, "no regaste lo suficiente el trigo") }
	}
	method valor() { if(etapa==2) { return 100 } else { return (etapa - 1)*100 } }
}

class Tomaco {
	var property position
	
	method esMercado() { return false }
	method image() { return "tomaco.png" }
	method regar() {
		if(self.position().y() < game.height() - 1) {
			self.position(self.position().up(1))
		}
		else {
			self.position(new Position(x=self.position().x(), y=0))
		}
	}
	method cosechar() {
		hector.cosecharUnaPlanta(self)
		game.removeVisual(self)
	}
	method valor() { return 80 }
}

class Market {
	var property position=new Position(x= 0.randomUpTo(game.width() - 1), y= 0.randomUpTo(game.height() - 1))
	var property plantasCompradas = []
	var property dinero
	
	method esMercado() { return true }
	method comprarUnaPlanta(planta) {
		plantasCompradas.add(planta)
	}
	
	method image() { return "market.png" }
	
	method puedeComprarPlantas() {
		return hector.valorTotalCosechadas()<=self.dinero()
	}
	method comprarPlantas() {
			hector.cosechadas().forEach{ planta => self.comprarUnaPlanta(planta) dinero-=planta.valor() }
	}
}