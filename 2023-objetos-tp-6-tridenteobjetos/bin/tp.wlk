class Cuenta{
	var saldo
	var property transacciones = []
	var property avisoAlBanco = false
	
	method verSaldo() = saldo
	
	method depositarDinero(cantidad){
		saldo += cantidad
	}
	method retirarDinero(cantidad){
		if(cantidad > saldo)
			throw new SinSaldoSuficienteException(saldo = saldo)
		saldo -= cantidad
	}
	method transaccion (cuenta, cantidad){
		self.corroborarLimite()
		cuenta.retirarDinero(cantidad)
		self.depositarDinero(cantidad)
		transacciones.add(new Date())
	}
	method avisarAlBanco(){
		avisoAlBanco = true
	}
	method corroborarLimite(){
		if(self.excedeLimiteDeTransferencias()){
			if(!avisoAlBanco){
				throw new LimiteDeTransacciones(message= "Avise al Banco para recibir mas")
			}
		}
	}
	method excedeLimiteDeTransferencias()= transacciones
	.filter{transaccion => transaccion.month() == new Date().month()}
	.size() > 4	
}

class SinSaldoSuficienteException inherits DomainException{
	const property saldo
}
class LimiteDeTransacciones inherits DomainException{
}

const cuentaS = new Cuenta (saldo = 10)
const cuentaM = new Cuenta (saldo = 20)