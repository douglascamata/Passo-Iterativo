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

	case m
	when 4
		y_n = y_n_anterior + (h/24)*(55*f_array[n] - 59*f_array[n-1] + 37*f_array[n-2] - 9*f_array[n-3]) 
		
	when 3
		y_n = y_n_anterior + (h/12)*(23*f_array[n] - 16*f_array[n-1] + 5*f_array[n-2]) 
	
	when 2
		y_n = y_n_anterior + (h/2)*(3*f_array[n] - f_array[n-1])

	end	
	
	fc = f(x_n,y_n)
	return [x_n, y_n, fc]
	
end

#Adams-Moulon
def AM(m,h,resultado_AB,xi_and_yi)
	x_n_anterior = xi_and_yi.keys.last
	y_n_anterior = xi_and_yi.values.last

	f_k_anterior = resultado_AB.last

	f = get_fn(xi_and_yi)
	n = f.size - 1

	x_n = resultado_AB.first
	
	if m < 3
		y_n = y_n_anterior + (h/12)*(5*f_k_anterior + 8*f[n] - f[n-1]) 
	else
		y_n = y_n_anterior + (h/24)*(9*f_k_anterior + 19*f[n] - 5*f[n-1] + f[n-2]) 
	end

	fc = f(x_n,y_n)

	return [x_n, y_n, fc]
end

def ABM(m, h, passos_intermediarios, erro, intervalo)
	previsao = AB(m, h, passos_intermediarios)
	correcao = AM(m,h,previsao, passos_intermediarios)

	y_k_anterior = previsao[1]
	y_k = correcao[1]

	while ((y_k - y_k_anterior)/y_k).abs > erro
		prox_correcao = AM(m,h,correcao,passos_intermediarios)
		y_k_anterior = correcao[1]
		y_k = prox_correcao[1]	
		correcao = prox_correcao			
	end
	
	x_n = correcao[0]
	y_n = correcao[1]
	passos_intermediarios[x_n] = y_n

	ABM(m,h,passos_intermediarios,erro,intervalo) if x_n.round(1) < intervalo.last

	return passos_intermediarios
end