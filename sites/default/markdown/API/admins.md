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