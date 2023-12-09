class SuperComputadoras{
	const equipos = []
	
	method equiposActivos() = equipos.filter{equipo => equipo.estaActivo()}
	
	method estaActivo() = true
	method computo() = self.equiposActivos().sum{equipo => equipo.computo()}
	method consumo() = self.equiposActivos().sum{equipo => equipo.consumo()}
	
	method equipoQueMasConsume() = self.equiposActivos().max{equipo => equipo.consumo()}
	method equipoQueMasComputa() = self.equiposActivos().max{equipo => equipo.computo()}
	method malConfigurada() = self.equipoQueMasConsume() != self.equipoQueMasComputa()
	
	method equipoActivoQueMas(criterio) = self.equiposActivos().max(criterio)
}

object standard{
	method consumoDe(equipo) = equipo.consumoBase()
	method computoDe(equipo) = equipo.computoBase()
}
class Overclock{
	method consumoDe(equipo) = equipo.consumoBase() * 2
	method computo(equipo) = equipo.computoBase() + equipo.computoExtraPorOverclock()
}
class AhorroDeEnergia{
	method consumoDe(equipo) = 200
	method computoDe(equipo) = equipo.consumo() / equipo.consumoBase() * equipo.ComputoBase()
}
class Equipo{
	var property modo = standard
	var property estaQuemado = false
	
	method estaActivo() = !estaQuemado && self.computo() > 0
	method consumo() = modo.consumoDe(self)
	method computo() = modo.ComputoDe(self)
	
	method consumoBase()
	method computoBase()
	method computoExtraPorOverclock()
}
class A105 inherits Equipo {
	override method consumoBase() = 300
	override method computoBase() = 600
	override method computoExtraPorOverclock() = self.computoBase() * 0.3
}
class B2 inherits Equipo {
	const property microChips
	
	override method consumoBase() = 10 + 50 * microChips
	override method computoBase() = 800.min(100*microChips)
	
	override method computoExtraPorOverclock() = microChips * 20
}