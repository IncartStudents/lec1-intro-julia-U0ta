# Выболнить большую часть заданий ниже - привести примеры кода под каждым комментарием


#===========================================================================================
1. Переменные и константы, области видимости, cистема типов:
приведение к типам,
конкретные и абстрактные типы,
множественная диспетчеризация,
=#

# Что происходит с глобальной константой PI, о чем предупреждает интерпретатор?
const PI = 3.14159
PI = 3.14 #Предупреждает об изменении константы, но не блокирует это изменение(если проверим значение PI оно будет 3.14)

# Что происходит с типами глобальных переменных ниже, какого типа `c` и почему?
a = 1
b = 2.0
c = a + b #Джулия приводит а к Float64 т к этот тип позволяет созранить больше информации, и по итогу сложения двух Float64 получаем с(Float64)

# Что теперь произошло с переменной а? Как происходит биндинг имен в Julia?
a = "foo" #Джулия связывает именя переменных с их значениями, т. е. любое значение любого типа можно привязать к переменной а

# Что происходит с глобальной переменной g и почему? Чем ограничен биндинг имен в Julia?
g::Int = 1 #= мы явно объявляем g, но при попытке изменить ее значение(и тип) компилятор выдает ошибку,
т.к. за переменной закреплен тип Int64
=#
g = "hi"

function greet()
    g = "hello" # Тут переменная g локальная (никак не связана с внешней глобальной переменной g)
    println(g)
end
greet()

# Чем отличаются присвоение значений новому имени - и мутация значений?
v = [1,2,3]
z = v #Тут не создается копия массива v, а за уже существующим закрепляется новое имя z
v[1] = 3 #Следовательно при попытке изменить значение по имени и индексу это изменение коснется всех имен, т.к. они привязаны к одному и тому же массиву
v = "hello" #v получает новое значение другого типа и больше не отвечает за массив
z

# Написать тип, параметризованный другим типом

struct MyContainer{T}
    value::T
end

# Пример использования
container_int = MyContainer{Int}(10)
container_str = MyContainer{String}("Hello")

#=
Написать функцию для двух аругментов, не указывая их тип,
и вторую функцию от двух аргментов с конкретными типами,
дать пример запуска
=#

# Функция без указания типов
function add(a, b)
    return a + b
end

# Функция с конкретными типами
function add_int(a::Int, b::Int)
    return a + b
end

# Пример запуска
println(add(1, 2))        # 3
println(add(1.5, 2.5))    # 4.0
println(add_int(1, 2))    # 3
# println(add_int(1.5, 2.5))  # Ошибка: метод не определён для Float64

#=
Абстрактный тип - ключевое слово? abstract type
Примитивный тип - ключевое слово? Int64,Float64 и т.д.
Композитный тип - ключевое слово? struct
=#

abstract type Animal end

struct Dog <: Animal end
struct Cat <: Animal end

# Функция для абстрактного типа
function make_sound(animal::Animal)
    println("Some sound")
end

# Функция для подтипа Dog
function make_sound(dog::Dog)
    println("Woof!")
end

# Пример запуска
make_sound(Dog())  # Woof!
make_sound(Cat())  # Some sound

#=
Написать один абстрактный тип и два его подтипа (1 и 2)
Написать функцию над абстрактным типом, и функцию над её подтипом-1
Выполнить функции над объектами подтипов 1 и 2 и объяснить результат
(функция выводит произвольный текст в консоль)
=#


#===========================================================================================
2. Функции:
лямбды и обычные функции,
переменное количество аргументов,
именованные аргументы со значениями по умолчанию,
кортежи
=#

# Пример обычной функции
function greet(name)
    println("Hello, $name!")
end
greet("Alice")

# Пример лямбда-функции (аннонимной функции)
greet = name -> println("Hello, $name!")
greet("Bob")

# Пример функции с переменным количеством аргументов
function sum_all(args...)
    return sum(args)
