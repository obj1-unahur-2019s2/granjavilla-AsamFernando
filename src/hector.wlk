import wollok.game.*
import cultivos.*

object hector {
	var property position=new Position(x=game.center().x(), y=game.center().y())
	const property image = "player.png"
	const property cosechadas = []
	var property dinero=0
	
	method agregarPlanta(planta) {
		cosechadas.add(planta)
	}
	method mostrarCantidadCosechadas() {
		return cosechadas.size()
	}
	method plantarTrigo() {
		game.addVisual(new Trigo(position=self.position()))
	}
	method plantarTomaco() {
		game.addVisual(new Tomaco(position=self.position()))
	}
	method plantarMaiz() {
		game.addVisual(new Maiz(position=self.position()))
	}
	method regar() {}
	method cosechar() {}
	
	method cosecharPlantas() { 
		if(game.getObjectsIn(self.position()).size()>1) {
			game.getObjectsIn(self.position()).forEach{ planta => if(planta!=self) { self.agregarPlanta(planta) planta.cosechar() } }
  		}
 		else { game.say(self, "no hay planta para cosechar") }
 	}
 	method valorTotalCosechadas() {
 		var total=0
 		cosechadas.forEach{ planta => total+=planta.valor() }
 		return total
 	}
 	method venderPlantas() {
 		var mercado=game.getObjectsIn(self.position()).first()
 		if(mercado.puedeComprarPlantas()) {
 			mercado.comprarPlantas()
 			dinero+=self.valorTotalCosechadas()
 			cosechadas.clear()
 			game.showAttributes(mercado)
 		}
 		else {
 			game.say(mercado, "tengo " + mercado.dinero() + " no me alcanza para comprar")
 		}	
 	}
}













