<#groups>
Grupos
------

- [Buscar y listar grupos](#groups-list)
- [Mostrar detalles de un grupo](#groups-show)
- [Crear un grupo nuevo](#groups-create)
- [Modificar los datos de un grupo](#groups-update)
- [Eliminar un grupo](#groups-delete)

Los grupos son utilizados para reprensentar divisiones organizacionales de [agentes](#agents) y [visitas](#visits). Un grupo puede representar una oficina, una sucursal, un departamento o cualquier otro concepto similar. En la API un grupo se encuentra representado por un objeto con la siguiente estructura:

```json
{
	"id": 1,
	"name": "Oficina México DF"
}
```

Atributo       | Tipo      | Notas
---------------|-----------|------
id             | Integer   | 
name           | String    | 

El atributo `name` permite un formato especial donde es posible jerarquizar los grupos simplemente antecediendo su nombre con los nombres de sus niveles superiores separados por el caracter `|`. Es decir, si por ejemplo en tu organización existiera una región "Norte" con sucursales "Monterrey" y "Torreón", el nombre de dichos grupos debería ser `Norte|Monterrey` y `Norte|Torreón` respectivamente. Este formato es procesado por Gestii para extender algunas funcionalidades, principalmente en la interfaz web.

**Nota:** Es posible agregar hasta dos niveles de jerarquía al nombre de un grupo, por ejemplo: `Norte|Nuevo Leon|Monterrey`.

<#groups-list>
### Listar grupos

Devuelve una colección de objetos tipo [Grupo][]. Este método soporta las operaciones de [búsqueda][], [ordenación][], [paginado][] y [extracción][].

	GET /api/v1/groups

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|-------------------------------------
name           | String    | Opcional  | 
levels         | Integer   | Opcional  | Uno de: `0`, `1`, `2`. Default: `0`.
sort           | String    | Opcional  | Default: `name`.
offset         | Integer   | Opcional  | 
limit          | Integer   | Opcional  | 
fields         | CSV       | Opcional  | 
count          | Boolean   | Opcional  | 

El parámetro `levels` normaliza el número de niveles que es devuelto en el nombre del grupo, es decir, aun cuando un grupo no contenga niveles superiores, si `levels` es establecido a `2`, el formato del nombre será el siguiente: `-|-|Oficina DF`. Si el grupo tiene más niveles de los indicados, los niveles superiores serán omitidos en la respuesta.

Listar los grupos de la región "Nuevo Leon":

	GET /api/v1/groups?name=Norte|Nuevo%20Leon|&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"id": 1,
		"name": "Norte|Nuevo Leon|Monterrey"
	},
	{
		"id": 2,
		"name": "Norte|Nuevo Leon|Apodaca"
	}
]
```

Listar todos los grupos con nivel normalizado a "2":

	GET /api/v1/groups?levels=2&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"id": 1,
		"name": "-|-|Casa Matriz"
	},
	{
		"id": 2,
		"name": "-|Norte|Monterrey"
	},
	{
		"id": 3,
		"name": "Sur|Yucatán|Mérida"
	}
]
```

<#groups-show>
### Mostrar grupo

Devuelve un objeto tipo [Grupo][]. Este método soporta la operación [extracción][].

	GET /api/v1/admins/:id

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|-------------------------------------
levels         | Integer   | Opcional  | Uno de: `0`, `1`, `2`. Default: `0`.
fields         | CSV       | Opcional  | 

Mostrar la información del grupo con id "1":

	GET /api/v1/groups/1?apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"id": 1,
	"name": "Norte|Nuevo Leon|Monterrey"
}
```

<#groups-create>
### Crear grupo

Crea un grupo y devuelve un objeto tipo [Grupo][] representando el recurso creado.

	POST /api/v1/admins

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|------
name           | String    | Requerido | 

Crear una sucursal llamada "Ciudad de México" perteneciente a la sucursal "Centro":

	POST /api/v1/groups?name=Centro|Ciudad%20de%20México&apikey=123456

```headers
Status: 201 Created
Content-Type: application/json
```

```json
{
	"id": 3,
	"name": "Centro|Ciudad de México"
}
```

<#groups-update>
### Modificar grupo

Actualiza los datos de un grupo y devuelve un objeto tipo [Grupo][] con las modificaciones realizadas.

	PUT /api/v1/groups/:id

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|------
name           | String    | Requerido | 

Cambiar el nombre del grupo con id "3":

	PUT /api/v1/groups/3?name=Centro|Mexico%20City&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"id": 3,
	"name": "Mexico City"
}
```

<#groups-delete>
### Eliminar grupo

Elimina permanentemente un grupo. Si el grupo contiene [visitas](#visits) y [agentes](#agents), se permite mover ambos elementos a otro grupo o eliminarlos en cascada.

	DELETE /api/v1/groups/:id

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|----------------------------------------------------
cascade        | String    | Requerido | Uno de: `relocate` (reubicar), `delete` (eliminar).
to             | Integer   | Opcional  | Requerido si en `cascade` se seleccionó `relocate`.

Eliminar el grupo con id "2" junto con los agente y las visitas que contenga:

	DELETE /api/v1/groups/2?cascade=delete&apikey=123456

```headers
Status: 204 No Content
Content-Type: application/json
```

```json

```

Eliminar el grupo con id "1" y reubicar sus visitas y agentes al grupo con id "2":

	DELETE /api/v1/groups/1?cascade=relocate&to=2&apikey=123456

```headers
Status: 204 No Content
Content-Type: application/json
```

```json

```

**Nota:** Si se elige `cascade=delete`, el mecanismo de [eliminación de agentes](#agents-delete) también será desencadenado.

[Peticiones]: /API/peticiones
[Respuestas]: /API/respuestas
[Operaciones]: /API/operaciones
[Visitas]: /API/visitas
[Agentes]: /API/agentes
[Admins]: /API/admins
[Grupos]: /API/grupos
[Auxiliares]: /API/auxiliares
[Cookbook]: /API/cookbook

[Agente]: /API/agentes
[Admin]: /API/admins
[Grupo]: /API/grupos
[Form]: /API/#forms
[Alarma]: /API/#alarms
[Reporte]: /API/auxiliares#reports
[Visita]: /API/visitas
[Upload]: /API/auxiliares#uploads
[Extradata]: /API/auxiliares#extradata
[Feedback]: /API/auxiliares#feedbacks
[Location]: /API/auxiliares#locations
[Reporte]: /API/auxiliares#reports
[DelayedJob]: /API/auxiliares#jobs

[ISO 8601]: http://es.wikipedia.org/wiki/ISO_8601

[búsqueda]: /API/operaciones#searching
[ordenación]: /API/operaciones#sorting
[paginado]: /API/operaciones#pagination
[extracción]: /API/operaciones#extraction
[vinculación]: /API/operaciones#embedding
