import wollok.game.*
import cultivos.*

object hector {
	var property position=new Position(x=game.center().x(), y=game.center().y())
	const property image = "player.png"
	const property cosechadas = []
	var property dinero=0
	
	method esMercado() { return false }
	method regar() {}
	method cosechar() {}
	
	method plantarTrigo() {
		game.addVisual(new Trigo(position=self.position()))
	}
	method plantarTomaco() {
		game.addVisual(new Tomaco(position=self.position()))
	}
	method plantarMaiz() {
		game.addVisual(new Maiz(position=self.position()))
	}
	method cosecharUnaPlanta(planta) {
		cosechadas.add(planta)
		
	}
	method mostrarCantidadCosechadas() {
		return cosechadas.size()
	}
	
	
	method objetosEnPosicion() {
		return game.getObjectsIn(self.position())
	}
	method estaEnMercado() {
		return self.objetosEnPosicion().any{ obj => obj.esMercado() }
	}
	method mercado() { 
		return self.objetosEnPosicion().find{ obj => obj.esMercado() }
	}
	method plantasEnPos() {
		return self.objetosEnPosicion().filter{obj => obj!=self and not obj.esMercado()}
	}
	method cantPlantasEnPos() { return self.plantasEnPos().size() }
	
	method regarPlantas() {
		if(self.cantPlantasEnPos()>0) {
			self.plantasEnPos().forEach{planta => planta.regar()}
		}
		else { game.say(self, "no hay planta para regar") }
	}
	method cosecharPlantas() { 
		if(self.cantPlantasEnPos()>0) {
			self.plantasEnPos().forEach{ planta => planta.cosechar()}
  		}
 		else { game.say(self, "no hay planta para cosechar") }
 	}
 	method valorTotalCosechadas() {
 		var total=0
 		cosechadas.forEach{ planta => total+=planta.valor() }
 		return total
 	}
 	method venderPlantas() {
 		
 		if(self.mostrarCantidadCosechadas()>0) {
	 		if(self.mercado().puedeComprarPlantas()) {
	 			self.mercado().comprarPlantas()
	 			dinero+=self.valorTotalCosechadas()
	 			cosechadas.clear()
	 			game.showAttributes(self.mercado())
	 		}
	 		else {
	 			game.say(self.mercado(), "tengo " + self.mercado().dinero() + " no me alcanza para comprar")
	 		}
	 	}
	 	else {
	 		game.say(self, "no tengo plantas para vender")
	 	}
 	}
}













