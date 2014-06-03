<#agents>
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

Un agente es un tipo de usuario con permisos para conectarse desde las apps móviles y realizar visitas directamente desde el campo. En la API un agente se encuentra representado por un objeto con la siguiente estructura:

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
	"group_id": 1
}
```

Atributo       | Tipo      | Notas
---------------|-----------|----------------------------------------------------------------------
id             | Integer   | 
username       | String    | 
status         | Integer   | Uno de: `0` (desconectado), `1` (ausente), `2` (conectado).
license        | Boolean   | Uno de: `true` si el agente tiene una licencia activa, `false` si no.
battery        | Integer   | 
name           | String    | 
phone          | String    | 
token          | String    | 
group_id       | Integer   | 

<#agents-list>
### Listar agentes

Devuelve una colección de objetos tipo [Agente][]. Este método soporta las operaciones de [búsqueda][], [ordenación][], [paginado][], [extracción][] y [vinculación][].

	GET /api/v1/agents

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

	GET /api/v1/agents?username=test&sort=-name&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"id": 2,
		"username": "test2",
		"status": 2,
		"license": true,
		"battery": 60,
		"name": "Tlacuache",
		"phone": "5598765432",
		"token": "78AC0",
		"group_id": 1
	},
	{
		"id": 1,
		"username": "test1",
		"status": 2,
		"license": true,
		"battery": 80,
		"name": "Armadillo",
		"phone": "5512345678",
		"token": "F0A19",
		"group_id": 1
	}
]
```

<#agents-show>
### Mostrar agente

Devuelve un objeto tipo [Agente][]. Este método soporta las operaciones de [extracción][] y [vinculación][].

	GET /api/v1/agents/:id


Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|--------------------
fields         | CSV       | Opcional  | 
embed          | CSV       | Opcional  | Aceptados: `group`.

Mostrar el agente con id "1" y sus recursos vinculados:

	GET /api/v1/agents/1?embed=group&apikey=123456

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

<#agents-create>
### Crear agente

Crea un agente y devuelve un objeto tipo [Agente][] representando el recurso creado.

	POST /api/v1/agents

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|---------------------------------
username       | String    | Requerido | No podrá ser modificado después.
password       | String    | Requerido | 
name           | String    | Requerido | 
phone          | String    | Opcional  | Default: vacío.
license        | Boolean   | Opcional  | Default: `true`.
group_id       | Integer   | Requerido | 

Crear un agente nuevo con licencia activada y sin número telefónico:

	POST /api/v1/agents?username=agentenuevo&password=secreto&name=Agente%20Nuevo&group_id=1

```headers
Status: 201 Created
Content-Type: application/json
```

```json
{
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

<#agents-update>
### Modificar agente

Actualiza los datos de un agente y devuelve un objeto tipo [Agente][] con las modificaciones realizadas.

	PUT /api/v1/agents/:id

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|----------------------------------------------
password       | String    | Opcional  | Si existe, la contraseña será modificada.
name           | String    | Opcional  | 
phone          | String    | Opcional  | 
license        | Boolean   | Opcional  | 
token          | Boolean   | Opcional  | Enviar en `true` para generar un nuevo token.
group_id       | Integer   | Opcional  | 

Actualizar el nombre y número telefónico del agente con id "1":

	PUT /api/v1/agents/1?name=Nuevo%20Nombre&phone=55456123778&apikey=123456

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
	"name": "Nuevo Nombre",
	"phone": "55456123778",
	"token": "F0A19",
	"group_id": 1
}
```

Generar un nuevo token para el agente con id "1":

	PUT /api/v1/agents/1?token=true&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"id": 1,
	"username": "agente1",
	"status": 0,
	"license": true,
	"battery": 80,
	"name": "Agente 1",
	"phone": "55456123778",
	"token": "8B59A",
	"group_id": 1
}
```

**Nota:** Al regenerar el token de un agente, el agente será desconectado automáticamente de la app móvil.

<#agents-delete>
### Eliminar agente

Elimina permanentemente un agente. Como consecuencia, todas las [visitas](#visits) no realizadas que dicho agente tuviera asignadas serán canceladas.

	DELETE /api/v1/agents/:id

Eliminar el agente con id "1":

	DELETE /api/v1/agents/1&apikey=123456

```headers
Status: 204 No Content
Content-Type: application/json
```

```json

```

<#agents-surveys>
### Asignar encuestas

Una encuesta es una visita que puede ser realizada en cualquier momento sin haber sido asignada previamente. Para que un agente pueda realizar encuestas es necesario asignarle los [cuestionarios](#forms) con los que podrá realizarlas. Cualquier cuestionario es válido para asignar como encuesta.

#### Listas encuestas asignadas

Devuelve una colección de objetos tipo [Form][]. Este método no soporta ninguna operación.

	GET /api/v1/agents/:id/surveys

Listar todos los cuestionarios para encuestas asignados al agente con id "1":

	GET /api/v1/agents/1/surveys

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
		"version": 1
	}
]
```

#### Asignar cuestionarios para encuestas

