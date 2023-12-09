import visuales.color
import gameEngine.*
import juego.*
import viento.*
import direccion.*

class Cosa {
	var posicion
	const nivel

	method position() = posicion
	method afectar(personaje)
	method avanzar() {
		self.moverse()
		self.ajustarPosicionEnNivel()
		if(posicion.y() < 0) {
			self.salioDePantalla()
		}
	}
	method ajustarPosicionEnNivel() {
		posicion = nivel.posicionAlMoverseA(posicion)
	}
	method salioDePantalla() {
		self.desaparecer()
	}
	method moverse()
	method desaparecer() {
		gameEngine.removeVisual(self)
	}
}

class CosaVertical inherits Cosa {
	override method moverse() {
		posicion = posicion.down(1)
	}
}

class CosaZigZag inherits Cosa {
	const variacionEnX = 2
	var direccion = izquierda
	var deltaRespectoDelXInicial = 0

	override method moverse() {
		posicion = direccion.trasladarPosicion(posicion.down(1), 1)
		deltaRespectoDelXInicial += direccion.sentido()
		if(deltaRespectoDelXInicial.abs() == variacionEnX) {
			direccion = direccion.opuesta()
		}
	}
}

class CosaConParacaidas inherits Cosa {
	override method moverse() {
		posicion = viento.trasladarPosicion(posicion.down(1))
	}
}

class Bomba inherits CosaVertical {
	override method afectar(personaje) {
		personaje.perderUnaVida()
	}
	method text() = "Boom!"
	method textColor() = color.gris()
}
class Dinamita inherits CosaZigZag {
	override method afectar(personaje) {
		personaje.perderUnaVida()
	}
	method text() = "Boom!"
	method textColor() = color.gris()
}
class Granada inherits CosaConParacaidas {
	override method afectar(personaje) {
		personaje.perderUnaVida()
	}
	method text() = "Boom!"
	method textColor() = color.gris()
}
class Manzana inherits CosaVertical {
	override method afectar(personaje) {
		personaje.ganarUnaVida()
	}
	method text() = "<3"
	method textColor() = color.rojo()
}
class Pera inherits CosaZigZag {
	override method afectar(personaje) {
		personaje.ganarUnaVida()
	}
	method text() = "<3"
	method textColor() = color.rojo()
}
class Uvas inherits CosaConParacaidas {
	override method afectar(personaje) {
		personaje.ganarUnaVida()
	}
	method text() = "<3"
	method textColor() = color.rojo()
}

class Moneda inherits CosaVertical {
	var valor
	override method afectar(personaje) {
		personaje.ganarPuntos(valor)
	}
	method text() = "$$$"
	method textColor() = color.verde()
	override method salioDePantalla() {
		super()
		juego.sePerdioUnaMoneda()
	}
}
class Gema inherits CosaZigZag {
	var valor
	override method afectar(personaje) {
		personaje.ganarPuntos(valor)
	}
	method text() = "$$$"
	method textColor() = color.verde()
	override method salioDePantalla() {
		super()
		juego.sePerdioUnaMoneda()
	}
}
class Billete inherits CosaConParacaidas {
	var valor
	override method afectar(personaje) {
		personaje.ganarPuntos(valor)
	}
	method text() = "$$$"
	method textColor() = color.verde()
	override method salioDePantalla() {
		super()
		juego.sePerdioUnaMoneda()
	}
}

