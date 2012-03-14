def rk4(x_atual, y_atual, h, intervalo)
	resultados = {x_atual => y_atual}

	while x_atual < intervalo.last
		k1 = f(x_atual,y_atual)
		k2 = f(x_atual + h/2, y_atual + (h/2)*k1)
		k3 = f(x_atual + h/2, y_atual + (h/2)*k2)
		k4 = f(x_atual + h, y_atual + h*k3)

		y_prox = y_atual + (h/6)*(k1 + 2*k2 + 2*k3 + k4)
		
		x_atual += h
		resultados[x_atual] = y_prox
		y_atual = y_prox
	end

	return resultados
end

def rk2(x_atual, y_atual, h, intervalo)
	resultados = {x_atual => y_atual}

	while x_atual < intervalo.last

		y_prox = y_atual + h*f(x_atual + h/2, y_atual + (h/2)*f(x_atual,y_atual))
		
		x_atual += h
		resultados[x_atual] = y_prox
		y_atual = y_prox
	end

	return resultados
end