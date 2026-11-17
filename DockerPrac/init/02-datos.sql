-- Datos ficticios y reproducibles para la clase. No se exportaron personas ni claves reales.
BEGIN;

INSERT INTO roles(id,nombre,descripcion) VALUES
(1,'Administrador','Administracion de la panaderia'),
(2,'Usuario','Consulta y pedidos');

-- Clave de demostracion de estas tres cuentas: Practica123! (almacenada con BCrypt).
-- Son filas de ejemplo; esta carpeta no incluye el sitio web de Laravel.
INSERT INTO usuarios(id,rol_id,nombre,apellido,nombre_usuario,email,telefono,password) VALUES
(1,1,'Ana','Mamani','admin_demo','admin@panaderia.test','71234567','$2y$12$WMahhzHrmdloUWYQQFrFGeLGXRlWePDCaSxXoKEyCqK9wCo2Z6PTq'),
(2,2,'Luis','Quispe','luis_demo','luis@panaderia.test','62345678','$2y$12$WMahhzHrmdloUWYQQFrFGeLGXRlWePDCaSxXoKEyCqK9wCo2Z6PTq'),
(3,2,'Carla','Flores','carla_demo','carla@panaderia.test','73456789','$2y$12$WMahhzHrmdloUWYQQFrFGeLGXRlWePDCaSxXoKEyCqK9wCo2Z6PTq');

INSERT INTO categorias_productos(id,nombre,descripcion) VALUES
(1,'Panes','Panes artesanales del dia'),
(2,'Salados','Productos salados horneados'),
(3,'Reposteria','Queques y otros productos dulces');

INSERT INTO productos(id,categoria_id,nombre,descripcion,precio,stock_minimo) VALUES
(1,1,'Marraqueta','Pan de corteza crocante',0.80,20),
(2,1,'Pan integral','Pan artesanal de harina integral',4.50,10),
(3,2,'Empanada de queso','Empanada horneada',6.00,8),
(4,3,'Queque de vainilla','Porcion de queque artesanal',12.00,5);
INSERT INTO inventario_productos(producto_id,cantidad_actual) VALUES (1,40),(2,20),(3,15),(4,11);

INSERT INTO clientes(id,nombre,apellido,telefono,email,direccion) VALUES
(1,'Ana','Mamani','71234567','ana@cliente.test','La Paz, zona Central'),
(2,'Luis','Quispe','62345678','luis@cliente.test','El Alto, zona Ciudad Satelite'),
(3,'Carla','Flores','73456789','carla@cliente.test','La Paz, zona Miraflores');

INSERT INTO pedidos(id,numero_pedido,cliente_id,nombre_cliente,telefono_cliente,email_cliente,payment_method,estado,subtotal,total,observacion) VALUES
(1,'PED-CLASE-001',1,'Ana Mamani','71234567','ana@cliente.test','efectivo','pendiente',25.00,25.00,'Ejemplo: retiro en tienda'),
(2,'PED-CLASE-002',2,'Luis Quispe','62345678','luis@cliente.test','qr','completado',72.00,72.00,'Ejemplo de venta completada'),
(3,'PED-CLASE-003',3,'Carla Flores','73456789','carla@cliente.test','transferencia','confirmado',4.00,4.00,'Ejemplo de pedido confirmado');
INSERT INTO pedido_detalles(pedido_id,producto_id,cantidad,precio_unitario,subtotal) VALUES
(1,1,20,0.80,16.00),(1,2,2,4.50,9.00),
(2,3,10,6.00,60.00),(2,4,1,12.00,12.00),
(3,1,5,0.80,4.00);

INSERT INTO proveedores(id,name,phone,email,direccion,supplied_items) VALUES
(1,'Molino Andino Demo','71112233','ventas@molino.test','El Alto, zona Industrial','Harinas y sal'),
(2,'Insumos del Horno Demo','62223344','ventas@insumos.test','La Paz, zona Central','Levadura, agua y mantequilla');
INSERT INTO unidades_medida(id,nombre,abreviatura,tipo) VALUES
(1,'Kilogramo','kg','masa'),(2,'Litro','L','volumen'),(3,'Unidad','u','conteo');
INSERT INTO materias_primas(id,unidad_medida_id,nombre,descripcion,stock_minimo) VALUES
(1,1,'Harina de trigo','Harina para pan blanco',10),
(2,1,'Harina integral','Harina para pan integral',10),
(3,1,'Levadura','Levadura para panificacion',0.5),
(4,1,'Sal','Sal para alimentos',2),
(5,2,'Agua','Agua apta para elaboracion',20),
(6,1,'Mantequilla','Grasa para reposteria',2);
INSERT INTO inventario_materias_primas(materia_prima_id,cantidad_actual) VALUES
(1,48),(2,30),(3,1.960),(4,9.960),(5,98.800),(6,5);