Sobreescribe los [cuestionarios](#forms) que el agente tiene asignados para realizar encuestas. La respuesta se devuelve vacía en caso de éxito.

	PUT /api/v1/agents/:id/surveys

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|------------------------------
ids            | CSV       | Requerido | Los ids de los cuestionarios.

Asignar los cuestionarios con ids "1" y "2" al agente con id "1":

	PUT /api/v1/agents/1/surveys?ids=1,2&apikey=123456

```headers
Status: 204 No Content
Content-Type: application/json
```

```json

```

<#agents-location>
### Localizar agentes

Devuelve una colección de objetos tipo [Location][] con la ubicación actual de todos los agentes.

	GET /api/v1/agents/now

Mostrar la ubicación de todos los agentes:

	GET /api/v1/agents/now?apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"id": 1,
		"agent_id": 1,
		"event": 1,
		"latitude": 19.492316,
		"longitude": -99.234433,
		"accuracy": 10,
		"created_at": "2014-01-01T14:00:00Z"
	},
	{
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

	GET /api/v1/agents/:id/tracking/:date

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|------
id             | Integer   | Requerido | 
date           | Date      | Requerido | 

Mostrar el rastreo del agente con id "1" para el 1 de enero de 2014:

	GET /api/v1/agents/1/tracking/140101

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"id": 1,
		"agent_id": 1,
		"event": 1,
		"latitude": 19.492316,
		"longitude": -99.234433,
		"accuracy": 10,
		"created_at": "2014-01-01T14:00:00Z"
	},
	{
		"id": 5,
		"agent_id": 1,
		"event": 2,
		"latitude": 19.492316,
		"longitude": -99.234433,
		"accuracy": 10,
		"created_at": "2014-01-01T14:05:00Z"
	},
	{
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

<#agents-reports>
### Generar reportes

Como conveniencia, es posible descargar la información de los agentes en reportes pre-armados en distintos formatos.

#### Listar los reportes disponibles

Devuelve una colección de objetos tipo [Reporte][]. Este método no acepta ninguna operación.

	GET /api/v1/agents/reports

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"generator": "PRODUCTIVITY",
		"name": "Reporte de productividad",
		"description": "Métricas de visitas por día y tiempo por visita",
	},
	{
		"generator": "LOGIN",
		"name": "Reporte de login",
		"description": "Tiempos de inicio se sesión de la semana",
	}
]
```

#### Generar un nuevo reporte

Dado que la generación de un nuevo reporte es un proceso asíncrono, se realiza a través de la API de [Delayed Jobs](#jobs). Dependiendo del tipo de reporte y de la cantidad de información, este proceso puede tardar algunos minutos en finalizar.

Devuelve un objeto tipo [DelayedJob][] para monitorear el progreso de generación del reporte. Este método soporta las operaciones de [búsqueda][], [ordenación][] y [paginado][] de acuerdo a los mismos parámetros que el [listado de agentes](#agents-list).

	POST /api/v1/jobs

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|------------------------------------------------
queue          | String    | Requerido | Debe ser: `reports`.
generator      | String    | Requerido | Uno de la [lista de reportes](#agents-reports).
username       | String    | Opcional  | 
name           | String    | Opcional  | 
status         | Integer   | Opcional  | 
license        | Boolean   | Opcional  | 
group_id       | Integer   | Opcional  | 
sort           | String    | Opcional  | Default: `username`.
offset         | Integer   | Opcional  | 
limit          | Integer   | Opcional  | 

Generar un reporte de productividad del [grupo](#groups) con id "1":

	POST /api/v1/jobs?queue=reports&generator=PRODUCTIVITY&group_id=1&apikey=123456

```headers
Status: 202 Accepted
Content-Type: application/json
```

```json
{
	"id": "Aaco9cy5",
	"status": 0
}
```

#### Monitorear y descargar el reporte

Tanto el monitoreo como la descarga se realizan exactamente de la misma manera que los [reportes de visitas](#visits-reports-status).

[Peticiones]: http://help.gestii.com:8080/API/peticiones
[Respuestas]: http://help.gestii.com:8080/API/respuestas
[Operaciones]: http://help.gestii.com:8080/API/operaciones
[Visitas]: http://help.gestii.com:8080/API/visitas
[Agentes]: http://help.gestii.com:8080/API/agentes
[Admins]: http://help.gestii.com:8080/API/admins
[Grupos]: http://help.gestii.com:8080/API/grupos
[Auxiliares]: http://help.gestii.com:8080/API/auxiliares
[Cookbook]: http://help.gestii.com:8080/API/cookbook

[Agente]: http://help.gestii.com:8080/API/agentes
[Admin]: http://help.gestii.com:8080/API/admins
[Grupo]: http://help.gestii.com:8080/API/grupos
[Form]: http://help.gestii.com:8080/API/#forms
[Alarma]: http://help.gestii.com:8080/API/#alarms
[Reporte]: http://help.gestii.com:8080/API/auxiliares#reports
[Visita]: http://help.gestii.com:8080/API/visitas
[Upload]: http://help.gestii.com:8080/API/auxiliares#uploads
[Extradata]: http://help.gestii.com:8080/API/auxiliares#extradata
[Feedback]: http://help.gestii.com:8080/API/auxiliares#feedbacks
[Location]: http://help.gestii.com:8080/API/auxiliares#locations
[Reporte]: http://help.gestii.com:8080/API/auxiliares#reports
[DelayedJob]: http://help.gestii.com:8080/API/auxiliares#jobs

[ISO 8601]: http://es.wikipedia.org/wiki/ISO_8601

[búsqueda]: http://help.gestii.com:8080/API/operaciones#searching
[ordenación]: http://help.gestii.com:8080/API/operaciones#sorting
[paginado]: http://help.gestii.com:8080/API/operaciones#pagination
[extracción]: http://help.gestii.com:8080/API/operaciones#extraction
[vinculación]: http://help.gestii.com:8080/API/operaciones#embedding
