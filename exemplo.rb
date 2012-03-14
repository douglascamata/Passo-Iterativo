#encoding: utf-8
require './letsGo.rb'
include Math

def f(x,y)
	-y**2
end

m = 3
intervalo = 1..2
h = 0.1
x0 = 1
y0 = 1
ordem_do_runge_kutta = 4
erro = 10**(-6)

aproximar_pvi(m,intervalo,h,x0,y0,ordem_do_runge_kutta, erro)