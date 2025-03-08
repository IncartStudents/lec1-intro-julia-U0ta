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

s5 = string("if", "(Julia == ", "Python)")
s6 = string("    delete(System", 32, ")")
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

myfavplanes = ("MIG - 23ML", "F-16", "SU - 34")
#myfavplanes[1] "MIG - 23ML"; myfavplanes[2] "F-16"
# myfavplanes[1] = "MIG - 21" - ERROR

#Arrays 

odnocursniki = ["Nikita", "Roma", "Vova", "Vitya"] # s intami: [1, 2, 3, ...]
mixarr = [2, "Imbir'", 2.718] #mozhno peremeshivat raznye tipy dannyh
pop!(mixarr) #delete last element
push!(mixarr, "smth") #dobavit' new element (v konec)

#Array of arrays
numss = [[1, 2, 3], [4, 5, 6]] #analogichno so string
#Zapolneniye
numss2 = zeros(2, 3)
numss3 = rand(2, 3)

#Loops (cicly)
newvar = 0
while(newvar < 10)
    global newvar += 1 #bez global rugaetsya
    println(newvar)
end
println("\n")
for i in 1:10
    println(i)
end

bobs = ["bob1", "bob2", "bob3", "bob4"]
for bob in bobs
    println("$bob gotov!")
end

sz1, sz2 = 3, 5
A = zeros(sz1, sz2)
for i in 1:sz1
    for j in 1:sz2
        A[i,j] = i + j;
    end
end

B = zeros(sz1, sz2)
for i in 1:sz1, j in 1:sz2
    B[i,j] = i + j 
end

C = [i + j for i in 1:sz1, j in 1:sz2] #krasivo

#conditionals (usloviya)

x = 10

if x > 5
    println("x bolshe 5")
elseif x == 5
    println("x ravno 5")
else
    println("x menshe 5")
end

y1, y2, y3 = 10, 20, 30
(y1 > y3) ? y2 : y3
#= 
if y1
    y2
else
    y3
end
=#

z1, z2 = 10, 20
(z1 > z2) && println("$z1 bigger than $z2")

#functions

square(x) = x^2
println(square(4))

#DT
function add(a, b) #a, b libo string libo int/float, t. k. podderzh opp "+" (princip DT)
    return a * b
end

println(add(2, 3))
println(add("Hello, ", "World")) 

#anon func (lambda)
l2 = nm1 -> println("$nm1, hi")
l2("Leha")

#mut vs non-mut func

arrnm = [4, 10, 7 ,9]

#non-mut
sort(arrnm)

#mut
sort!(arrnm)

#broadcasting
n = 3
arr = [i + j for i in 1:n, j in 1:n]
println(arr .^ 2) 
println(arr ^ 2)

#packages (Pkg.add("Example") tolko v perviy raz)

using Pkg
#Pkg.add("Example")  
using Example
hello("World") 

#plots
#Pkg.add("Plots")
using Plots
x = 1:10
y = x.^2
plot(x, y, label="y = x^2")
scatter!(x, y, label="Points")
yflip!()
xflip!()

#mult disp

function foo(x::Int, y::Int)
    println("Dva inta")
end

function foo(x::String, y::String)
    println("Dve stroki")
end

foo(1, 2)          
foo("a", "b")      

#basic linal

A1 = rand(3,3)
B1 = A1
C1 = copy(A1)
A1[1] = 20 #posle etogo B1 != C1
#Transpose of A is A'

#matrix of x in A * x = b

A = [1 2; 3 4; 5 6]
b = [7, 8, 9]
x = A \ b
println(x)

A = [1 2; 3 4]
B = [5, 6]

println(A * B)      
println(det(A))     
println(inv(A))    
# https://youtu.be/4igzy3bGVkQ
# по желанию можно поменять значения и попробовать другие функции