INSERT INTO compras(id,numero_compra,proveedor_id,fecha_compra,total,observacion) VALUES
(1,'COM-CLASE-001',1,CURRENT_DATE,650.00,'Compra de demostracion'),
(2,'COM-CLASE-002',2,CURRENT_DATE,370.00,'Compra de demostracion');
INSERT INTO compra_detalles(compra_id,materia_prima_id,cantidad,precio_unitario,subtotal) VALUES
(1,1,50,7,350),(1,2,30,9,270),(1,4,10,3,30),
(2,3,2,35,70),(2,5,100,1,100),(2,6,5,40,200);
INSERT INTO movimientos_inventario_materias_primas(materia_prima_id,tipo,motivo,quantity,observacion) VALUES
(1,'entrada','compra',50,'COM-CLASE-001'),
(2,'entrada','compra',30,'COM-CLASE-001'),
(4,'entrada','compra',10,'COM-CLASE-001'),
(3,'entrada','compra',2,'COM-CLASE-002'),
(5,'entrada','compra',100,'COM-CLASE-002'),
(6,'entrada','compra',5,'COM-CLASE-002'),
(1,'salida','produccion',2,'PRO-CLASE-001'),
(3,'salida','produccion',0.040,'PRO-CLASE-001'),
(4,'salida','produccion',0.040,'PRO-CLASE-001'),
(5,'salida','produccion',1.200,'PRO-CLASE-001');

INSERT INTO categorias_recetas(id,nombre,descripcion) VALUES
(1,'Panificacion','Recetas de panes'),(2,'Reposteria','Recetas dulces');
INSERT INTO recetas(id,producto_id,categoria_id,nombre,descripcion,cantidad_producida,tiempo_estimado_minutos) VALUES
(1,1,1,'Marraqueta artesanal','Receta de ejemplo para un lote de 40 panes',40,150),
(2,2,1,'Pan integral artesanal','Receta de ejemplo para un lote de 20 panes',20,180);
INSERT INTO receta_ingredientes(receta_id,materia_prima_id,quantity) VALUES
(1,1,2.000),(1,3,0.040),(1,4,0.040),(1,5,1.200),
(2,2,2.000),(2,3,0.050),(2,4,0.040),(2,5,1.300);
INSERT INTO receta_pasos(receta_id,numero_paso,descripcion) VALUES
(1,1,'Pesar y mezclar los ingredientes.'),
(1,2,'Amasar, formar las piezas y dejar fermentar.'),
(1,3,'Hornear y dejar enfriar antes de registrar el lote.'),
(2,1,'Pesar la harina integral y los ingredientes.'),
(2,2,'Amasar y dejar fermentar la masa.'),
(2,3,'Formar las piezas, hornear y dejar enfriar.');
INSERT INTO producciones(numero_produccion,receta_id,producto_id,cantidad_planificada,cantidad_producida,estado,observacion) VALUES
('PRO-CLASE-001',1,1,40,40,'completada','Los insumos consumidos figuran en movimientos de inventario.'),
('PRO-CLASE-002',2,2,20,0,'pendiente','Lote pendiente: todavia no consume materias primas.');

INSERT INTO configuraciones(clave,valor) VALUES
('nombre_panaderia','Panaderia Artesanal - Practica Docker'),
('moneda','BOB'),('zona_horaria','America/La_Paz');
INSERT INTO actividad_sistema(modulo,accion,descripcion) VALUES
('DockerPrac','inicializacion','Esquema y registros de demostracion cargados con PostgreSQL 16.'),
('Produccion','registro','Lote PRO-CLASE-001 de demostracion completado.');

-- Ajusta las secuencias para que un INSERT posterior no repita los IDs de los ejemplos.
DO $$
DECLARE
    tabla RECORD;
    ultimo_id BIGINT;
BEGIN
    FOR tabla IN SELECT tablename FROM pg_tables WHERE schemaname = 'public' LOOP
        EXECUTE format('SELECT MAX(id) FROM public.%I', tabla.tablename) INTO ultimo_id;
        PERFORM setval(
            pg_get_serial_sequence(format('public.%I',tabla.tablename),'id'),
            COALESCE(ultimo_id,1), ultimo_id IS NOT NULL
        );
    END LOOP;
END;
$$;

COMMIT;
