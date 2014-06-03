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
