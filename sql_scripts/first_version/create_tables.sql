--  Personas
CREATE TABLE Personas(
    id_persona INT PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    cedula DECIMAL(15,0) UNIQUE,
    fecha_de_Nacimiento DATE,
    direccion_de_residencia NVARCHAR(100)
)

-- Empleados (depende de Personas)
CREATE TABLE Empleados(
    id_persona INT PRIMARY KEY,
    fecha_de_contratacion DATE,
    CONSTRAINT FK_empleado_persona FOREIGN KEY (id_persona) 
    REFERENCES Personas(id_persona)
)

-- Cargos (depende de Empleados)
CREATE TABLE Cargos(
    id_cargo INT PRIMARY KEY,
    id_empleado INT NOT NULL,
    nombre NVARCHAR(100),
    descripcion NVARCHAR(100),
    CONSTRAINT FK_cargo_empleado FOREIGN KEY (id_empleado)
    REFERENCES Empleados(id_persona)
)

--  Entrenadores (hereda de Empleados)
CREATE TABLE Entrenadores(
    id_entrenador INT PRIMARY KEY,
    fecha_de_vinculacion DATETIME,
    fecha_de_expedicion_licencia DATETIME,
    numero_de_certificacion INT,
    fecha_de_expiracion_licencia DATETIME,
    CONSTRAINT FK_entrenador_persona FOREIGN KEY (id_entrenador)
    REFERENCES Personas(id_persona),
    CONSTRAINT FK_entrenador_empleado FOREIGN KEY (id_entrenador)
    REFERENCES Empleados(id_persona)
)

-- 5. Especialidades
CREATE TABLE Especialidades(
    id_especialidad INT PRIMARY KEY,
    nombre NVARCHAR(100),
    descripcion NVARCHAR(100)
)

-- Entrenadores_especialidades 
CREATE TABLE Entrenadores_especialidades(
    id_entrenador INT NOT NULL,
    id_especialidad INT NOT NULL,
    PRIMARY KEY (id_entrenador, id_especialidad),
    CONSTRAINT FK_entrenador_especialidades FOREIGN KEY (id_entrenador)
    REFERENCES Entrenadores(id_entrenador),
    CONSTRAINT FK_especialidad_entrenador FOREIGN KEY (id_especialidad)
    REFERENCES Especialidades(id_especialidad)
)

-- 7. Tenistas (depende de Personas)
CREATE TABLE Tenistas(
    id_tenista INT PRIMARY KEY,
    lateralidad NVARCHAR(100),
    nivel_desempenio NVARCHAR(100),
    estatura_actual DECIMAL(4,2),
    peso_actual DECIMAL(5,1),
    CONSTRAINT FK_tenista_persona FOREIGN KEY (id_tenista) 
    REFERENCES Personas(id_persona)
)

-- 8. tipo_de_reves
CREATE TABLE tipo_de_reves(
    id_tipo_reves INT PRIMARY KEY,
    nombre NVARCHAR(100),
    descripcion NVARCHAR(100)
)

-- Tenista_tipo_reves (conecta tipo_de_reves con Tenistas)
CREATE TABLE Tenista_tipo_reves(
    id_tenista INT NOT NULL,
    id_tipo_reves INT NOT NULL,
    PRIMARY KEY (id_tenista, id_tipo_reves),
    FOREIGN KEY (id_tenista) REFERENCES Tenistas(id_tenista),
    FOREIGN KEY (id_tipo_reves) REFERENCES tipo_de_reves(id_tipo_reves)
)

--  Canchas 
CREATE TABLE Canchas(
    id_cancha INT PRIMARY KEY,
    superficie DECIMAL(10,2),
    nombre NVARCHAR(100),
    iluminacion BIT NOT NULL,
    descripcion NVARCHAR(100),
    a_foro_maximo DECIMAL(5,2),
    disponibilidad BIT NOT NULL,
    estado_de_mantenimiento NVARCHAR(100)
)

-- Sesiones (Sesiones referencia a Canchas)
CREATE TABLE Sesiones(
    id_sesion INT PRIMARY KEY,
    hora_inicio TIME,
    hora_finalizacion TIME,
    fecha DATE,
    id_entrenador INT NOT NULL,
    id_cancha INT NOT NULL,
    CONSTRAINT FK_sesion_entrenador FOREIGN KEY (id_entrenador)
    REFERENCES Entrenadores(id_entrenador),
    CONSTRAINT FK_sesion_cancha FOREIGN KEY (id_cancha)
    REFERENCES Canchas(id_cancha)
)

