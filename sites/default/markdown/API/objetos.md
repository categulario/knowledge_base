Objetos
=======

<#visits>
Visitas
-------

- [Buscar y listar visitas](#visits-list)
- [Mostrar detalles de una visita](#visits-show)
- [Importar un archivo de visitas](#visits-upload)
- [Cancelar una visita](#visits-cancel)
- [Eliminar una visita](#visits-delete)
- [Asignar una visita a otro agente](#visits-assign)
- [Supervisar una visita](#visits-supervise)
- [Generar reportes de visitas](#visits-reports)

Las visitas son el objeto central de procesamiento de Gestii y se utilizan para indicar los domicilios en donde un [agente](#agents) debe realizar o realizó una actividad. Puedes pensar en una visita como una orden de trabajo, ya sea una cuenta por cobrar o un cliente que evaluar, o como un levantamiento no previsto, por ejemplo una encuesta aleatoria de opinión. En la API una visita se encuentra representada por un objeto con la siguiente estructura:

```json
{
	"id": 1,
	"code": "ABC",
	"subcode": "123",
	"description": "",
	"status": 0,
	"type": 0,
	"priority": 1,
	"street": "Hda. Coaxamalucan #132",
	"district": "Hda. de Echegaray",
	"zipcode": "53300",
	"city": "Naucalpan",
	"state": "México",
	"country": "México",
	"address": "Hda. Coaxamalucan #132, Hda. de Echegaray, 53300, Naucalpan, México, México",
	"latitude": 19.492316,
	"longitude": -99.234433,
	"agent_id": 1,
	"upload_id": 1,
	"form_id": 1,
	"group_id": 1,
	"created_at": "2014-01-01T14:00:00Z",
	"updated_at": "2014-01-01T15:35:00Z",
	"available_at": "2014-01-01T14:00:00Z",
	"expires_at": "2015-01-01T14:00:00Z",
	"started_at": "2014-01-01T15:00:00Z",
	"finished_at": "2014-01-01T15:30:00Z",
	"received_at": "2014-01-01T15:35:00Z",
	"location_id": 1,
	"distance": 10,
	"timespan": 30,
	"alarms": 0,
	"supervising_id": null,
	"supervision": null,
	"version": 1
}
```

Atributo       | Tipo      | Notas
---------------|-----------|--------------------------------------------------------------------------------------------
id             | Integer   | 
code           | String    | 
subcode        | String    | 
description    | String    | 
status         | Integer   | Uno de: `0` (pendiente), `1` (disponible), `2` (terminada), `3` (cancelada), `4` (vencida).
type           | Integer   | Uno de: `0` (normal), `1` (encuesta), `2` (supervisión).
priority       | Integer   | Del 1 al 5, siendo 5 la prioridad más alta.
street         | String    | 
district       | String    | 
zipcode        | String    | 
city           | String    | 
state          | String    | 
country        | String    | 
address        | String    | Dirección estilizada para mostrar.
latitude       | Decimal   | 
longitude      | Decimal   | 
agent_id       | Integer   | Puede ser `null` si se encuentra aun sin asignar.
upload_id      | Integer   | Puede ser `null` si no se creó en una importación.
form_id        | Integer   | 
group_id       | Integer   | 
created_at     | Timestamp | 
updated_at     | Timestamp | 
available_at   | Timestamp | 
expires_at     | Timestamp | 
started_at     | Timestamp | 
finished_at    | Timestamp | 
received_at    | Timestamp | 
location_id    | Integer   | 
distance       | Integer   | Distancia en metros a la que se realizó la visita.
timespan       | Integer   | Duración en minutos de la visita.
alarms         | Integer   | 
supervising_id | Integer   | El id de la visita que se está supervisando.
supervision    | Integer   | Uno de: `null` (sin supervisar), `0` (en supervisión), `1` (aceptada), `2` (corregida), `3` (rechazada).
version        | Integer   | 

<#visits-list>
### Listar visitas

Devuelve una colección de objetos tipo [Visita][]. Este método soporta las operaciones de [búsqueda][], [ordenación][], [paginado][], [extracción][] y [vinculación][].

	GET /api/v1/visits

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|-------------------------------------
code           | String    | Opcional  | 
status         | Integer   | Opcional  | 
priority       | Integer   | Opcional  | 
agent_id       | Integer   | Opcional  | 
upload_id      | Integer   | Opcional  | 
form_id        | Integer   | Opcional  | 
group_id       | Integer   | Opcional  | 
created_at     | DateTime  | Opcional  | 
updated_at     | DateTime  | Opcional  | 
available_at   | DateTime  | Opcional  | 
expires_at     | DateTime  | Opcional  | 
finished_at    | DateTime  | Opcional  | 
received_at    | DateTime  | Opcional  | 
alarms         | Boolean   | Opcional  | 
sort           | String    | Opcional  | Default: `-finished_at`.
offset         | Integer   | Opcional  | 
limit          | Integer   | Opcional  | 
fields         | CSV       | Opcional  | 
embed          | CSV       | Opcional  | Aceptados: `agent`, `form`, `group`.
count          | Boolean   | Opcional  | 

Listar los ids y códigos de las visitas realizadas por el agente con id "1" el 1 de enero de 2014:

	GET /api/v1/visits?agent_id=1&finished_at=20140101&fields=id,code,agent_id,finished_at&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"id": 1,
		"code": "ABC",
		"agent_id": 1,
		"finished_at": "2014-01-01T15:30:00Z"
	},
	{
		"id": 2,
		"code": "XYZ",
		"agent_id": 1,
		"finished_at": "2014-01-01T16:30:00Z"
	}
]
```

Listar las visitas cuyo código comienza por "ABC" y cualquier subcódigo ordenadas descendentemente por código:

	GET /api/v1/visits?code=ABC&sort=-code&fields=id,code,subcode&apikey=123456

```json
[
	{
		"id": 1,
		"code": "ABC",
		"subcode": "456"
	},
	{
		"id": 2,
		"code": "XYZ",
		"subcode": "123"
	}
]
```

Listar las visitas con código "ABC" y subcódigo "123":

	GET /api/v1/visits?code=ABC-123&sort=-code&fields=id,code,subcode&apikey=123456

```json
[
	{
		"id": 1,
		"code": "ABC",
		"subcode": "456"
	}
]
```

Listar las visitas cuyo código es exactamente "XYZ" (nota el guión al final de `code`):

	GET /api/v1/visits?code=XYZ-&fields=id,code,subcode&apikey=123456

```json
[
	{
		"id": 2,
		"code": "XYZ",
		"subcode": "123"
	},
	{
		"id": 3,
		"code": "XYZ",
		"subcode": "456"
	}
]
```

Listar todas las visitas recibidas en los últimos 5 minutos (ver [rangos de fechas](#type-datetime)):

	GET /api/v1/visits?received_at=20140101140000-5m&fields=id,finished_at,received_at&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"id": 1,
		"finished_at": "2014-01-01T13:45:00Z",
		"received_at": "2014-01-01T13:57:00Z"
	},
	{
		"id": 2,
		"finished_at": "2014-01-01T13:48:00Z",
		"received_at": "2014-01-01T13:59:00Z"
	}
]
```

Listar todas las visitas [canceladas](#visits-cancel) el día de hoy:

	GET /api/v1/visits?status=3&updated_at=20140101000000+1d&fields=id,status,updated_at&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"id": 4,
		"status": 3,
		"updated_at": "2014-01-01T13:45:00Z"
	},
	{
		"id": 5,
		"status": 3,
		"updated_at": "2014-01-01T13:48:00Z"
	}
]
```

**Nota:** Aunque en el objeto [Visita][] los atributos `code` y `subcode` se muestran por separado, cualquier operación de filtro y ordenamiento por `code` considerará `subcode` en su resultado. En el caso de los filtros es necesario separar explícitamente el código y el subcódigo con un guión.

<#visits-show>
### Mostrar visita

Devuelve un objeto tipo [Visita][]. Este método soporta las operaciones de [extracción][] y [vinculación][].

	GET /api/v1/visits/:id

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|-------------------------------------
fields         | CSV       | Opcional  | 
embed          | CSV       | Opcional  | Aceptados: `agent`, `form`, `group`.

Mostrar el código y subcódigo de la visita con id "1" y vincular el usuario su agente asignado:

	GET /api/v1/visits/1?fields=code,subcode&embed=agent.username&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"code": "ABC",
		"subcode": "456",
		"agent": {
			"username": "agente1"
		}
	}
]
```

#### Obtener datos precargados en la importación

Devuelve una colección de objetos tipo [Extradata][] con los datos precargados al [importar la visita](#visits-import).

	GET /api/v1/visits/:id/extradata

Mostrar la información precargada para la visita con id "1":

	GET /api/v1/visits/1/extradata?apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"caption": "Nombre",
		"value": "Harrison"
	},
	{
		"caption": "Apellido",
		"value": "Ford"
	},
	{
		"caption": "Saldo",
		"value": "$1,500.00"
	}
]
```

#### Obtener datos capturados durante la visita

Devuelve una colección de objecto tupo [Feedback][] con los datos capturados durante la visita o la supervisión.

	GET /api/v1/visits/:id/feedbacks

Mostrar la información capturada para la visita con id "1":

	GET /api/v1/visits/1/feedbacks?apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"varname": "color_favorito",
		"caption": "Color Favorito",
		"value": "Negro"
	},
	{
		"varname": "estado_civil",
		"caption": "Estado Civil",
		"value": "Soltero"
	},
	{
		"varname": "hobbies",
		"caption": "Sus hobbies son",
		"value": "Futbol y películas"
	}
]
```

#### Obtener imágenes caputadas durante la visita

Devuelve una colección de objetos tipo [Feedback][] con las imágenes capturadas durante la visita o la supervisión.

	GET /api/v1/visits/:id/images

Mostrar las imágenes capturadas para la visita con id "1":

	GET /api/v1/visits/1/images?apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"varname": "fachada",
		"caption": "Fachada de la casa",
		"value": "/cdn/images/1"
	}
]
```

La URL de las imágenes deberá ser complementada con la [URL base](#requests) y por una API key con permisos para verlas. Por ejemplo:

	<img src="http://sitio.gestii.com/cdn/images/1?apikey=123456">

<#visits-upload>
### Importar visitas

Importa un archivo de visitas y devuelve un objeto tipo [Upload][] para monitorear el estatus de la importación.

	POST /api/v1/visits/upload

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|---------------------------------------------------------------------
file           | String    | Requerido | El cuerpo del archivo en codificación ANSI.
form_id        | Integer   | Requerido | Puede ser `0` si se indica el cuestionario en el cuerpo del archivo.
group_id       | Integer   | Requerido | Puede ser `0` si se indica el grupo en el cuerpo del archivo.
layout         | String    | Opcional  | Default: `default`.
name           | String    | Opcional  | Default: generado automáticamente.

Importar dos visitas con cuestionarios distintos en el grupo con id "1" y layout "default":

	POST /api/v1/visits/upload?form_id=0&group_id=1&apikey=123456

```
file=Código, Calle, Colonia, CP, Municipio, Estado, Agente, Cuestionario
ABC123, Hda. Coaxamalucan #132, Echegaray, 53300, Naucalpan, México, agente1, Encuesta
XYZ789, Reforma #342, Juárez, 06600, Cuauhtémoc, México DF, agente1, Investigación
```

```headers
Status: 202 Accepted
Content-Type: application/json
```

```json
{
	"id": 1,
	"name": "20140101140000_b7cfb.csv"
	"status": 100,
	"processed": 0,
	"geocoded": 0,
	"checksum": "dd57cb7057dbe4de7645bd273198aa92",
	"created_at": "2014-01-01T14:00:00Z"
}
```

Puedes encontrar más información acerca de los layouts y formatos de archivos especiales en nuestra sección de ayuda.

**Nota:** Las visitas no pueden ser modificadas, sin embargo importar nuevamente una visita con el mismo código y subcódigo que una visita existente causará que la visita existente sea sobreescrita con la información de la visita que se está importando. Al hacer esto, la nueva visita estará disponible para realizar sin importar el estado en el que se encontrara la visita anterior.

<#visits-status>
#### Monitorear estatus de importación

Dependiendo de la cantidad de visitas importadas, el proceso puede tardar algunos minutos en publicar las visitas a las apps móviles de los agentes. Si necesitas monitorear el estatus del upload en lo que el proceso termina, puedes utilizar el siguiente método que devolverá un objeto [Upload][] con el estatus en que se encuentra el upload solicitado:

	GET /api/v1/visits/upload/:id

Consultar el estatus del upload con id "1":

	GET /api/v1/visits/upload/1?apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"id": 1,
	"name": "20140101140000_b7cfb.csv"
	"status": 102,
	"processed": 1000,
	"geocoded": 1000,
	"checksum": "dd57cb7057dbe4de7645bd273198aa92",
	"created_at": "2014-01-01T14:00:00Z"
}
```

**Nota:** Nuestro promedio actual de tiempo de finalización de una importación es de 5 minutos por cada 1,000 visitas en el archivo.

<#visits-errors>
#### Descargar errores de importación

En caso de que el estatus devuelto por el objeto [Upload][] indique que el proceso de importación ha fallado y se debe descargar un archivo con la descripción de los errores (código `300`), el archivo podrá ser accedido utilizando la siguiente URL:

	GET /cdn/uploads/:id

Descargar el archivo de errores para el upload con id "1":

	GET /cdn/uploads/1?apikey=123456

```headers
Status: 200 OK
Content-Type: text/plain
```

```text
Error, Código, Calle, Colonia, CP, Municipio, Estado, Agente, Cuestionario
El agente no existe, ABC123, Hda. Coaxamalucan #132, Echegaray, 53300, Naucalpan, México, agente1, Encuesta
El agente no existe, XYZ789, Reforma #342, Juárez, 06600, Cuauhtémoc, México DF, agente1, Investigación
```

Observa que la primer columna ahora contiene la descripción del error encontrado específicamente para la fila en que se muestra.

<#visits-cancel>
### Cancelar visita

Cancela una visita y devuelve un objeto tipo [Visita][] con las modificaciones realizadas. Esta operación no elimina la visita.

	PUT /api/v1/visits/:id/cancel

Cancelar la visita con id "1":

	PUT /api/v1/visits/1/cancel

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"id": 1,
	"code": "ABC",
	"subcode": "123",
	"description": "",
	"status": 3,
	"type": 0,
	"priority": 1,
	"street": "Hda. Coaxamalucan #132",
	"district": "Hda. de Echegaray",
	"zipcode": "53300",
	"city": "Naucalpan",
	"state": "México",
	"country": "México",
	"address": "Hda. Coaxamalucan #132, Hda. de Echegaray, 53300, Naucalpan, México, México",
	"latitude": 19.492316,
	"longitude": -99.234433,
	"agent_id": 1,
	"upload_id": 1,
	"form_id": 1,
	"group_id": 1,
	"created_at": "2014-01-01T14:00:00Z",
	"updated_at": "2014-01-01T14:30:00Z",
	"available_at": "2014-01-01T14:00:00Z",
	"expires_at": "2015-01-01T14:00:00Z",
	"started_at": null,
	"finished_at": null,
	"received_at": null,
	"location_id": null,
	"distance": null,
	"timespan": null,
	"alarms": 0,
}
```

<#visits-delete>
### Eliminar visita

Elimina permanentemente una visita. Este método no afecta otros objetos del sistema.

	DELETE /api/v1/visits/:id

Eliminar la visita con id "1":

	DELETE /api/v1/visits/1&apikey=123456

```headers
Status: 204 No Content
Content-Type: application/json
```

```json

```

<#visits-assign>
### Reasignar visita

Cambia el [agente](#agents) asignado a una visita. Si la visita no había sido asignada a nadie previamente, se devuelve un objeto tipo [Visita][] con el agente actualizado. Si la visita ya había sido asignada a alguien, entonces este método crea una nueva visita con la misma información y devuelve un objeto tipo [Visita][] con la nueva visita y estatus `201 Created`. La visita reasignada siempre estará disponible nuevamente para realizar.

	PUT /api/v1/visits/:id/assign

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|----------------------------------------------------------------------------
agent_id       | Integer   | Requerido | 
supervise      | Boolean   | Opcional  | Default: `false`. En `true` para [supervisar](#visits-supervise) la visita.

Reasignar la visita con id "1" al agente con id "3":

	PUT /api/v1/visits/1/assign?agent_id=3&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"id": 1,
	"code": "ABC",
	"subcode": "123",
	"description": "",
	"status": 0,
	"type": 0,
	"priority": 1,
	"street": "Hda. Coaxamalucan #132",
	"district": "Hda. de Echegaray",
	"zipcode": "53300",
	"city": "Naucalpan",
	"state": "México",
	"country": "México",
	"address": "Hda. Coaxamalucan #132, Hda. de Echegaray, 53300, Naucalpan, México, México",
	"latitude": 19.492316,
	"longitude": -99.234433,
	"agent_id": 3,
	"upload_id": 1,
	"form_id": 1,
	"group_id": 1,
	"created_at": "2014-01-01T14:00:00Z",
	"updated_at": "2014-01-01T14:30:00Z",
	"available_at": "2014-01-01T14:00:00Z",
	"expires_at": "2015-01-01T14:00:00Z",
	"started_at": null,
	"finished_at": null,
	"received_at": null,
	"location_id": null,
	"distance": null,
	"timespan": null,
	"alarms": 0,
}
```

Reasignar la visita con id "1" al agente con id "5", siendo que la visita ya ha sido realizada:

	PUT /api/v1/visits/1/assign?agent_id=5&apikey=123456

```headers
Status: 201 Created
Content-Type: application/json
```

```json
{
	"id": 3,
	"code": "ABC",
	"subcode": "123",
	"description": "",
	"status": 0,
	"type": 0,
	"priority": 1,
	"street": "Hda. Coaxamalucan #132",
	"district": "Hda. de Echegaray",
	"zipcode": "53300",
	"city": "Naucalpan",
	"state": "México",
	"country": "México",
	"address": "Hda. Coaxamalucan #132, Hda. de Echegaray, 53300, Naucalpan, México, México",
	"latitude": 19.492316,
	"longitude": -99.234433,
	"agent_id": 5,
	"upload_id": 1,
	"form_id": 1,
	"group_id": 1,
	"created_at": "2014-01-01T15:00:00Z",
	"updated_at": "2014-01-01T15:00:00Z",
	"available_at": "2014-01-01T15:00:00Z",
	"expires_at": "2015-01-01T15:00:00Z",
	"started_at": null,
	"finished_at": null,
	"received_at": null,
	"location_id": null,
	"distance": null,
	"timespan": null,
	"alarms": 0,
}
```

<#visits-supervise>
#### Reasignar una visita para supervisión

Al [reasignar](#visits-assign) una visita es posible indicar que la visita debe ser supervisada con `supervise=true` en los parámetros. Esto provocará que al enviar la visita al nuevo agente, la información capturada originalmente aparezca pre-llenada en su app móvil, permitiéndole al agente que supervisa validarla o modificarla en caso de ser necesario. Al enviarla, los cambios realizados se reflejarán en la visita original.

Únicamente es posible supervisar visitas cuyo tipo sea `0` (normales) o `1` (encuestas) y ya hayan sido terminadas, es decir, en estatus `2`. Por lo tanto: no es posible supervisar una supervisión ni una visita sin realizar. Esta petición siempre devuelve `201 Created`.

Enviar a supervisión la visita con id "1" por el agente con id "3":

	PUT /api/v1/visits/1/assign?agent_id=3&supervise=true&apikey=123456

```headers
Status: 201 Created
Content-Type: application/json
```

```json
{
	"id": 4,
	"code": "ABC",
	"subcode": "123",
	"description": "",
	"status": 0,
	"type": 0,
	"priority": 1,
	"street": "Hda. Coaxamalucan #132",
	"district": "Hda. de Echegaray",
	"zipcode": "53300",
	"city": "Naucalpan",
	"state": "México",
	"country": "México",
	"address": "Hda. Coaxamalucan #132, Hda. de Echegaray, 53300, Naucalpan, México, México",
	"latitude": 19.492316,
	"longitude": -99.234433,
	"agent_id": 5,
	"upload_id": 1,
	"form_id": 1,
	"group_id": 1,
	"created_at": "2014-01-01T15:00:00Z",
	"updated_at": "2014-01-01T15:00:00Z",
	"available_at": "2014-01-01T15:00:00Z",
	"expires_at": "2015-01-01T15:00:00Z",
	"started_at": null,
	"finished_at": null,
	"received_at": null,
	"location_id": null,
	"distance": null,
	"timespan": null,
	"alarms": 0,
	"supervising_id": 1,
	"supervision": 0,
	"version": 1
}
```

<#visits-reports>
### Generar reportes

Como conveniencia, es posible descargar la información de las visitas en reportes pre-armados en distintos formatos.

#### Listar los reportes disponibles

Devuelve una colección de objetos tipo [Reporte][]. Este método no acepta ninguna operación.

	GET /api/v1/visits/reports

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"generator": "VISITS",
		"name": "Reporte PDF",
		"description": "Reporte en formato PDF estándar",
	},
	{
		"generator": "ZIP",
		"name": "Reporte CSV",
		"description": "Reporte en formato CSV estándar",
	}
]
```

#### Generar un nuevo reporte

Dado que la generación de un nuevo reporte es un proceso asíncrono, se realiza a través de la API de [Delayed Jobs](#jobs). Dependiendo del tipo de reporte y de la cantidad de información, este proceso puede tardar algunos minutos en finalizar.

Devuelve un objeto tipo [DelayedJob][] para monitorear el progreso de generación del reporte. Este método soporta las operaciones de [búsqueda][], [ordenación][] y [paginado][] de acuerdo a los mismos parámetros que el [listado de visitas](#visits-list).

	POST /api/v1/jobs

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|------------------------------------------------
queue          | String    | Requerido | Debe ser: `reports`.
generator      | String    | Requerido | Uno de la [lista de reportes](#visits-reports).
images         | Boolean   | Opcional  | Default: `false`.
code           | String    | Opcional  | 
status         | Integer   | Opcional  | 
priority       | Integer   | Opcional  | 
agent_id       | Integer   | Opcional  | 
upload_id      | Integer   | Opcional  | 
form_id        | Integer   | Opcional  | 
group_id       | Integer   | Opcional  | 
created_at     | DateTime  | Opcional  | 
updated_at     | DateTime  | Opcional  | 
available_at   | DateTime  | Opcional  | 
expires_at     | DateTime  | Opcional  | 
finished_at    | DateTime  | Opcional  | 
received_at    | DateTime  | Opcional  | 
alarms         | Boolean   | Opcional  | 
sort           | String    | Opcional  | Default: `-finished_at`.
offset         | Integer   | Opcional  | 
limit          | Integer   | Opcional  | 

Generar un reporte PDF de las visitas de la semana del agente con id "1":

	POST /api/v1/jobs?queue=reports&generator=VISITS&agent_id=1&finished_at=20140106000000+7d&apikey=123456

```headers
Status: 202 Accepted
Content-Type: application/json
```

```json
{
	"id": "b9iLXiAa",
	"status": 0
}
```

<#visits-reports-status>
#### Monitorear estatus de generación

Devuelve un objeto tipo [DelayedJob][] con el estatus de finalización del reporte.

	GET /api/v1/jobs/:id

Obtener el estatus del reporte con id "b9iLXiAa":

	GET /api/v1/jobs/b9iLXiAa?apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"id": "b9iLXiAa",
	"status": 1
}
```

#### Descargar el reporte generado

Una vez que el reporte haya sido generado, es posible acceder a él desde la URL:

	GET /cdn/reports/:id

Descargar el reporte generado con el id "b9iLXiAa":

	GET /cdn/reports/b9iLXiAa?apikey=123456

```headers
Status: 200 OK
Content-Type: application/zip
```

```text
504b 0304 1400 0000 0800 038d 1a43 1e73
d7a2 1a70 0200 b4b8 0200 2300 0000 4765
7374 6969 202d 2045 7371 7565 6d61 2064
6520 636f 6d69 7369 6f6e 6573 2e64 6f63
78ec 9ae3 7365 4f1a 806f cc1b dbb6 33b1
8d99 d893 896d 4f38 b16d dbc9 c499 d836
e617 dbb6 7573 b3ae addd dafd 0b76 9faa
eef3 769f 3aa7 3ff4 fb74 7fe8 56fe 0c05
8d05 8005 c003 0000 72c0 edee b546 3404
00b0 0803 0060 02e0 2175 251c ec5d cdec
5d0d d43d 1dcd 5cf4 583c ec6c c90a a121
e9f2 0190 80ff f33f cdaf 6439 9b01 36b4
90ab 1030 5c91 4d44 cabd b27c 4492 449a
09a1 2562 57e5 2d2f fa42 e8a7 15f0 0f19
4563 799c 30ee 7de3 ba03 cfbb a9b9 a4d7
8192 df2b 44e2 ead3 3855 69ee 3ab0 9aed
aa2b 727d c2c3 ac39 dea9 5258 cd58 ab3a
74cb 8814 8428 35b5 af7b 2961 e92a 4d31
3059 14af 70d3 45d9 81e8 ecee 244c d5ea
2c78 01f7 0434 eb48 2fcc 34bd 0e1d 1b02
2c39 5275 cb7d c57d b0ef b4e5 835f 4c1e
3b8b 676c 301c 6899 bcbf 7da4 7dc5 fe92
```

**Nota:** Por conveniencia, los reportes siempre se descargan en un archivo ZIP. Para procesarlos deberás guardar el byte stream que la petición devuelve y guardar el archivo con extensión ZIP. Posteriormente puedes manipularlo (programáticamente, inclusive) con cualquier aplicación que procese archivos comprimidos, como [7-Zip](http://7-zip.com.mx/), por ejemplo.

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

<#admins>
Admins
------

- [Buscar y listar admins](#admins-list)
- [Mostrar detalles de un admin](#admins-show)
- [Crear un admin nuevo](#admins-create)
- [Modificar los datos de un admin](#admins-update)
- [Eliminar un admin](#admins-delete)
- [Asignar permisos a un admin](#admins-permissions)
- [Asignar objetos a un admin](#admins-objects)
- [Administrar API keys de admins](#admins-apikeys)

Un admin es un tipo de usuario con permisos para conectarse vía internet a la página web y administrar y supervisar las actividades de los [agentes][Agente]. En la API un admin se encuentra representado por un objeto con la siguiente estructura:

```json
{
	"id": 1,
	"username": "admin1",
	"active": true,
	"name": "Admin 1",
	"email": "admin@gestii.com"
}
```

Atributo       | Tipo      | Notas
---------------|-----------|--------------------------------------------------------------------------
id             | Integer   | 
username       | String    | 
name           | String    | 
active         | Boolean   | Uno de: `true` si el admin puede iniciar sesión en la web, `false` si no.
email          | String    | 

<#admins-list>
### Listar admins

Devuelve una colección de objetos tipo [Admin][]. Este método soporta las operaciones de [búsqueda][], [ordenación][], [paginado][] y [extracción][].

	GET /api/v1/admins

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|---------------------
username       | String    | Opcional  | 
name           | String    | Opcional  | 
active         | Integer   | Opcional  | 
sort           | String    | Opcional  | Default: `username`.
offset         | Integer   | Opcional  | 
limit          | Integer   | Opcional  | 
fields         | CSV       | Opcional  | 
count          | Boolean   | Opcional  | 

Listar los ids y usuarios de los administradores activos, por ejemplo, para mostrar en un `<select>`:

	GET /api/v1/admins?active=true&fields=id,username&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"id": 1,
		"username": "admin1"
	},
	{
		"id": 2,
		"username": "admin2"
	}
]
```

<#admins-show>
### Mostrar admin

Devuelve un objeto tipo [Admin][]. Este método soporta la operación [extracción][].

	GET /api/v1/admins/:id

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|------
fields         | CSV       | Opcional  | 

Mostrar la información del admin con id "2":

	GET /api/v1/admins/2?apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"id": 2,
	"username": "admin2",
	"active": true,
	"name": "Admin 2",
	"email": "admin2@gestii.com"
}
```

<#admins-create>
### Crear admin

Crea un admin y devuelve un objeto tipo [Admin][] representando el recurso creado.

	POST /api/v1/admins

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|---------------------------------
username       | String    | Requerido | No podrá ser modificado después.
password       | String    | Requerido | 
name           | String    | Requerido | 
email          | String    | Requerido | 
active         | Boolean   | Opcional  | Default: `true`.

Crear un admin inactivo que no podrá iniciar sesión hasta que sea activado:

	POST /api/v1/admins?username=admin3&password=secreto&name=Admin%203&email=admin3@gestii.com&active=false&apikey=123456

```headers
Status: 201 Created
Content-Type: application/json
```

```json
{
	"id": 3,
	"username": "admin3",
	"active": false,
	"name": "Admin 3",
	"email": "admin3@gestii.com"
}
```

<#admins-update>
### Modificar admin

Actualiza los datos de un admin y devuelve un objeto tipo [Admin][] con las modificaciones realizadas.

	PUT /api/v1/admins/:id

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|------------------------------------------
password       | String    | Requerido | Si existe, la contraseña será modificada.
name           | String    | Requerido | 
email          | String    | Requerido | 
active         | Boolean   | Opcional  | 

Actualizar el admin con id "3" para concederle permisos de acceso:

	PUT /api/v1/admins/3?active=true&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"id": 3,
	"username": "admin3",
	"active": true,
	"name": "Admin 3",
	"email": "admin3@gestii.com"
}
```

Cambiar a "nuevo@gestii.com" el correo electrónico del admin con id "1":

	PUT /api/v1/admins/1?email=nuevo@gestii.com&apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"id": 1,
	"username": "admin1",
	"active": true,
	"name": "Admin 1",
	"email": "nuevo@gestii.com"
}
```

<#admins-delete>
### Eliminar admin

Elimina permanentemente un admin. Este método no afecta otros objetos del sistema.

	DELETE /api/v1/admins/:id

Eliminar el admin con id "3":

	DELETE /api/v1/admins/3&apikey=123456

```headers
Status: 204 No Content
Content-Type: application/json
```

```json

```

<#admins-permissions>
### Asignar permisos

Los permisos son la [lista blanca](http://es.wikipedia.org/wiki/Lista_blanca) de métodos que un admin tiene permitido ejecutar ya sea desde la interfaz web o a través de una API key.

#### Listar permisos asignados

Devuelve un array de `String` con la lista de permisos que el admin tiene asignados.

	GET /api/v1/admins/:id/permissions

Listar todos los permisos del admin con id "1":

	GET /api/v1/admins/1/permissions

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	"groups_index",
	"groups_store",
	"groups_show",
	"groups_destroy",
	"groups_update"
]
```

#### Asignar permisos de acceso

Sobreescribe los permisos de acceso que el admin tiene asignados.

	PUT /api/v1/admins/:id/permissions

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|------------------------------------------------
actions        | CSV       | Requerido | Ver el [catálogo de permisos](#admins-catalog).

Asignar los permisos `groups_index` y `groups_show` al admin con id "1":

	PUT /api/v1/admins/1/permissions?actions=groups_index,groups_show&apikey=123456

```headers
Status: 204 No Content
Content-Type: application/json
```

```json

```

<#admins-catalog>
#### Catálogo de permisos

Devuelve un array de [strings](#type-basics) con los permisos disponibles en la aplicación.

	GET /api/v1/admins/permissions

En general los nombres de los permisos explican por sí mismos la acción que restringen y siguen la siguente convención: `modulo_acción`.

Listar todos los permisos disponibles en Gestii:

	GET /api/v1/admins/permissions?apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	"admins_index",
	"admins_store",
	"admins_show",
	"admins_destroy",
	"admins_update",
	"admins_show_permissions",
	"admins_update_permissions",
	"admins_show_apikey",
	"admins_delete_apikey",
	"admins_show_object_permissions",
	"admins_update_object_permissions"
]
```

<#admins-objects>
### Asignar objetos

Los objetos son el subconjunto de datos que un admin tiene permitido visualizar ya sea desde la interfaz web o desde una API key.

#### Listar objetos asignados

Devuelve una colección de objetos con los nombres de los objetos y los ids en `CSV` a los que el admin tiene permisos.

	GET /api/v1/admins/:id/objects

Listar todos los objetos a los que tiene permiso el admin con id "1":

	GET /api/v1/admins/1/objects

```headers
Status: 200 OK
Content-Type: application/json
```

```json
[
	{
		"object": "groups",
		"ids": "1,2,3"
	},
	{
		"object": "forms",
		"ids": "1"
	},
	{
		"object": "reports",
		"ids": "1,2,3"
	}
]
```

#### Asignar permisos de objetos

Sobreescribe los objetos que el admin tiene permiso de visualizar.

	PUT /api/v1/admins/:id/objects

Parámetro      | Tipo      | Estatus   | Notas
---------------|-----------|-----------|-------------------------------------------------
object         | String    | Requerido | Uno de: `groups`, `forms`, `layouts`, `reports`.
ids            | CSV       | Requerido | 

Asignar permisos para visualizar los grupos con ids "1", "2" y "3" al admin con id "1":

	PUT /api/v1/admins/1/objects?object=groups&ids=1,2,3&apikey=123456

```headers
Status: 204 No Content
Content-Type: application/json
```

```json

```

Cada uno de los permisos de objetos restringe los resultados de los métodos que listan y manipulan los siguientes objetos: `groups` limita [visitas](#visits), [agentes](#agents) y [grupos](#groups); `forms` limita [cuestionarios](#forms); `layouts` limita [layouts](#layouts); `reports` limita [reportes](#reports).

En el caso de los listados, los objetos para los que no se cuente con permisos serán omitidos. Para el caso de las operaciones sobre un objeto en particular, si el admin no tiene permiso para acceder a él, la petición responderá con un `404 Not Found`.

<#admins-apikeys>
### Administrar API keys

Las API keys son el mecanismo de [autorización](#auth) que utiliza esta API. Por default la primera API key con todos los permisos es generada al crear tu cuenta en Gestii, sin embargo puedes crear API keys para administradores con [permisos](#admin-permissions) diferentes de tal manera que asegures que desde tus aplicaciones únicamente se está accediendo a los datos y operaciones que se deben acceder sin comprometer información privada o sensible.

#### Mostrar la API key de un admin

Devuelve un objeto con la API key del admin solicitado:

	GET /api/v1/admins/:id/apikey

Mostrar la API key del admin con id "1":

	GET /api/v1/admins/1/apikey?apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"apikey": "1c7a92ae351d4e21ebdfb897508f59d6"
}
```

**Nota:** Para generar una API key es necesario proporcionar una API key también que, por supuesto, tenga permisos para realizar dicha acción.

#### Generar una API key para un admin

Devuelve un objeto con la API key generada para el admin. Por default los admins se crean sin API key. Cada que se llame este método para un admin específico, se generará una nueva API key y la anterior será invalidada.

	POST /api/v1/admins/:id/apikey

Generar una nueva API key para el admin con id "1":

	POST /api/v1/admins/1/apikey?apikey=123456

```headers
Status: 200 OK
Content-Type: application/json
```

```json
{
	"apikey": "1fbc0d1378ead366a3d108255cba2324"
}
```

#### Eliminar la API key de un admin

Elimina la API key de un admin invalidando cualquier petición futura con dicha API key.

	DELETE /api/v1/admins/:id/apikey

Eliminar la API key del admin con id "1":

	DELETE /api/v1/admins/1/apikey

```headers
Status: 204 No Content
Content-Type: application/json
```

```json

```

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
[Agente]: #agents
[Admin]: #admins
[Grupo]: #groups
[Form]: #forms
[Alarma]: #alarms
[Reporte]: #reports
[Visita]: #visits
[Upload]: #uploads
[Extradata]: #extradata
[Feedback]: #feedbacks
[Location]: #locations
[Reporte]: #reports
[DelayedJob]: #jobs

[ISO 8601]: http://es.wikipedia.org/wiki/ISO_8601

[búsqueda]: #searching
[ordenación]: #sorting
[paginado]: #pagination
[extracción]: #extraction
[vinculación]: #embedding