end
println(sum_all(1, 2, 3, 4))  # 10

# Пример функции с именованными аргументами
function greetings(; name="Guest", greeting="Hello")
    println("$greeting, $name !")
end
greetings(name="Alice", greeting="Hi")  # Hi, Alice ! 
greetings()  # Hello, Guest !

# Функции с переменным кол-вом именованных аргументов
function greet(; kwargs...)
    for (key, value) in kwargs
        println("$key: $value")
    end
end
greet(name="Alice", age=30)

#=
Передать кортеж в функцию, которая принимает на вход несколько аргументов.
Присвоить кортеж результату функции, которая возвращает несколько аргументов.
Использовать splatting - деструктуризацию кортежа в набор аргументов.
=#
function add(a, b)
    return a + b
end

args = (1, 2)
println(add(args...))  # 3

function return_tuple()
    return (1, 2, 3 ,4)
end

tup1 = return_tuple()

a1, b1, c1, d1 = tup1

#===========================================================================================
3. loop fusion, broadcast, filter, map, reduce, list comprehension
=#

#=
Перемножить все элементы массива
- через loop fusion и
- с помощью reduce
=#
arr = [1, 2, 3, 4]

# Loop fusion
result = 1
for x in arr
    result *= x
end
println(result)  # 24

# Reduce
using Base: reduce
println(reduce(*, arr))  # 24
#=
Написать функцию от одного аргумента и запустить ее по всем элементам массива
с помощью точки (broadcast)
c помощью map
c помощью list comprehension
указать, чем это лучше явного цикла? Явный цикл будет громоздким и не оптимизированным, по сравнению с этими методами.
=#
f(x) = x^2

# Broadcast
println(f.(arr))  # [1, 4, 9, 16]

# Map
println(map(f, arr))  # [1, 4, 9, 16]

# List comprehension
println([f(x) for x in arr])  # [1, 4, 9, 16]

# Перемножить вектор-строку [1 2 3] на вектор-столбец [10,20,30] и объяснить результат

row = [1 2 3]
col = [10, 20, 30]
println(row * col)  # [140] (скалярное произведение)

# В одну строку выбрать из массива [1, -2, 2, 3, 4, -5, 0] только четные и положительные числа

arr = [1, -2, 2, 3, 4, -5, 0]
println(filter(x -> x > 0 && x % 2 == 0, arr))  # [2, 4]

# Объяснить следующий код обработки массива names - что за number мы в итоге определили?
using Random
Random.seed!(123)
namess0 = [rand('A':'Z') * '_' * rand('0':'9') * rand([".csv", ".bin"]) for _ in 1:100]
# Инициализация массива, состоящего из имен, таких как: A_1.csv , B_2.bin и т. д.
same_names = unique(map(y -> split(y, ".")[1], filter(x -> startswith(x, "A"), namess0))) # оставляем именя начинающиеся с А, убираем расширение и дубликаты
numbers = parse.(Int, map(x -> split(x, "_")[end], same_names)) # в same_names убираем все, кроме последнего элемента и парсим его в инт
numbers_sorted = sort(numbers) # сортируем массив из чисел
number = findfirst(n -> !(n in numbers_sorted), 0:9) # ищем первое пропущенное число от 0 до 9 в массиве
# итоговый намбер - это первое пропущенное число от 0 до 9 в массиве 

# Упростить этот код обработки:
using Random
Random.seed!(123)

# Генерация массива names
namess = [rand('A':'Z') * "_" * rand('0':'9') * rand([".csv", ".bin"]) for _ in 1:100]

# Обработка names
number = findfirst(!in(sort(parse.(Int, last.(split.(first.(split.(filter(startswith("A"), namess), ".")), "_")))),0:9))

#===========================================================================================
4. Свой тип данных на общих интерфейсах
=#

#=
написать свой тип ленивого массива, каждый элемент которого
вычисляется при взятии индекса (getindex) по формуле (index - 1)^2
=#
struct LazyArray
    length::Int
