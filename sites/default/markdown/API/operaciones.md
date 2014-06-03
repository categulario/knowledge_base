<#ops>
Operaciones
===========

- [Buscar y contar resultados](#searching)
- [Ordenar resultados](#sorting)
- [Paginar resultados](#pagination)
- [Extraer atributos de resultados](#extraction)
- [Vincular objetos relacionados](#embedding)

Por conveniencia, muchos de los métodos de esta API soportan operaciones especiales para manipular la respuesta antes de que sea devuelta. Estas operaciones se realizan a través de parámetros reservados que siempre que estén presentes en una petición significará que la acción a la que hacen alusión puede ser realizada. Algunos de los parámetros reservados son los siguientes: `count`, `sort`, `limit`, `offset`, `fields` y `embed`.

<#searching>
Búsqueda
--------

Algunos de los métodos que devuelven colecciónes de objetos aceptan parámetros que permiten reducir el resultado a únicamente un subconjunto que cumpla con ciertos criterios definidos por el usuario.

En general, los métodos que soportan este tipo de operación son los listados de objetos, en los cuales todos los parámetros que no son un parámetro restringido por otra operación, si están presentes, son considerados para aplicar un filtro de búsqueda.

Por ejemplo, en el [listado de agentes](#agents-list), los parámetros `username`, `name`, `status`, `license` y `group_id` son utilizados como criterios de búsqueda, mientras que todos los demás son parámetros reservados para realizar otro tipo de operaciones.

Si más de un parámetro de búsqueda es indicado, los resultados que la petición devolverá serán todos aquellos que cumplan con los criterios de todos los parámetros, es decir, se realiza una [conjunción lógica](http://es.wikipedia.org/wiki/Puerta_AND) sobre ellos.

El tipo de búsqueda que realiza cada parámetro depende de su [tipo de dato](#data-types): para parámetros `Boolean` e `Integer` el campo debe ser exactamente igual al valor que se está proporcionando, para parámetros `String` se realiza una búsqueda parcial desde el inicio de la cadena, y para los parámetros `DateTime` se búsca exactamente la fecha indicada en caso de que el parámetro no tenga un [modificador de rango](#type-datetime), o por todos los resultados que se encuentren entre dos fechas en caso de que un modificador de rango sí se haya especificado. El resto de los tipos de datos no son utilizados por esta API para realizar consultas.

### Contar resultados

Debido a que contar es una operación computacionalmente costosa y aumenta el tiempo de respuesta de la petición, el número total de resultados que cumplen con los criterios (independientemente del [paginado][]) no se incluye por default, sin embargo es posible agregarlo a la respuesta enviando `count=true` como parte de los parámetros de la petición. El resultado del conteo se devuelve en el encabezado `X-Search-Count`:

	GET /api/v1/agents?licence=true&count=true&fields=id,license&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
X-Search-Count: 2
```

```json
[
	{
		"id": 1,
		"license": true
	},
	{
		"id": 2,
		"license": true
	}
]
```

<#sorting>
Ordenación
----------

La ordenación es una operación que permite —justamente— definir el orden en que una colección de objetos debe ser devuelta por los métodos de la API que lo soportan. Dicho orden se especifica mediante el parámetro reservado `sort`.

En general, los métodos que pueden ser ordenados son los mismos que aceptan la operación de [búsqueda][], donde los atributos por los cuales se puede ordenar corresponden a cualesquiera de los parámetros que pueden ser utilizados también para buscar, es decir, todos aquellos que estén indicados en la documentación y que no sean parámetros reservados por otras operaciones.

La forma para indicar, por ejemplo, una ordenación por nombre de usuario al [listar agentes](#agents-list) es la siguiente:

	GET /api/v1/agents?sort=username&apikey=123456

La dirección de la ordenación puede ser establecida por los signos `+` y `-` antes del nombre del atributo a ordenar. Por supuesto, `+` indica una ordenación ascendente y `-` una descendente. Si ninguno de los signos es proporcionado, la ordenación se realiza ascendentemente por default.

Retomando el ejemplo anterior, ordenar el mismo atributo pero en forma descendente se haría de la siguiente manera:

	GET /api/v1/agents?sort=-username&apikey=123456

**Nota:** No es posible ordenar por más de un atributo en cada petición.

<#pagination>
Paginado
--------

Debido a que hay [búsquedas](#searching) que pueden devolver muchos más objetos de los que es visualmente conveniente mostrar en una aplicación, los métodos de la API que soportan búsquedas pueden ser configurados para devolver los resultados en páginas.

Esta operación utiliza los parámetros reservados `limit` y `offset`, donde el primero indica el número de resultados que el método debe devolver por página (por default 50), y el segundo el número de resultados que se deben ignorar desde el inicio de la búsqueda (por default 0).

Por ejemplo, para obtener la primera página de 10 elementos en un [listado de agentes](#agents-list) que encontró 20 resultados deberás solicitar:

	GET /api/v1/agents?limit=10&offset=0&apikey=123456

Así mismo, para la segunda página:

	GET /api/v1/agents?limit=10&offset=10&apikey=123456

Ten en cuenta que cualquier `limit` menor a 1 y mayor a 100 arrojará un error, de la misma forma en que lo hará cualquier `offset` negativo. Un `offset` mayor al número de resultados de una búsqueda simplemente devolverá una colección vacía sin provocar ningún error.

<#extraction>
Extracción
----------

Para reducir el tamaño de las respuestas, algunos métodos de esta API soportan la reducción de atributos para obtener únicamente los que necesites. Solo agrega un parámetro `fields` a la petición con la lista de atributos que necesites.

Por ejemplo, si quisieras listar en un `<select>` los ids y usuarios de todos los agentes con licencia:

	GET /api/v1/agents?license=true&fields=id,username&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"id": 1,
		"username": "agente1"
	},
	{
		"id": 2,
		"username": "agente2"
	}
]
```

<#embedding>
Vinculación
-----------

Para reducir el número de peticiones a la API, algunos métodos también implementan la vinculación de objetos relacionados para que sean devueltos en la misma respuesta. Agregar un parámetro `embed` a la petición con la lista de los objetos que deseas vincular.

Por ejemplo, para obtener un agente y el grupo al que pertenece:

	GET /api/v1/agents/1?embed=group&apikey=12345

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"id": 1,
	"username": "agente1",
	"status": 2,
	"license": true,
	"battery": 80,
	"name": "Agente 1",
	"phone": "5512345678",
	"token": "F0A19",
	"group_id": 1,
	"group": {
		"id": 1,
		"name": "México DF"
	}
}
```

Observa que al final ha sido añadido un objeto tipo [Grupo][] con el grupo vinculado a través de `group_id`. En general se puede relacionar cualquier atributo que termine en `_id` en el objeto de la respuesta a menos que se indique lo contrario.

Esta operación también soporta un método especial de extracción de atributos, donde se puede indicar qué atributos del objeto vinculado necesitamos devolver utilizando el formato `objeto.atributo` en la lista de `embed`:

	GET /api/v1/agents/1?embed=group.name&apikey=12345

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"id": 1,
	"username": "agente1",
	"status": 2,
	"license": true,
	"battery": 80,
	"name": "Agente 1",
	"phone": "5512345678",
	"token": "F0A19",
	"group_id": 1,
	"group": {
		"name": "México DF"
	}
}
```

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
