class Tipo {
	var edad
	var energia = 0
	const pasion
	const property porcentajeDeporte 

	method edad ()= edad
	method edad (_edad){edad=_edad}
	
	method energia() =energia
	method energia(_edad) {energia =10000-30*_edad}
	
	method hacerPasion() {energia = pasion.calcularEnergia(self)}
	
	method descansar() {self.energia(edad)}
	
}

object emborracharYPelear {
	method calcularEnergia(tipo)= if(tipo.energia()>=100) 100 else tipo.energia()

}
object hablarDeFutbol{
	method calcularEnergia(tipo)= tipo.energia()-150	
	
}
object hacerDeporte {
 
 method calcularEnergia(tipo) =	tipo.energia()*(tipo.porcentajeDeporte()/100)
}


const andretta = new Tipo (edad = 60, pasion = hablarDeFutbol, porcentajeDeporte = 1)
const pabloSandoval = new Tipo (edad = 54, pasion = emborracharYPelear, porcentajeDeporte = 1)
const  manuGinobilli = new Tipo (edad = 45, pasion = hacerDeporte, porcentajeDeporte = 85)
const carlosBilardo = new Tipo (edad = 84, pasion = hablarDeFutbol, porcentajeDeporte = 1)
const francoMilazzo = new Tipo (edad = 34, pasion = hacerDeporte, porcentajeDeporte = 63)