--  Tenista_sesion
CREATE TABLE Tenista_sesion(
    id_tenista INT NOT NULL,
    id_sesion INT NOT NULL,
    PRIMARY KEY (id_tenista, id_sesion),
    FOREIGN KEY (id_tenista) REFERENCES Tenistas(id_tenista),
    FOREIGN KEY (id_sesion) REFERENCES Sesiones(id_sesion)
)

-- Orientaciones
CREATE TABLE Orientaciones(
    id_tenista INT NOT NULL,
    id_entrenador INT NOT NULL,
    PRIMARY KEY (id_tenista, id_entrenador),
    FOREIGN KEY (id_tenista) REFERENCES Tenistas(id_tenista),
    FOREIGN KEY (id_entrenador) REFERENCES Entrenadores(id_entrenador)
)

-- . Mantenimientos (depende de Canchas)
CREATE TABLE Mantenimientos(
    id_mantenimiento INT PRIMARY KEY,
    id_cancha INT NOT NULL,
    fecha_realizacion DATE,
    fecha_programada DATE,
    CONSTRAINT FK_mantenimiento_cancha FOREIGN KEY (id_cancha)
    REFERENCES Canchas(id_cancha)
)

--  Fotos (depende de Canchas)
CREATE TABLE Fotos(
    id_fotos INT PRIMARY KEY,
    id_cancha INT NOT NULL,
    descripcion NVARCHAR(100),
    CONSTRAINT FK_foto_cancha FOREIGN KEY (id_cancha)
    REFERENCES Canchas(id_cancha)
)

-- Tipo_de_telefonos
CREATE TABLE Tipo_de_telefonos(
    id_tipo_telefono INT PRIMARY KEY,
    nombre NVARCHAR(100),
    descripcion NVARCHAR(100)
)

-- Telefonos 
CREATE TABLE Telefonos(
    id_telefono INT PRIMARY KEY,
    numero INT,
    id_persona INT NOT NULL,
    id_tipo_telefono INT NOT NULL,
    CONSTRAINT FK_telefono_persona FOREIGN KEY (id_persona)
    REFERENCES Personas(id_persona),
    CONSTRAINT FK_telefono_tipo FOREIGN KEY (id_tipo_telefono)
    REFERENCES Tipo_de_telefonos(id_tipo_telefono)
)

--  Cuentas_de_cobro 
CREATE TABLE Cuentas_de_cobro(
    id_cuenta_cobro INT PRIMARY KEY,
    id_persona INT NOT NULL,
    monto_a_pagar DECIMAL(10,2),
    descripcion NVARCHAR(100),
    monto_pagado DECIMAL(10,2),
    fecha_inicio DATE,
    fecha_limite DATE,
    CONSTRAINT FK_cuenta_persona FOREIGN KEY(id_persona)
    REFERENCES Personas(id_persona)
)

--  Estados_de_pago 
CREATE TABLE Estados_de_pago(
    id_estado_pago INT PRIMARY KEY,
    id_cuenta_cobro INT NOT NULL,
    nombre NVARCHAR(100),
    CONSTRAINT FK_estado_cuenta FOREIGN KEY (id_cuenta_cobro)
    REFERENCES Cuentas_de_cobro(id_cuenta_cobro)
)

--  Transacciones 
CREATE TABLE Transacciones(
    id_transacciones INT PRIMARY KEY,
    estado NVARCHAR(100),
    monto DECIMAL(10,2),
    id_cuenta_cobro INT NOT NULL,
    CONSTRAINT FK_transaccion_cuenta FOREIGN KEY (id_cuenta_cobro)
    REFERENCES Cuentas_de_cobro(id_cuenta_cobro)
)

--  Facturas 
CREATE TABLE Facturas(
    id_factura INT PRIMARY KEY,
    fecha DATE,
    id_transaccion INT NOT NULL,
    CONSTRAINT FK_factura_transaccion FOREIGN KEY(id_transaccion)
    REFERENCES Transacciones(id_transacciones)
)

-- Metodos_de_pago (depende de Transacciones)
CREATE TABLE Metodos_de_pago(
    id_metodo_pago INT PRIMARY KEY,
    nombre NVARCHAR(100),
    id_transaccion INT NOT NULL,
    CONSTRAINT FK_metodo_transaccion FOREIGN KEY(id_transaccion)
    REFERENCES Transacciones(id_transacciones)
)
