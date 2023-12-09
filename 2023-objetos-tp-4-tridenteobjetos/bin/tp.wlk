/* PUNTO 1 */
class Maestro{
	var property habilidad
	
	method calcularPoder()
	
	method esGroso(){
		return self.calcularPoder() > 1000 && habilidad > 5
	}
}

class MaestroAgua inherits Maestro{
	
	override method calcularPoder() = habilidad + luna.intensidadLuna() * 5
	method esPeligroso() = self.calcularPoder() > 100
}
object luna{
	var property intensidadLuna = 300
}
class MaestroFuego inherits Maestro{
	var property rabia
	var property locura
	
	override method calcularPoder() = rabia/locura
}
class Mascota{
	var property poderMascota
	
}
class MaestroAire inherits Maestro{
	var property ligereza
	var mascota 
	override method calcularPoder() = mascota.poderMascota() * ligereza
}

/* PUNTO 2 */
class MaestroSangre inherits MaestroAgua {
	override method esPeligroso() = true
	override method calcularPoder() = super() * 2
}


