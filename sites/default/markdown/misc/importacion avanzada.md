# Importación avanzada

Al importar visitas se puede anexar más información de la que incluye
la plantilla. Simplemente agregue nuevas columnas al final de la plantilla
original. El nombre de la columna será el nombre de la variable adicional
creada. Los agentes tendrán acceso a esa información adicional de la
visita.

Existen ciertos campos adicionales que si se agregan,
modifican el comportamiento de Gestii.
Estos son:

* `cluster`. Le asigna este clúster a la visita.
* `group`. Le asigna a la visita ese grupo.
* `cuestionario`. Le asigna este cuestionario a la visita.
* `subfolio`. Le asigna a la visita este subfolio.
* `prioridad`. Un número entero del 1 al 5 que representa la importancia de la visita. Esto hará que aparezcan primero las visitas con mayor prioridad en el celular del agente.
* `valido_desde`. Hará que la visita sólo se pueda realizar a partir de esta fecha. El formato es `yyyy/mm/dd`.
* `valido_hasta`. Hará que la visita se tenga que realizar antes de que esta fecha pase. El formato es `yyyy/mm/dd`.
* `latitud`. La latitud del lugar de la visita en coordenadas geográficas.
* `longitud`. La longitud del lugar de la visita en coordenadas geográficas.

# Artículos Relacionados

* [Importación](importacion)
* [Cluster](/visitas/cluster)
* [Folios y subfolios](/visitas/folio)
