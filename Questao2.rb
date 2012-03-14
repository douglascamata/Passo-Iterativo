#encoding: utf-8
require './letsGo.rb'
include Math

def f(x,y)
	x*y + sqrt(y)
end

m = 4
x0 = 0
y0 = 1
intervalo = 0..1
h = 0.1
ordem_do_runge_kutta = 4
erro = 10**(-6)

aproximar_pvi(m,intervalo,h,x0,y0,ordem_do_runge_kutta, erro)

h = 0.2
puts
aproximar_pvi(m,intervalo,h,x0,y0,ordem_do_runge_kutta, erro)