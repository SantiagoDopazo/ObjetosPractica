class Empleado{
	var property salud = 100
	var property  puesto
	var property habilidades = []
	
	method estaIncapacitado() = salud <= puesto.saludCritica()
	
	method puedeUsar(habilidad) = !self.estaIncapacitado() && self.poseeHabilidad(habilidad)
	method poseeHabilidad(habilidad) = habilidades.contain(habilidad)
	
	method recibirDanio(cantidad) {salud -= cantidad}
	
	method estaVivo() = salud > 0
	
	method finalizarMision(mision){
		if(self.estaVivo()){
			self.completarMision(mision)
		}
	}
	method completarMision(mision){
		puesto.completarMision(mision, self)
	}
	
	method aprender(habilidad){
		habilidades.add(habilidad)
	}
	
	
}
class Jefe inherits Empleado{
	var property subordinados
	
	override method poseeHabilidad(habilidad) = super(habilidad) || self.algunoDeSusSubordinadosLaPuedeUsar(habilidad)
	method algunoDeSusSubordinadosLaPuedeUsar(habilidad) = subordinados.any{subordinado => subordinado.puedeUsar(habilidad)}

}
// PUESTO //
object espias{
	method saludCritica() = 15
	
	method completarMision(mision, empleado){
		mision.enseniarHabilidades(empleado)
	}
}
class Oficinistas{
	var property estrellas = 0
	
	method saludCritica() = 40 - 5 * estrellas
	
	method completarMision(mision, empleado){
		estrellas +=1
		if(estrellas == 3){
			empleado.puesto(espias)
		}
	}
}
class Equipo{
	const empleados = []
	
	method puedeUsar(habilidad) = empleados.any{empleado => empleado.puedeUsar(habilidad)}
	
	method recibirDanio(cantidad){
		empleados.forEach{empleado => empleado.recibirDanio(cantidad/3)}
	}
	method finalizarMision(mision){
		empleados.forEach{empleado => empleado.finalizarMision(mision)}
	}
}
// MISION //
class Mision{
	var property peligrosidad
	var property habilidadesRequeridas = []
	
	method serCumplida(asignado){
		self.validarHabilidades(asignado)
		asignado.recibirDanio(peligrosidad)
		asignado.completarMision(self)
			
	}
	method validarHabilidades(asignado){
		if(!self.reuneHabilidadesRequeridas(asignado))
			throw new  DomainException(message = "La mision no se puede cumplir")
			
	}
	method reuneHabilidadesRequeridas(asignado) = habilidadesRequeridas.all{hab => asignado.puedeUsar(hab)}
	
	method habilidadesQueNoPosee(empleado) = 
		habilidadesRequeridas.filter{hab => !empleado.poseeHabilidad()}
		
	method enseniarHabilidades(empleado){
		self.habilidadesQueNoPosee(empleado)
		.forEach{hab => empleado.aprender(hab)}	
	}

}





