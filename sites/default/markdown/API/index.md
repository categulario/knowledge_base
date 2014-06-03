API REST v1
============

Gestii es una solución completamente hosteada que te permite tener bajo control la operación de tus agentes de campo y, por supuesto, de toda tu información. Es por eso que proveemos una API [REST](http://es.wikipedia.org/wiki/Representational_State_Transfer) construída con principios pragmáticos que la hacen muy sencilla de consultar.

Nuestra API utiliza todas las ventajas del protocolo HTTP, desde las comunicaciones seguras hasta los códigos de respuesta, por lo que cualquier cliente o componente HTTP debería ser capaz de comunicarse sin problemas con ella.
Vínculos Rápidos
----------------

Contenido                  | Notas
---------------------------|-------------------------------------------------------------------------------------------
[Peticiones](#requests)    | Descripción de las peticiones, autorización, límites y tipos de datos.
[Respuestas](#responses)   | Descripción de las respuestas y códigos de éxito y error.
[Operaciones](#ops)        | Instrucciones para buscar, contar, ordenar, paginar y reducir el tamaño de las peticiones.
[Visitas](#visits)         | Administración de visitas —como órdenes de trabajo, encuestas, cuentas por cobrar—.
[Agentes](#agents)         | Administración de usuarios que se conectan desde las apps móviles.
[Admins](#admins)          | Administración de usuarios que se conectan desde la interfaz web.
[Grupos](#groups)          | Administración de divisiones organizacionales —como oficinas, sucursales, áreas—.
[Auxiliares](#auxiliary)   | Descripción de objetos auxiliares de al API —Uploads, Extradata, Feedbacks—.
[Cookbook](#cookbook)      | Recetas rápidas y deliciosas para realizar acciones comunes.

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
