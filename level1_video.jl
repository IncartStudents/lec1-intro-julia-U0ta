# переписать ниже примеры из первого часа из видеолекции: 
#print
println("Hochu spat' :(")

#var

number = 1
typeof(number) #Int64

euler = 2.718
typeof(euler) #Float64 

str = "Bugulma"
typeof(str) #String

#Math BAZA

summa = 10 + 5 #sum = 15
diff = 10 - 5 #diff = 5
prod = 10 * 5 #prod = 50
quot = 10 / 5 #quot = 2
pow = 10 ^ 5 #pow = 100000
mod = 10 % 5 #mod = 0

#strings

s1 = "Stroka"
s2 = """Tozhe stroka"""
# '' - char, NE stroka

#Vivod peremennih
pari_v_chetverg = 5
println("Colichestvo par v cht:\n$pari_v_chetverg")

#concatenate

string("if", "(Julia ==", "Python)")
string("    delete(System", 32, ")")
s3 = "abc"
s4 = "defg" # s3*s4 = "abcdefg" = "$s3$s4"

#slovari (Dictionaries)
pari_v_sredu = Dict(1 => "Fizra", 2 => "IstRoss", 3 => "Inzha") 
#= 
pari_v_sredu[1] = "Fizra"
pari_v_sredu[2]= "IstRoss"
pari_v_sredu[3] = "Inzha"
udalit - pop!(pari_v_sredu, 1/2/3) 
=#

#Cortezhi (Tuples)




# https://youtu.be/4igzy3bGVkQ
# по желанию можно поменять значения и попробовать другие функции