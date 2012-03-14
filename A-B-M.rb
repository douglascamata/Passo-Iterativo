#encoding: utf-8
def get_fn(xi_and_yi)
	fn = []
	xi_and_yi.each do |xi,yi|
			fn << f(xi,yi)
	end

	return fn
end

#Adams-Bashforth
def AB(m, h, xi_and_yi)
	x_n_anterior = xi_and_yi.keys.last
	y_n_anterior = xi_and_yi.values.last
	
	f_array = get_fn(xi_and_yi)
	n = f_array.size - 1 #porque array começam com indice 0

	x_n = x_n_anterior + h
	y_n = y_n_anterior + (h/24)*(55*f_array[n] - 59*f_array[n-1] + 37*f_array[n-2] - 9*f_array[n-3]) 
	
	fc = f(x_n,y_n)
	
	return [x_n, y_n, fc]
	
end

#Adams-Moulon
def AM(h,resultado_AB,xi_and_yi)
	x_n_anterior = xi_and_yi.keys.last
	y_n_anterior = xi_and_yi.values.last

	f_k_anterior = resultado_AB.last

	f = get_fn(xi_and_yi)
	n = f.size - 1

	x_n = resultado_AB.first
	y_n = y_n_anterior + (h/24)*(9*f_k_anterior + 19*f[n] - 5*f[n-1] + f[n-2]) 

	fc = f(x_n,y_n)

	return [x_n, y_n, fc]
end

def ABM(m, h, passos_intermediarios, erro)
	previsao = AB(m, h, passos_intermediarios)
	correcao = AM(h,previsao, passos_intermediarios)

	y_k_anterior = previsao[1]
	y_k = correcao[1]

	while ((y_k - y_k_anterior)/y_k).abs > erro
		prox_correcao = AM(h,correcao,passos_intermediarios)
		y_k_anterior = correcao[1]
		y_k = prox_correcao[1]	
		correcao = prox_correcao			
	end
	
	x_n = correcao[0]
	y_n = correcao[1]
	passos_intermediarios[x_n] = y_n

	return passos_intermediarios
end