end

Base.getindex(arr::LazyArray, i::Int) = (i - 1)^2

arr = LazyArray(10)
println(arr[5])  # 16
#=
Написать два типа объектов команд, унаследованных от AbstractCommand,
которые применяются к массиву:
`SortCmd()` - сортирует исходный массив
`ChangeAtCmd(i, val)` - меняет элемент на позиции i на значение val
Каждая команда имеет конструктор и реализацию метода apply!
=#
abstract type AbstractCommand end
apply!(cmd::AbstractCommand, target::Vector) = error("Not implemented for type $(typeof(cmd))")


# Аналогичные команды, но без наследования и в виде замыканий (лямбда-функций)


#===========================================================================================
5. Тесты: как проверять функции?
=#

# Написать тест для функции

using Test

@testset "Test add function" begin
    @test add(1, 2) == 3
    @test add(1.5, 2.5) == 4.0
end

#===========================================================================================
6. Дебаг: как отладить функцию по шагам?
=#

#=
Отладить функцию по шагам с помощью макроса @enter и точек останова
=#
using Debugger

function buggy_function(x)
    y = x + 1
    z = y / 0  # Ошибка деления на ноль
    return z
end

Debugger.@enter buggy_function(1)
#===========================================================================================
7. Профилировщик: как оценить производительность функции?
=#

#=
Оценить производительность функции с помощью макроса @profview,
и добавить в этот репозиторий файл со скриншотом flamechart'а
=#
using ProfileView
function generate_data(len)
    vec1 = Any[]
    for k = 1:len
        r = randn(1,1)
        append!(vec1, r)
    end
    vec2 = sort(vec1)
    vec3 = vec2 .^ 3 .- (sum(vec2) / len)
    return vec3
end

ProfileView.@time generate_data(1_000_000); #flamechart не пашет(окно не вылезает)


# Переписать функцию выше так, чтобы она выполнялась быстрее:


#===========================================================================================
8. Отличия от матлаба: приращение массива и предварительная аллокация?
=#

#=
Написать функцию определения первой разности, которая принимает и возвращает массив
и для каждой точки входного (x) и выходного (y) выходного массива вычисляет:
y[i] = x[i] - x[i-1]
=#

#=
Аналогичная функция, которая отличается тем, что внутри себя не аллоцирует новый массив y,
а принимает его первым аргументом, сам массив аллоцируется до вызова функции
=#

#=
Написать код, который добавляет элементы в конец массива, в начало массива,
в середину массива
=#


#===========================================================================================
9. Модули и функции: как оборачивать функции внутрь модуля, как их экспортировать
и пользоваться вне модуля?
=#


#=
Написать модуль с двумя функциями,
экспортировать одну из них,
воспользоваться обеими функциями вне модуля
=#
module Foo
    #export ?
end
# using .Foo ?
# import .Foo ?


#===========================================================================================
10. Зависимости, окружение и пакеты
=#

# Что такое environment, как задать его, как его поменять во время работы?

# Что такое пакет (package), как добавить новый пакет?

# Как начать разрабатывать чужой пакет?

#=
Как создать свой пакет?
(необязательно, эксперименты с PkgTemplates проводим вне этого репозитория)
=#


#===========================================================================================
11. Сохранение переменных в файл и чтение из файла.
Подключить пакеты JLD2, CSV.
=#

# Сохранить и загрузить произвольные обхекты в JLD2, сравнить их

# Сохранить и загрузить табличные объекты (массивы) в CSV, сравнить их


#===========================================================================================
12. Аргументы запуска Julia
=#

#=
Как задать окружение при запуске?
=#

#=
Как задать скрипт, который будет выполняться при запуске:
а) из файла .jl
б) из текста команды? (см. флаг -e)
=#

#=
После выполнения задания Boids запустить julia из командной строки,
передав в виде аргумента имя gif-файла для сохранения анимации
=#
