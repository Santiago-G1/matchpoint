CREATE TABLE Personas (
	id_persona INT PRIMARY KEY,
	nombre NVARCHAR(30),
	apellido NVARCHAR(30),
	correo_electrónico NVARCHAR(50),
	fecha_nacimiento DATE,
	dirección_residencia NVARCHAR(50)
);

GO
CREATE TABLE Tipos_documento_identidad(
	id_tipo_documento INT PRIMARY KEY,
	nombre NVARCHAR(30),
	descripción NVARCHAR(100) NULL,

	CONSTRAINT uq_Tipos_documento_identidad_nombre UNIQUE (nombre)
);

GO
CREATE TABLE Documentos_de_identidad(
	id_documento_identidad INT PRIMARY KEY,
	número_documento INT,
	id_persona INT,
	id_tipo_documento INT,

	CONSTRAINT uq_Documentos_de_identidad_número_documento UNIQUE (número_documento),
	CONSTRAINT fk_Documentos_de_identidad_Personas FOREIGN KEY (id_persona)
		REFERENCES Personas(id_persona),
	CONSTRAINT fk_Documentos_de_identidad_Tipos_documento_identidad FOREIGN KEY (id_tipo_documento)
		REFERENCES Tipos_documento_identidad(id_tipo_documento)
);

GO
CREATE TABLE Tipos_teléfono(
	id_tipo_teléfono INT PRIMARY KEY,
	nombre NVARCHAR (30),
	descripción NVARCHAR (100) NULL,

	CONSTRAINT uq_Tipos_teléfono_nombre UNIQUE (nombre)
);

GO
CREATE TABLE Teléfonos (
	id_teléfono INT PRIMARY KEY,
	número INT,
	id_persona INT,
	id_tipo_teléfono INT,

	CONSTRAINT uq_Teléfonos_número UNIQUE (número),
	CONSTRAINT fk_Teléfonos_id_persona FOREIGN KEY (id_persona)
		REFERENCES Personas(id_persona),
	CONSTRAINT fk_Teléfonos_id_tipo_teléfono FOREIGN KEY (id_tipo_teléfono)
		REFERENCES Tipos_teléfono(id_tipo_teléfono)
);

GO 
CREATE TABLE Cargos(
	id_cargo INT PRIMARY KEY,
	nombre NVARCHAR (30),
	descripción NVARCHAR (100)NULL,

	CONSTRAINT uq_Cargos_nombre UNIQUE (nombre)
);

GO
CREATE TABLE Empleados (
	id_persona INT,
	fecha_contratación DATE,
	id_cargo INT,

	CONSTRAINT pk_Empleados PRIMARY KEY (id_persona),
	CONSTRAINT fk_Empleados_id_persona FOREIGN KEY (id_persona) 
		REFERENCES Personas (id_persona),
	CONSTRAINT fk_Empleados_id_cargo FOREIGN KEY (id_cargo) 
		REFERENCES Cargos (id_cargo)
);

GO
CREATE TABLE Niveles_de_desmpeño (
	id_nivel_desempeño INT PRIMARY KEY,
	nombre NVARCHAR(30),
	descripción NVARCHAR (100) NULL,

	CONSTRAINT uq_Niveles_de_desmpeño_nombre UNIQUE (nombre)
);

GO
CREATE TABLE Tenistas (
	id_persona INT,
	lateralidad NVARCHAR(30),
	id_nivel_desempeño INT,
	estatura_actual DECIMAL(4,2),
	peso_actual DECIMAL(5,2),

	CONSTRAINT pk_Tenistas PRIMARY KEY (id_persona),
	CONSTRAINT fk_Tenistas_id_persona FOREIGN KEY (id_persona)
		REFERENCES Personas (id_persona),
	CONSTRAINT fk_Tenistas_id_nivel_desempeño FOREIGN KEY (id_nivel_desempeño)
		REFERENCES Niveles_de_desmpeño (id_nivel_desempeño),
	CONSTRAINT chk_Tenistas_estatura_actual CHECK (estatura_actual >0),
	CONSTRAINT chk_Tenistas_peso_actual CHECK (peso_actual >0)
);

GO
CREATE TABLE Tipos_de_revés (
	id_tipo_revés INT PRIMARY KEY,
	nombre NVARCHAR (30),
	descripción NVARCHAR (100) NULL,

	CONSTRAINT uq_Tipos_de_revés_nombre UNIQUE (nombre)
);

