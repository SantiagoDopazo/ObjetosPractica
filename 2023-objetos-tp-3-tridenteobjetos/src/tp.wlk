
class Carrito {
	
	var property productos = []
	
	method agregarProducto(producto){
		
		productos.add(producto)
	}
	
	method total() = productos.sum{producto => producto.precio()}
	
	method sacar(producto){
		productos.remove(producto)
	}
	method limpiarCarrito(){
		productos.clear()
	}
	
}

class Producto{
	const property precio
	const property id
}

class Compra{
	var property totalCompra
	var property productosVendidos = []
	
}

object superMercado{
	var property ventas = []
	
	method realizarCompra(carrito){
		
		ventas.add(new Compra(totalCompra = carrito.total(),productosVendidos = carrito.productos()))
		
		carrito.limpiarCarrito()
	}
	
	method listaDeLosProductos() = ventas.map{compra => compra.productosVendidos()}
	method listaConUnicoProducto(producto) = self.listaDeLosProductos().filter{productos => productos == producto}
	method ordenarListaPorPrecio(listaDeProductos) = listaDeProductos.sortedBy{producto1, producto2=> producto1.precio() > producto2.precio()}
	
	method productoPrecioMasCaro(listaDeProductos) = self.listaDeLosProductos().max{producto => producto.precio()}
	method productoPrecioMasBarato(listaDeProductos) = self.listaDeLosProductos().min{producto => producto.precio()}
	
	method totalFacturado() = ventas.sum{compra => compra.totalCompra()}
	method productoMasVendido() = self.listaDeLosProductos().max{producto => producto.ocurrenceOff(producto)}
	method idDelProductoMasVenddido() = self.productoMasVendido().id()
	
	method actualizarPrecioDeProducto(producto, precioNuevo) = producto.precio(precioNuevo)
	
	method aumentoDeProducto(producto) = self.productoPrecioMasCaro(self.listaConUnicoProducto(producto)) - self.productoPrecioMasBarato(self.listaConUnicoProducto(producto))
}

// PRODUCTOS //
const grogPackx6 = new Producto(precio = 300, id = 6)
const packFiguritasMundial = new Producto(precio = 15000, id = 10)
const grogPackx6NuevoPrecio = new Producto(precio = 500, id = 6)

const carrito1 = new Carrito(productos = [grogPackx6,packFiguritasMundial])
const carrito2 = new Carrito(productos = [grogPackx6NuevoPrecio])

