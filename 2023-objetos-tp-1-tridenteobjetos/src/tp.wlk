object pepe{
	var categoria
	var bonoResultados
	var bonoPresentismo
	var faltas
	
	method categoria() = categoria
	method categoria(_categoria) {categoria = _categoria}
	
	method neto() {return categoria.netoCategoria()}
	
	method bonoResultados() = bonoResultados
	method bonoResultados(bono) {bonoResultados = bono.tipoDeBono()}
	
	method faltas() = faltas
	method faltas(_faltas) {faltas = _faltas}
	
	method bonoPresentismo() = bonoPresentismo
	method bonoPresentismo(_bono) {bonoPresentismo = _bono.calcularBono(self)}
	
	method sueldo() = categoria.netoCategoria() + bonoResultados + bonoPresentismo
	
	
	
}
object sofia{
	var categoria
	var bonoResultados
	var faltas
	
	method categoria() = categoria
	method categoria(_categoria) {categoria = _categoria}
	
	method neto() {return categoria.netoCategoria()}
	
	method bonoResultados() = bonoResultados
	method bonoResultados(bono) {bonoResultados = bono.tipoDeBono()}
	
	method faltas() = faltas
	method faltas(_faltas) {faltas = _faltas}
	
	method sueldo() = categoria.netoCategoria() + bonoResultados 
	
}
object carla{
	const netoCarla = 28000
	var bonoResultados
	
	method netoCategoria() { return netoCarla }
	
	method bonoResultados() = pepe.bonoResultados()
	method bonoResultados(bono) { pepe.bonoResultados(bono) }
	
	method sueldo() = netoCarla + bonoResultados + 9000
}

object oliver{
	var companero
	const netoOliver = companero.netoCategoria()
	
	method asignarCompanero(nuevoCompanero) {companero = nuevoCompanero }
	
	method netoCategoria() { return netoOliver }
	
	method bonoPresentismo() = demagogico.calcularBono(self)
}
object gerente{
	const netoGerente = 15000
	
	method netoCategoria() {return netoGerente}
	
}
object cadete{
	const netoCadete = 20000
	
	method netoCategoria() {return netoCadete}
}
object vendedor{
	const netoVendedor = 16000
	var aumentoPorMuchasVentas = false
	
	method netoCategoria() {
		if(aumentoPorMuchasVentas) {
			return 20000
		} else {
			return netoVendedor
		}
	}
	
	method activarAumentoPorMuchasVentas() {
		aumentoPorMuchasVentas = true
	}
	
	method desactivarAumentoPorMuchasVentas() {
		aumentoPorMuchasVentas = false
	}
}

/*Bono Resultados */ 

object porcentaje{
	const porcentaje = 10
	
	method tipoDeBono() {return (pepe.neto() * porcentaje) / 100}
}
object fijo{
	const montoFijo = 800
	
	method tipoDeBono() {return montoFijo}
}

/*Bono Presentismo */

object normal{
	
	method calcularBono(persona)
	{
		if(persona.faltas() == 0) {return 2000} 
		else if (persona.faltas() == 1) {return 2000}
		else {return 0}	
	}
}
object ajuste{
	
	method calcularBono(persona)
	{
		if(persona.faltas() == 0) {return 100} 
		else {return 0}	
	}
}
object demagogico{
	
	method calcularBono(persona)
	{
		if(persona.neto() <= 18000) {return 100} 
		else {return 300}	
	}
}
 