GO
CREATE TABLE Tenistas_revés (
	id_tenista INT,
	id_tipo_revés INT,

	CONSTRAINT pk_Tenistas_revés PRIMARY KEY (id_tenista,id_tipo_revés),
	CONSTRAINT fk_Tenistas_revés_id_tenista FOREIGN KEY (id_tenista)
		REFERENCES Tenistas (id_persona),
	CONSTRAINT fk_Tenistas_revés_id_tipo_revés FOREIGN KEY (id_tipo_revés)
		REFERENCES Tipos_de_revés (id_tipo_revés)
);

GO
CREATE TABLE Acudientes (
	id_acudiente INT,
	id_tenista INT,

	CONSTRAINT pk_Acudientes PRIMARY KEY (id_acudiente,id_tenista),
	CONSTRAINT fk_Acudientes_id_acudiente FOREIGN KEY (id_acudiente)
		REFERENCES Personas (id_persona),
	CONSTRAINT fk_Acudientes_id_tenista FOREIGN KEY (id_tenista)
		REFERENCES Tenistas (id_persona),
);

GO
CREATE TABLE Entrenadores (
	id_persona INT,
	fecha_vinculación DATE,
	número_certificación INT,
	fecha_expiración_licencia DATE,
	fecha_expedición_licencia DATE,

	CONSTRAINT pk_Entrenadores PRIMARY KEY (id_persona),
	CONSTRAINT fk_Entrenadores_id_persona FOREIGN KEY (id_persona)
		REFERENCES Personas (id_persona),
	CONSTRAINT uq_Entrenadores_número_certificación UNIQUE (número_certificación)
);

GO
CREATE TABLE Orientaciones (
	id_teninsta INT,
	id_entrenador INT,

	CONSTRAINT pk_Orientaciones PRIMARY KEY (id_teninsta,id_entrenador),
	CONSTRAINT fk_Orientaciones_id_teninsta FOREIGN KEY (id_teninsta)
		REFERENCES Tenistas (id_persona),
	CONSTRAINT fk_Orientaciones_id_entrenador FOREIGN KEY (id_entrenador)
		REFERENCES Entrenadores (id_persona)
);

GO
CREATE TABLE Especialidades (
	id_especialidad INT PRIMARY KEY,
	nombre NVARCHAR (30),
	descripción NVARCHAR (100) NULL,

	CONSTRAINT uq_Especialidades_nombre UNIQUE (nombre)
);

GO
CREATE TABLE Especialidades_de_entrenadores (
	id_entrenador INT,
	id_especialidad INT,

	CONSTRAINT pk_Especialidades_de_entrenadores PRIMARY KEY (id_entrenador,id_especialidad),
	CONSTRAINT fk_Especialidades_de_entrenadores FOREIGN KEY (id_entrenador)
		REFERENCES Entrenadores (id_persona),
	CONSTRAINT fk_Especialidades_de_entrenadores FOREIGN KEY (id_especialidad)
		REFERENCES Especialidades (id_especialidad)
);

GO
CREATE TABLE Tipos_de_superficie (
	id_tipo_superficie INT PRIMARY KEY,
	nombre NVARCHAR(30),
	descripción NVARCHAR(100) NULL,

	CONSTRAINT uq_Tipos_de_superficie_nombre UNIQUE (nombre)
);

GO
CREATE TABLE Tipos_de_disponibilidad (
	id_tipo_disponibilidad INT PRIMARY KEY,
	nombre NVARCHAR (30),
	descripción NVARCHAR (100) NULL,

	CONSTRAINT uq_Tipos_de_disponibilidad_nombre UNIQUE (nombre)
);

GO
CREATE TABLE Estados_de_mantenimiento (
	id_estado_mantenimiento INT PRIMARY KEY,
	nombre NVARCHAR (30),
	descripción NVARCHAR (100) NULL,

	CONSTRAINT uq_Estados_de_mantenimiento_nombre UNIQUE (nombre)
);

GO
CREATE TABLE Canchas (
	id_cancha INT PRIMARY KEY,
	nombre NVARCHAR(50),
	iluminación BIT,
	aforo_máximo INT,
	actividad BIT,
	id_tipo_superficie INT,
	id_disponibilidad INT,
	id_estado_mantenimiento INT,

	CONSTRAINT uq_Canchas_nombre UNIQUE (nombre),
	CONSTRAINT fk_Canchas_id_tipo_superficie FOREIGN KEY (id_tipo_superficie)
		REFERENCES Tipos_de_superficie (id_tipo_superficie),
	CONSTRAINT fk_Canchas_id_disponibilidad FOREIGN KEY (id_disponibilidad)
		REFERENCES Tipos_de_disponibilidad (id_tipo_disponibilidad),
	CONSTRAINT fk_Canchas_id_estado_mantenimiento FOREIGN KEY (id_estado_mantenimiento)
		REFERENCES Estados_de_mantenimiento (id_estado_mantenimiento)
);

