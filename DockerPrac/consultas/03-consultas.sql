-- Ejecutar desde cualquier editor SQL conectado a panaderia_db.
-- Desde terminal: docker compose exec -T db psql -U alumno -d panaderia_db -v ON_ERROR_STOP=1 -P pager=off -f /consultas/03-consultas.sql

-- 1. Conexion y lista de tablas.
SELECT current_database() AS base_de_datos, current_user AS usuario, version() AS version_postgresql;
SELECT table_name AS tabla FROM information_schema.tables
WHERE table_schema='public' AND table_type='BASE TABLE' ORDER BY table_name;

-- 2. Productos, categorias y existencias.
SELECT p.id, p.nombre, c.nombre AS categoria, p.precio AS precio_bs,
       i.cantidad_actual AS stock, p.stock_minimo
FROM productos p
JOIN categorias_productos c ON c.id=p.categoria_id
JOIN inventario_productos i ON i.producto_id=p.id
ORDER BY p.id;

-- 3. Usuarios de ejemplo y su rol. Se omite el hash de la contrasena.
SELECT u.id, u.nombre, u.apellido, u.email, r.nombre AS rol, u.estado
FROM usuarios u JOIN roles r ON r.id=u.rol_id ORDER BY u.id;

-- 4. Cabecera y detalle de pedidos.
SELECT p.numero_pedido, p.nombre_cliente, p.payment_method, p.estado, p.total AS total_bs,
       pr.nombre AS producto, d.cantidad, d.precio_unitario, d.subtotal
FROM pedidos p
JOIN pedido_detalles d ON d.pedido_id=p.id
JOIN productos pr ON pr.id=d.producto_id
ORDER BY p.id,d.id;

-- 5. Compras y proveedores.
SELECT c.numero_compra, p.name AS proveedor, c.fecha_compra, c.total AS total_bs
FROM compras c JOIN proveedores p ON p.id=c.proveedor_id ORDER BY c.id;

-- 6. Materias primas e inventario.
SELECT m.nombre, u.abreviatura AS unidad, i.cantidad_actual AS stock, m.stock_minimo
FROM materias_primas m
JOIN unidades_medida u ON u.id=m.unidad_medida_id
JOIN inventario_materias_primas i ON i.materia_prima_id=m.id ORDER BY m.id;

-- 7. Ingredientes de cada receta.
SELECT r.nombre AS receta, r.cantidad_producida AS rendimiento, m.nombre AS ingrediente,
       ri.quantity AS cantidad, u.abreviatura AS unidad
FROM recetas r
JOIN receta_ingredientes ri ON ri.receta_id=r.id
JOIN materias_primas m ON m.id=ri.materia_prima_id
JOIN unidades_medida u ON u.id=m.unidad_medida_id ORDER BY r.id,ri.id;

-- 8. Lotes de produccion.
SELECT pr.numero_produccion, p.nombre AS producto, pr.cantidad_planificada,
       pr.cantidad_producida, pr.estado, pr.fecha_produccion
FROM producciones pr JOIN productos p ON p.id=pr.producto_id ORDER BY pr.id;

-- 9. Totales de ejemplo: 4 productos, 3 clientes, 3 pedidos y 2 compras.
SELECT (SELECT COUNT(*) FROM productos) AS productos,
       (SELECT COUNT(*) FROM clientes) AS clientes,
       (SELECT COUNT(*) FROM pedidos) AS pedidos,
       (SELECT COUNT(*) FROM compras) AS compras,
       (SELECT SUM(total) FROM pedidos WHERE estado='completado') AS ventas_completadas_bs;
