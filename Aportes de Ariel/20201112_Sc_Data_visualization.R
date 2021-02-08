#Fecha: 12-11-20
#Título: Data visualization
# Este es un documento complementario al notebook, donde recogeré únicamente los
#ejecutables

library(tidyverse)

View(mpg)
?mpg #help(mpg)


ggplot(data = mpg) +  # Se inicia llamando a la función ggplot y se crea un gráfico vacío, solo sabiendo qué set usará. El (+) agrega una capa.
  geom_point(mapping = aes(x = displ, y = hwy)) # Añade la capa de puntos para el gráfico


# Vamos a generar un gráfico donde el color de las marcas dependerá de cada variable
# En este caso, en el dataset mpg hay una columna que indica la "clase del coche"
# que se llama class --> la asignaremos al color, en este caso, la variable
# color puede ser en inglés americano o británico (color = colour)

ggplot(data = mpg) +  
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# Ahora vamos a "mapear" el tamaño de los puntos, según la categoría

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

# Ahora podríamos usar la estética de alfa para gestionar la opacidad/ transparencia
# para eso se usa el parámetro alpha.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Ahora podríamos cambiar la forma de los puntos. Sin embargo, ggplot no puede
# manejar más de 6 formas a la vez. 

ggplot(data = mpg) +
  
  geom_point(mapping = aes(x = displ, 
                           y = hwy, 
                           shape = class)
  )



# También podemos elegir directamente las estéticas. Observar que está fuera del 
# mapping, lo cual daría una estética global. Por ejemplo:
# Nombre del color en formato string = "xx"
#  size = tamaño del punto en mm
# shape = forma del punto con números desde el 0 al 25


# ggplot(data = mpg)+
#   geom_point(mapping = aes(x=displ, y=hwy), color = "red")
# 
# d=data.frame(p=c(0:25))
# ggplot() +
#   scale_y_continuous(name="") +
#   scale_x_continuous(name="") +
#   scale_shape_identity() +
#   geom_point(data=d, mapping=aes(x=p%%16, y=p%/%16, shape=p), size=5, fill="yellow") +
#   geom_text(data=d, mapping=aes(x=p%%16, y=p%/%16+0.25, label=p), size=3)

# Si quisiéramos hacer un gráfico de cada una de las variables, o para divivir el 
# gráfico en subgráficos, haremos un facet. En este caso, vamos a usar la 
# variable del tipo de coche (class) y que se vea en 2 filas

# FACETS y se usa así:
# facets_wrap (~<Formula_variable>): la variable debe ser discreta/categórica

ggplot(data = mpg) +
  geom_point (mapping = aes(x= displ, 
                            y = hwy)) + 
  facet_wrap(~class, nrow = 2)

# También podríamos usar un facet para combinar 2 variables y se usa facet_grid
# facets_grid (<Formula_variable_1>~<Formula_variable_2>). 
# Por ejemplo, vamos ha hacer un gráfico donde se evalúen todos los x=displ vs y=hwy
# pero separados según su tipo de tracción (drv) y su cilindrada (cyl).
# Así, el gráfico sigue siendo el mismo (displ vs hwy) pero los puntos se han separado
# según su tipo de tracción y su cilindrada

ggplot (data = mpg) + 
  geom_point(mapping = aes (x = displ,
                            y = hwy)) + 
  facet_grid(drv~cyl)

# En este caso, podemos ver que los facets y los geom_points son independiente
# se le pueden agregar parámetro por separado. Por ejemplo, que le un color
ggplot(data = mpg) +
  geom_point (mapping = aes(x= displ, 
                            y = hwy,
                            color = class)) + 
  facet_grid(drv~cyl)


# Si usamos el punto antes o después de la variable, tenemos la división según el eje
# pero únicamente con la variable indicada

ggplot(data = mpg) +
  geom_point (mapping = aes(x= displ, 
                            y = hwy)) + 
  facet_grid(.~cyl) # división del grid pone a la variable cyl paralela al eje y. 

##

ggplot(data = mpg) +
  geom_point (mapping = aes(x= displ, 
                            y = hwy)) + 
  facet_grid(drv~.) # En este caso, la división del grid pone a la variable drv paralela al eje x.

# Diferentes geometrías
ggplot(data = mpg) +
  geom_point (mapping = aes(x= displ, 
                            y = hwy))

ggplot(data = mpg) +
  geom_smooth (mapping = aes(x= displ, 
                             y = hwy))

ggplot(data = mpg) +
  geom_smooth (mapping = aes(x= displ, 
                             y = hwy, 
                             linetype = drv, #linetype indica qué variable separará
                             color = drv)) # color indica la variable que coloreará
ggplot(data = mpg) +
  geom_smooth (mapping = aes(x= displ, 
                             y = hwy, 
                             linetype = drv, #linetype indica qué variable separar
                             color = drv)) # en este caso, usamos la tracción (drv)

# También podríamos combinar ambas capas de la geom_smooth y la geom_point.
# Tendríamos puntos de colores según tracción y luego
# tendríamos una línea según la tracción y un color según dicha tracción.
# Esta sería una combinación donde veríamos todos los datos y luego la línea de tendencia,
# en ambos casos con los colores coincidentes

ggplot(data = mpg) +
  geom_point (mapping = aes(x = displ,
                            y = hwy,
                            color = drv)) +
  geom_smooth (mapping = aes(x= displ, 
                             y = hwy, 
                             linetype = drv, 
                             color = drv))

