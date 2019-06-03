import wollok.game.*

class Maiz{
	var property image="corn_baby.png"
	
	method estasSiendoRegada(){
		if(image=="corn_baby.png"){
			self.image("corn_adult.png")
		}
	}
	method estasSiendoCosechada(){
		if(self.esAdulto()){
		    hector.guardarPlantaParaVender(self)
			game.removeVisual(self)
		
		}
	}
	method esAdulto(){
		return image=="corn_adult.png"
	}
	method valorDeLaPlanta(){
		return 150
	}
}

class Trigo{
	var evoluciones=["wheat_0.png","wheat_1.png","wheat_2.png","wheat_3.png"]
	var property image="wheat_0.png"
	var numeroDeEvolucion=0
		method estasSiendoRegada(){
			if(numeroDeEvolucion<3){
			self.image(evoluciones.get(numeroDeEvolucion+1))
			numeroDeEvolucion+=1
		}
		else{numeroDeEvolucion-=3
			 self.image(evoluciones.get(numeroDeEvolucion))
		}
     }
     method estasSiendoCosechada(){
		if(numeroDeEvolucion>=2){
		    hector.guardarPlantaParaVender(self)
		    game.removeVisual(self)
			
		}
	}
	method valorDeLaPlanta(){
		return (numeroDeEvolucion-1)*100
	}
}
class Tomaco{
	var property image="tomaco.png"
	method estasSiendoRegada(){
	      game.removeVisual(self)
	      game.addVisualIn(self,self.posicionNueva())
	      }
	method posicionNueva(){
		return hector.position().up(1)
	}
	method estasSiendoCosechada(){
		hector.guardarPlantaParaVender(self)
		game.removeVisual(self)
	}
	method valorDeLaPlanta(){
		return 80
	}      
}

object hector {
	var property plantasParaVender=[]
	var property oroAcumulado=0
	var property position=game.at(5,5)
	method image(){
		return "player.png"
	}
	
	method guardarPlantaParaVender(planta){
		plantasParaVender=[plantasParaVender.add(planta)]
	}
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	method sembrarMaiz(){
		game.addVisualIn(new Maiz(),self.position())
	}
	method sembrarTrigo(){
	    game.addVisualIn(new Trigo(),self.position())
	}
	method sembrarTomaco(){
		game.addVisualIn(new Tomaco(),self.position())
	}
	method regar(objetosQueColisionan){
		if(objetosQueColisionan==[]){
			return throw new Exception("no hay planta para regar") 
		}
		else{return objetosQueColisionan.forEach({planta=>planta.estasSiendoRegada()}) }
		}
	method cosechar(plantasDondeEstoyParado){
		if(plantasDondeEstoyParado==[]){
			return throw new Exception ("no hay plantas para cosechar")
		}
		else{return plantasDondeEstoyParado.first().estasSiendoCosechada()
			/*plantasDondeEstoyParado.forEach({planta=>planta.estasSiendoCosechada()})*/
		}
	}
	
	method venderCosecha(){
		oroAcumulado=oroAcumulado+(plantasParaVender.map{planta=>planta.valorDeLaPlanta()}.sum())
		plantasParaVender= []
	}
}
//asdasd
