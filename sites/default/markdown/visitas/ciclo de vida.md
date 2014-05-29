# Ciclo de vida de las visitas

Las visitas siguen una secuencia sencilla mientras son efectuadas.

<pre>
~ Diagrama feo ~

Pendiente -> Disponible -> Terminada.
Cancelada
Expirada
Actualizada
</pre>

Todos los estatus salvo Pendiente y Disponible son estatus
terminales: ya no se modificará el estatus de una visita
que esté en ellos.

Una visita al ser creada inicia como Pendiente o
Disponible, dependiendo si le falta información para poderse
realizar. De Pendiente puede pasar a Disponible en cuanto se
complete la información restante.

Mientras que una visita está como Pendiente o Disponible:

* Si se realiza normalmente, pasará al estatus de Terminada.
* Si se cancela la visita, pasará al estado de Cancelada.
* Si se acaba el tiempo límite para su realización, pasará al estatus de Expirada.
* Si se modifica la información de la visita, se creará una nueva visita Pendiente o Disponible, y ésta pasará a Actualizada.

# Artículos Relacionados

* [Estatus](estatus)
* [Gestión](gestion)
