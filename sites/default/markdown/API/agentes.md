Agentes
-------

- [Buscar y listar agentes](#agents-list)
- [Mostrar detalles de un agente](#agents-show)
- [Crear un agente nuevo](#agents-create)
- [Modificar los datos de un agente](#agents-update)
- [Eliminar un agente](#agents-delete)
- [Asignar encuestas a un agente](#agents-surveys)
- [Mostrar la ubicación de los agentes](#agents-location)
- [Generar reportes de agentes](#agents-reports)

un agente es un tipo de usuario con permisos para conectarse desde las apps móviles y realizar visitas directamente desde el campo. en la api un agente se encuentra representado por un objeto con la siguiente estructura:

```json
{
	"first_event": null,
	"last_event": null,
	"visits": 0,
	"id": 1,
	"username": "test1",
	"status": 0,
	"license": true,
	"battery": 0,
	"name": "test1",
	"phone": "123456789",
	"token": "foo",
	"group_id": 1
}
```

atributo       | tipo      | notas
---------------|-----------|----------------------------------------------------------------------
first_event    | datetime  | Puede ser null.
last_event     | datetime  | Puede ser null.
visits         | integer   | Cuántas visitas ha realizado hoy.
id             | integer   | 
username       | string    | 
status         | integer   | uno de: `0` (desconectado), `1` (ausente), `2` (conectado).
license        | boolean   | uno de: `true` si el agente tiene una licencia activa, `false` si no.
battery        | integer   | 
name           | string    | 
phone          | string    | 
token          | string    | 
group_id       | integer   | 

~~~~agents-list
### Listar agentes

Devuelve una colección de objetos tipo [Agente][]. Este método soporta las operaciones de [búsqueda][], [ordenación][], [paginado][], [extracción][] y [vinculación][].

````http-req
GET /api/v1/agents
````

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|---------------------
username       | String    | Opcional  | 
name           | String    | Opcional  | 
status         | Integer   | Opcional  | 
license        | Boolean   | Opcional  | 
group_id       | Integer   | Opcional  | 
sort           | String    | Opcional  | Default: `username`.
offset         | Integer   | Opcional  | 
limit          | Integer   | Opcional  | 
fields         | CSV       | Opcional  | 
embed          | CSV       | Opcional  | Aceptados: `group`.
count          | Boolean   | Opcional  | 

Listar agentes cuyo usuario comience por "test" ordenados descendentemente por nombre:

````http-req
GET /api/v1/agents?username=test&sort=-name&apikey=123456
````

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"first_event": null,
		"last_event": null,
		"visits": 0,
		"id": 1,
		"username": "test1",
		"status": 0,
		"license": true,
		"battery": 80,
		"name": "test1",
		"phone": "123456789",
		"token": "foo",
		"group_id": 1
	}, {
		"first_event": null,
		"last_event": null,
		"visits": 0,
		"id": 2,
		"username": "test2",
		"status": 0,
		"license": true,
		"battery": 100,
		"name": "test2",
		"phone": "987654321",
		"token": "bar",
		"group_id": 1
	}
]
```

~~~~agents-show
### Mostrar agente

Devuelve un objeto tipo [Agente][]. Este método soporta las operaciones de [extracción][] y [vinculación][].

````http-req
GET /api/v1/agents/:id
````

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|--------------------
fields         | CSV       | Opcional  | 
embed          | CSV       | Opcional  | Aceptados: `group`.

Mostrar el agente con id "1" y sus recursos vinculados:

````http-req
GET /api/v1/agents/1?embed=group&apikey=123456
````

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"first_event": null,
	"last_event": null,
	"visits": 0,
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

~~~~agents-create
### Crear agente

Crea un agente y devuelve un objeto tipo [Agente][] representando el recurso creado.

````http-req
POST /api/v1/agents
````

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|---------------------------------
username       | String    | Requerido | No podrá ser modificado después.
password       | String    | Requerido | 
name           | String    | Requerido | 
phone          | String    | Opcional  | Default: vacío.
license        | Boolean   | Opcional  | Default: `true`.
group_id       | Integer   | Requerido | 

Crear un agente nuevo con licencia activada y sin número telefónico:

````http-req
POST /api/v1/agents?username=agentenuevo&password=secreto&name=Agente%20Nuevo&group_id=1
````

```headers
Status: 201 Created
Content-Type: application/json
```

```json
{
	"first_event": null,
	"last_event": null,
	"visits": 0,
	"id": 3,
	"username": "agentenuevo",
	"status": 0,
	"license": true,
	"battery": 80,
	"name": "Agente Nuevo",
	"phone": "",
	"token": "04CA2",
	"group_id": 1
}
```

~~~~agents-update
### Modificar agente

Actualiza los datos de un agente y devuelve un objeto tipo [Agente][] con las modificaciones realizadas.

````http-req
PUT /api/v1/agents/:id
````

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|----------------------------------------------
password       | String    | Opcional  | Si existe, la contraseña será modificada.
name           | String    | Requerido | 
phone          | String    | Opcional  | 
license        | Boolean   | Opcional  | 
group_id       | Integer   | Requerido | 

Actualizar el nombre y número telefónico del agente con id "1":

````http-req
PUT /api/v1/agents/1?name=Nuevo%20Nombre&phone=55456123778&apikey=123456
````

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"first_event": null,
	"last_event": null,
	"visits": 0,
	"id": 1,
	"username": "agente1",
	"status": 2,
	"license": true,
	"battery": 80,
	"name": "Nuevo Nombre",
	"phone": "55456123778",
	"token": "F0A19",
	"group_id": 1
}
```

Generar un nuevo token para el agente con id "1":

````http-req
PUT /api/v1/agents/1/token?apikey=123456
````

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"token": "8B59A"
}
```

**Nota:** Al regenerar el token de un agente, el agente será desconectado automáticamente de la app móvil.

~~~~agents-delete
### Eliminar agente

Elimina permanentemente un agente. Como consecuencia, todas las [visitas][Visitas] no realizadas que dicho agente tuviera asignadas serán canceladas.

````http-req
DELETE /api/v1/agents/:id
````

Eliminar el agente con id "1":

````http-req
DELETE /api/v1/agents/1&apikey=123456
````

```headers
Status: 204 No Content
Content-Type: application/json
```

```json

```

~~~~agents-surveys
### Asignar encuestas

Una encuesta es una visita que puede ser realizada en cualquier momento sin haber sido asignada previamente. Para que un agente pueda realizar encuestas es necesario asignarle los [cuestionarios][Cuestionarios] con los que podrá realizarlas. Cualquier cuestionario es válido para asignar como encuesta.

#### Listar encuestas asignadas

Devuelve una colección de objetos tipo [Form][Cuestionarios]. Este método no soporta ninguna operación.

````http-req
GET /api/v1/agents/:id/surveys
````

Listar todos los cuestionarios para encuestas asignados al agente con id "1":

````http-req
GET /api/v1/agents/1/surveys
````

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"id": 1,
		"name": "Encuesta de Opinión",
		"description": "Levantamiento Enero",
		"version": 1,
		"created_at": "2014-06-04T18:46:02+0000",
		"backup": true
	}
]
```

#### Asignar cuestionarios para encuestas

Sobreescribe los [cuestionarios][Cuestionarios] que el agente tiene asignados para realizar encuestas. La respuesta se devuelve vacía en caso de éxito.

````http-req
PUT /api/v1/agents/:id/surveys
````

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|------------------------------
ids            | CSV       | Requerido | Los ids de los cuestionarios.

Asignar los cuestionarios con ids "1" y "2" al agente con id "1":

````http-req
PUT /api/v1/agents/1/surveys?ids=1,2&apikey=123456
````

```headers
Status: 204 No Content
Content-Type: application/json
```

```json

```

~~~~agents-location
### Localizar agentes

Devuelve una colección de objetos tipo [Location][] con la ubicación actual de todos los agentes.

````http-req
GET /api/v1/agents/now
````

Mostrar la ubicación de todos los agentes:

````http-req
GET /api/v1/agents/now?apikey=123456
````

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"visit_id": null,
		"id": 1,
		"agent_id": 1,
		"event": 1,
		"latitude": 19.492316,
		"longitude": -99.234433,
		"accuracy": 10,
		"created_at": "2014-01-01T14:00:00Z"
	},
	{
		"visit_id": null,
		"id": 2,
		"agent_id": 2,
		"event": 1,
		"latitude": 19.432608,
		"longitude": -99.133208,
		"accuracy": 10,
		"created_at": "2014-01-01T14:00:00Z"
	}
]
```

#### Mostrar el rastreo de un agente

Devuelve una colección de objetos tipo [Location][] con las ubicaciones de rastreo de un agente.

````http-req
GET /api/v1/agents/:id/tracking/:date
````

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|------
id             | Integer   | Requerido | 
date           | Date      | Requerido | 

Mostrar el rastreo del agente con id "1" para el 1 de enero de 2014:

````http-req
GET /api/v1/agents/1/tracking/140101
````

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"visit_id": null,
		"id": 1,
		"agent_id": 1,
		"event": 1,
		"latitude": 19.492316,
		"longitude": -99.234433,
		"accuracy": 10,
		"created_at": "2014-01-01T14:00:00Z"
	},
	{
		"visit_id": null,
		"id": 5,
		"agent_id": 1,
		"event": 2,
		"latitude": 19.492316,
		"longitude": -99.234433,
		"accuracy": 10,
		"created_at": "2014-01-01T14:05:00Z"
	},
	{
		"visit_id": null,
		"id": 9,
		"agent_id": 1,
		"event": 1,
		"latitude": 19.492316,
		"longitude": -99.234433,
		"accuracy": 10,
		"created_at": "2014-01-01T14:10:00Z"
	}
]
```

~~~~agents-reports
### Generar reportes

Como conveniencia, es posible descargar la información de los agentes en reportes pre-armados en distintos formatos.

#### Listar los reportes disponibles

Devuelve una colección de objetos tipo [Reporte][]. Este método no acepta ninguna operación.

````http-req
GET /api/v1/agents/reports
````

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"id": 0,
		"generator": "PRODUCTIVITY",
		"name": "Reporte de productividad",
		"description": "Métricas de visitas por día y tiempo por visita",
		"params": [ ]
	},
	{
		"id": 1,
		"generator": "LOGIN",
		"name": "Reporte de login",
		"description": "Tiempos de inicio se sesión de la semana",
		"params": [ ]
	}
]
```

#### Generar un nuevo reporte

Dado que la generación de un nuevo reporte es un proceso asíncrono, se realiza a través de la API de [Tasks][Task]. Dependiendo del tipo de reporte y de la cantidad de información, este proceso puede tardar algunos minutos en finalizar.

Devuelve un objeto tipo [Task][] para monitorear el progreso de generación del reporte. Este método soporta las operaciones de [búsqueda][], [ordenación][] y [paginado][] de acuerdo a los mismos parámetros que el [listado de agentes][listar agentes].

````http-req
POST /api/v1/jobs
````

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|--------------------------------------------------
generator      | Integer   | Requerido | El id de la [lista de reportes][reporte agentes].
username       | String    | Opcional  | 
name           | String    | Opcional  | 
status         | Integer   | Opcional  | 
license        | Boolean   | Opcional  | 
group_id       | Integer   | Opcional  | 
sort           | String    | Opcional  | Default: `username`.
offset         | Integer   | Opcional  | 
limit          | Integer   | Opcional  | 

Generar un reporte de productividad del [grupo][Grupos] con id "1":

````http-req
POST /api/v1/tasks/reports?generator=PRODUCTIVITY&group_id=1&apikey=123456
````

```headers
Status: 202 Accepted
Content-Type: application/json
```

```json
{
	"id": 7,
	"caption": "Reporte: Reporte de visitas CSV de4cbd8.zip",
	"status": 0,
	"progress": 0,
	"message": "",
	"created_at": "2014-06-06T16:48:30+0000",
	"admin_id": 1,
	"item_id": 2,
	"type": "report"
}
```

#### Monitorear y descargar el reporte

Tanto el monitoreo como la descarga se realizan exactamente de la misma manera que los [reportes de visitas][reporte visitas].

[Peticiones]: /API/peticiones
[Respuestas]: /API/respuestas
[Operaciones]: /API/operaciones
[Visitas]: /API/visitas
[Agentes]: /API/agentes
[Admins]: /API/admins
[Grupos]: /API/grupos
[Auxiliares]: /API/auxiliares
[Cookbook]: /API/cookbook
[Alertas]: /API/alertas
[Cuestionarios]: /cuestionarios

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
[DelayedJob]: /API/auxiliares#tasks
[Task]: /API/auxiliares#tasks

[ISO 8601]: http://es.wikipedia.org/wiki/ISO_8601

[listar admins]: /API/admins#admins-list
[mostrar admins]: /API/admins#admins-show
[crear admins]: /API/admins#admins-create
[modificar admins]: /API/admins#admins-update
[eliminar admins]: /API/admins#admins-delete
[permisos admins]: /API/admins#admins-permissions
[objetos admins]: http://help.gestii.com:8080/API/admins#admins-objects
[APIkeys]: /API/admins#admins-apikeys

[listar agentes]: /API/agentes#agents-list
[mostrar agentes]: /API/agentes#agents-show
[crear agentes]: /API/agentes#agents-create
[modificar agentes]: /API/agentes#agents-update
[eliminar agentes]: /API/agentes#agents-delete
[encuestas agentes]: /API/agentes#agents-surveys
[localizar agentes]: /API/agentes#agents-location
[reporte agentes]: /API/agentes#agents-reports

[listar grupos]: /API/grupos#groups-list
[mostrar grupos]: /API/grupos#groups-show
[crear grupos]: /API/grupos#groups-create
[modificar grupos]: /API/grupos#groups-update
[eliminar grupos]: /API/grupos#groups-delete

[listar visitas]: /API/visitas#visits-list
[mostrar visitas]: /API/visitas#visits-show
[importar visitas]: /API/visitas#visits-upload
[cancelar visitas]: /API/visitas#visits-cancel
[eliminar visitas]: /API/visitas#visits-delete
[asignar visitas]: /API/visitas#visits-assign
[supervisar visitas]: /API/visitas#visits-supervise
[reporte visitas]: /API/visitas#visits-reports

[búsqueda]: /API/operaciones#searching
[ordenación]: /API/operaciones#sorting
[paginado]: /API/operaciones#pagination
[extracción]: /API/operaciones#extraction
[vinculación]: /API/operaciones#embedding

[autorización]: /API/peticiones#auth
[límite de peticiones]: /API/peticiones#limits
[tipos de datos]: /API/peticiones#data-types
[datetime]: /API/peticiones#type-datetime