GO
CREATE TABLE Fotos (
	id_foto INT PRIMARY KEY,
	id_cancha INT,
	descripción NVARCHAR (100) NULL,

	CONSTRAINT fk_Fotos_id_cancha FOREIGN KEY (id_cancha)
		REFERENCES Canchas(id_cancha)
);

GO
CREATE TABLE Mantenimientos (
	id_mantenimiento INT PRIMARY KEY,
	id_cancha INT,
	fecha_programada DATE,
	fecha_realización DATE,
	observaciones NVARCHAR (200) NULL,

	CONSTRAINT fk_Mantenimientos_id_cancha FOREIGN KEY (id_cancha)
		REFERENCES Canchas(id_cancha)
);

GO
CREATE TABLE Horarios_disponibilidad_canchas (
	id_horarion INT PRIMARY KEY,
	id_cancha INT,
	fecha DATE,
	hora_inicio TIME,
	hora_fin TIME,

	CONSTRAINT fk_Horarios_disponibilidad_canchas_id_cancha FOREIGN KEY(id_cancha)
		REFERENCES Canchas(id_cancha)
);

GO 
CREATE TABLE Sesiones (
	id_sesión INT PRIMARY KEY,
	fecha DATE,
	hora_inicio TIME,
	hora_finalización TIME,
	id_cancha INT,
	id_entrenador INT,

	CONSTRAINT fk_Sesiones_id_cancha FOREIGN KEY (id_cancha)
		REFERENCES Canchas(id_cancha),
	CONSTRAINT fk_Sesiones_id_entrenador FOREIGN KEY (id_entrenador)
		REFERENCES Entrenadores(id_persona)
);

GO
CREATE TABLE Tenistas_sesiones (
	id_tenista INT,
	id_sesión INT,

	CONSTRAINT pk_Tenistas_sesiones PRIMARY KEY (id_tenista,id_sesión),
	CONSTRAINT fk_Tenistas_sesiones_id_tenista FOREIGN KEY (id_tenista)
		REFERENCES Tenistas (id_personas),
	CONSTRAINT fk_Tenistas_sesiones_id_sesión FOREIGN KEY (id_sesión)
		REFERENCES Sesiones (id_sesión),
);

GO
CREATE TABLE Conceptos_de_cobro (
	id_concepto INT PRIMARY KEY,
	nombre NVARCHAR (30),
	descripción NVARCHAR (100) NULL,
	precio DECIMAL (5,2),

	CONSTRAINT uq_Conceptos_de_cobro_nombre UNIQUE (nombre)
);

GO
CREATE TABLE Métodos_de_pago (
	id_método INT PRIMARY KEY,
	nombre NVARCHAR (30),
	descripción NVARCHAR (100) NULL,

	CONSTRAINT uq_Métodos_de_pago_nombre UNIQUE (nombre)
);

GO
CREATE TABLE Pagos (
	id_pago INT PRIMARY KEY,
	id_persona INT,
	id_concepto_cobro INT,
	precio_real_pagado DECIMAL(5,2),
	fecha_realización DATE,
	método_pago_usado INT,
	observaciones NVARCHAR(100) NULL,

	CONSTRAINT fk_Pagos_id_persona FOREIGN KEY (id_persona)
		REFERENCES Personas (id_persona),
	CONSTRAINT fk_Pagos_id_concepto_cobro FOREIGN KEY (id_concepto_cobro)
		REFERENCES Conceptos_de_cobro (id_concepto),
	CONSTRAINT chk_Pagos_precio_real_pagado CHECK (precio_real_pagado >0),
	CONSTRAINT fk_Pagos_método_pago_usado FOREIGN KEY (método_pago_usado)
		REFERENCES Métodos_de_pago (id_método),
);

GO
CREATE TABLE Estados_de_pago (
	id_estado_pago INT PRIMARY KEY,
	nombre NVARCHAR (30),
	descripción NVARCHAR (100) NULL,

	CONSTRAINT uq_Estados_de_pago_nombre UNIQUE (nombre)
);

GO
CREATE TABLE Historial_estados_de_pago (
	id_pago INT,
	id_estado_pago INT,
	fecha_de_registro DATE,

	CONSTRAINT pk_Historial_estados_de_pago PRIMARY KEY (id_pago,id_estado_pago),
	CONSTRAINT fk_Historial_estados_de_pago_id_pago FOREIGN KEY (id_pago)
		REFERENCES Pagos (id_pago),
	CONSTRAINT fk_Historial_estados_de_pago_id_estado_pagoo FOREIGN KEY (id_estado_pago)
		REFERENCES Estados_de_pago (id_estado_pagos)
);