##
ggplot(data = mpg) +
  geom_smooth (mapping = aes(x= displ, 
                             y = hwy, 
                             group = drv, #solo agrupa, pero no cambia el tipo de línea
                             color = drv),
               show.legend = T) # Fuerza la aparición de la leyenda

# Vemos que siempre tenemos que estar planteando los mappings, así que podríamos
# plantearlos de manera global en lugar de en cada una de las capas y luego eliminarlos
# del resto de las capas. 
# Pero podríamos crear un mapping local, que predomina sobre el global

ggplot(data = mpg, mapping = aes(x= displ, y = hwy))+
  geom_point(mapping = aes (color = class))+
  geom_smooth(mapping = aes(color=drv))


# Aquí tenemos mappings globales y luego haremos un mapping local para colorear por tipo de coche (class)
# Luego usaremos una capa de geom_smooth y filtraremos los datos del dataset mpg
# para quedarnos solamente con aquellos cuya tipo sea suv (class == "suv")
# Al hacer se = F se eliminará el color gris alrededor de la curva (confianza)

ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "suv"), se = F) 

# Tarea 7
ggplot(data = mpg, mapping = aes(x=displ, y = hwy,color = drv)) + 
  geom_point() + 
  geom_smooth( se = F)


# Tarea 5

ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point() + 
  geom_smooth( se = F)


# Tarea 6

ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(mapping = (aes(group = drv)), se = F)

# Vamos a cambiar de dataset para ver otro con más variables para 
# generar un diagrama de barras. El dataset es diamonds.

diamonds

View(diamonds)

ggplot(data=diamonds) + 
  geom_bar(mapping = aes(x=cut)) # Aquí solo ponemos una variable discreta

ggplot(data = diamonds)+
  stat_count(mapping = aes(x=cut, color=cut, fill = cut))


ggplot(data = diamonds)+
  stat_count(mapping = aes(x=cut))

# Vamos a usar un tribble que hace una selección de datos fijos y lo guardamos en la 
# variable demo_diamonds que tiene datos guardados en ~cut y en ~freqs

demo_diamonds <- tribble(
  ~cut,       ~freqs,
  "Fair",       1610,
  "Good",       4906,
  "Very Good", 12082,
  "Premium",   13791,
  "Ideal",     21551
)

ggplot(data = demo_diamonds) + 
  geom_bar(mapping = aes(x=cut, y = freqs), 
           stat = "identity") # "identity" suministra la x y la y, 
# en lugar de que haga un contaje del dataset

# Vamos a ver ahora la proporción, usando una proporción stat implícita
# usando ..prop.. y agrupadas en la X(group = 1)

ggplot(data = diamonds)+
  geom_bar(mapping = (aes(x=cut, y = ..prop.., group =1)))

ggplot(data = diamonds)+
  stat_summary (mapping = aes(x = cut, y = price),
                fun.ymin = min,
                fun.ymax = max,
                fun.y = median
  )
#Tarea 5
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
# Falta el group = 1

# Se puede hacer un diagrama apilado con:

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut, fill = cut))

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut, fill = clarity))

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut, fill = color))

# Si no se quiere esta opción, podemos usar otra variable
## position = "identity", así todas las barras empiezan abajo

ggplot(data = diamonds, mapping = aes(x=cut, fill = clarity))+
  geom_bar(position = "identity")

## position = "fill" hace que todas las barras sean de la misma altura y sirve para
# comparar proporciones

ggplot(data = diamonds, mapping = aes(x=cut, fill = clarity))+
  geom_bar(position = "fill")

# position = "dodge" pone las barras con overlapping una al lado de la otra

ggplot(data = diamonds, mapping = aes(x=cut, fill = clarity))+
  geom_bar(position = "dodge")


#Problema del overplotting. Cuando vemos puntos, es posible que muchos coincidan en un
# solo lugar, pero realmente es posible que muchos coincidan en el mismo lugar.
# Para evitar eso, vamos a usar el parámetro jitter, que nos permitirá ver mejor
# cómo están los puntos. Jitter agregará un ligero ruido aleatorio para ver mejor los
# puntos. Solo tiene sentido en los scatters plots

ggplot (data = mpg, mapping = aes(x=displ, y=hwy))+
  geom_point(position = "jitter")

ggplot (data = mpg, mapping = aes(x=displ, y=hwy))+
  geom_jitter()


#Sistemas de coordenadas
#coord_flip() -> cambia la orientación de x e y

ggplot(data = mpg, mapping = aes(x=class, y = hwy))+
  geom_boxplot()+
  coord_flip() #giramos el gráfico

#coord_quickmap() -> configura el aspect ratio para mapas
install.packages("maps")

usa <- map_data("usa")

ggplot(usa, aes(long, lat, group = group))+
  geom_polygon(fill = "blue", colour ="white")+
  coord_quickmap()


italy <- map_data("italy")

ggplot(italy, aes(long, lat, group = group))+
  geom_polygon(fill = "blue", colour ="white")+
  coord_quickmap()

# coord_polar()

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut, fill =cut),
           show.legend = F,
           width = 1)+
  theme(aspect.ratio = 1)+
  labs(x=NULL, y=NULL)+
  coord_polar()


# Gráfica por capas

#PLANTILLA PARA HACER UNA REPRESENTACIÓN GRÁFICA CON GGPLOT

#ggplot(data = <DATA_FRAME>) +
# #  <GEOM_FUNCTION>(
#                     mapping = aes(<MAPPINGS>),
#                     stat = <STATS>
#                     position = <POSITION>
#                     ) +
#   <COORDINATE_FUNCTION>()+
#   <FACET_FUNCTION>()



























