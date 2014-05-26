# Impresión

Los campos de impresión permiten a los agentes conectarse a una impresora
Bluetooth mientras realizan una visita. Las opciones de este campo las
puede ver en el artículo de [propiedades](propiedades).

El cuerpo de la impresión puede tener secuencias especiales que le permiten
imprimir valores ya introducidos en el cuestionario o información como la
hora actual.

Las secuencias especiales son:

* `{{ var_name }}` imprime el valor del campo cuya variable tenga el nombre `var_name`.
* `{$ var_name $}` imprime el valor de la variable adicional `var_name`. Puede aprender más acerca de las variables adicionales en el [artículo sobre importación avanzada](/misc/importación avanzada).
* `{% var_name %}` imprime el valor de la variable especial `var_name`.

Las variables especiales disponibles son:

* `agent` imprime el nombre de usuario del agente.
* `folio` imprime el folio de la visita donde se está realizando el cuestionario.
* `datetime` imprime la fecha y la hora actual.
* `date` imprime la fecha actual.
* `time` imprime la hora actual.
* `year` imprime el año actual.
* `month` imprime el mes actual.
* `day` imprime el día actual.
* `hour` imprime la hora actual.
* `minute` imprime el minute actual.
* `second` imprime el segundo actual.

# Artículos Relacionados

* [Importación](/misc/importación)
