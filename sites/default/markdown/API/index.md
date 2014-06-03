API REST v1
============

Gestii es una solución completamente hosteada que te permite tener bajo control la operación de tus agentes de campo y, por supuesto, de toda tu información. Es por eso que proveemos una API [REST](http://es.wikipedia.org/wiki/Representational_State_Transfer) construída con principios pragmáticos que la hacen muy sencilla de consultar.

Nuestra API utiliza todas las ventajas del protocolo HTTP, desde las comunicaciones seguras hasta los códigos de respuesta, por lo que cualquier cliente o componente HTTP debería ser capaz de comunicarse sin problemas con ella.
Vínculos Rápidos
----------------

Contenido                  | Notas
---------------------------|-------------------------------------------------------------------------------------------
[Peticiones][Peticiones]   | Descripción de las peticiones, autorización, límites y tipos de datos.
[Respuestas][Respuestas]   | Descripción de las respuestas y códigos de éxito y error.
[Operaciones][Operaciones] | Instrucciones para buscar, contar, ordenar, paginar y reducir el tamaño de las peticiones.
[Visitas][Visitas]         | Administración de visitas —como órdenes de trabajo, encuestas, cuentas por cobrar—.
[Agentes][Agentes]         | Administración de usuarios que se conectan desde las apps móviles.
[Admins][Admins]           | Administración de usuarios que se conectan desde la interfaz web.
[Grupos][Grupos]           | Administración de divisiones organizacionales —como oficinas, sucursales, áreas—.
[Auxiliares][Auxiliares]   | Descripción de objetos auxiliares de al API —Uploads, Extradata, Feedbacks—.
[Cookbook][Cookbook]       | Recetas rápidas y deliciosas para realizar acciones comunes.

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
