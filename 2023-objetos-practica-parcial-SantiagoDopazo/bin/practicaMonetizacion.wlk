class Contenido{
	const titulo
	var property visitas = 0
	var property ofensivo = false
	var property monetizacion
	
	method recaudacion() = monetizacion.recaudacionDe(self)
	method esPopular()
	method recaudacionMaximaPorPublicidad()
	method puedeAlquilarse()
	
	method monetizacion(nuevaMonetizacion){
		self.validarMonetizacion()
		monetizacion = nuevaMonetizacion
	}
	override method initialize(){
		self.validarMonetizacion()
	}
	method validarMonetizacion(){
		if(!monetizacion.puedeAplicarseA(self))
			throw new DomainException(message = "No se puede poner esa forma de monetizacion al contenido")
	}
	
	
	
}
class Video inherits Contenido{
	override method esPopular() = visitas > 10000
	override method recaudacionMaximaPorPublicidad() = 10000
	
	override method puedeAlquilarse() = true
}
class Imagen inherits Contenido{
	const property tags = []
	
	override method esPopular() = tagsDeModa.all{tag => tags.contains(tag)}
	override method recaudacionMaximaPorPublicidad() = 4000
	
	override method puedeAlquilarse() = false
}
const tagsDeModa = ["objetos","pdep", "wow"]

// MONETIZACIONES //

object publicidad{
	method recaudacionDe(contenido) = (
		0.05 * contenido.visitas() + self.plus(contenido)
	).min(contenido.recaudacionMaximaParaPublicidad())
	
	method plus(contenido) = if(contenido.esPopular()) 2000 else 0
	
	method puedeAplicarseA(contenido) = !contenido.ofensivo()
}
class Donaciones{
	var property donacion = 0
	method recaudacionDe(contenido) = donacion
	
	method puedeAplicarseA(contenido) = true
}
class VentaDeDescarga{
	const property precio
	
	/*method initialize(){
		if(precio < 5) throw new DomainException(message = "Es muy barato")
	}*/
	
	method recaudacionDe(contenido) = contenido.visitas() * precio
	
	method puedeAplicarseA(contenido) = contenido.esPopular()
}
class Alquieler inherits VentaDeDescarga{
	override method precio() = 1.max(super())
	override method puedeAplicarseA(contenido) = super(contenido) && contenido.puedeAlquilarse()
}

// USUARIOS //
object usuarios{
	const todosLosUsuarios = []
	
	method emailsDeUsuariosRicos() = todosLosUsuarios
		.filter{usuario => usuario.verificado()}
		.sortedBy{uno, otro => uno.saldoTotal() > otro.saldoTotal()}
		.take(100)
		.map{usuario => usuario.email()}
	method cantidadDeSuperUsuarios() = todosLosUsuarios.count{usuario => usuario.esSuperUsuario()}
}
class Usuario{
	const property email
	const property nombre
	var property verificado = false
	const contenidos = []
	
	method saldoTotal() = contenidos.sum{contenido => contenido.recaudacion()}
	method esSuperUsuario() = contenidos.count{contenido => contenido.esPopular()} >= 10
	
	method publicarContenido(contenido){
		contenidos.add(contenido)
	}
	
}
