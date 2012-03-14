#encoding: utf-8
require './RK.rb'
require './A-B-M.rb'

def aproximar_pvi(m,intervalo,h,x0,y0,rk,erro)
	intervalo_rk = (intervalo.first)..(intervalo.first + (m-1)*h)
	
	if rk == 2
		passos_intermediarios = rk2(x0, y0, h, intervalo_rk)
	elsif rk == 4
		passos_intermediarios = rk4(x0, y0, h, intervalo_rk)
	else
		raise 'Runge-Kutta só pode ser de ordem 2 ou 4'
	end

	ABM(m,0.1,passos_intermediarios,erro)
end