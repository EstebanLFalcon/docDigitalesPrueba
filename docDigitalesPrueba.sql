CREATE DATABASE [docDigitalesPrueba]
GO
use [docDigitalesPrueba2];

CREATE TABLE [dbo].[Tabla_Empleado](
	[Nombre_Empleado] [varchar](100) NOT NULL PRIMARY KEY,
	[RFC] [varchar](20) NOT NULL,
	[Puesto] [varchar](15) NULL,
	[Nombre_Sucursal] [varchar](50) NULL)

CREATE TABLE [dbo].[Tabla_Sucursal](
	[Nombre_Sucursal] [varchar](50) NOT NULL PRIMARY KEY,
	[Calle] [varchar](20) NULL,
	[Colonia] [varchar](20) NULL,
	[Num_Ext] [int] NULL,
	[Num_Int] [int] NULL,
	[CP] [int] NULL,
	[Ciudad] [varchar](30) NULL,
	[Pais] [varchar](25) NULL,
	[Correo_Dueno] [varchar](50) NULL)

CREATE TABLE [dbo].[Tabla_Usuario](
	[Email] [varchar](50) NOT NULL PRIMARY KEY,
	[RFC] [varchar](20) NOT NULL,
	[Nombre_Usuario] [varchar](100) NOT NULL,
	[Nombre_Empresa] [varchar](50) NOT NULL,
	[Contrasena] [varchar](20) NOT NULL)


ALTER TABLE [dbo].[Tabla_Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Tabla_Empleado_Tabla_Sucursal] FOREIGN KEY([Nombre_Sucursal])
REFERENCES [dbo].[Tabla_Sucursal] ([Nombre_Sucursal])
GO
ALTER TABLE [dbo].[Tabla_Empleado] CHECK CONSTRAINT [FK_Tabla_Empleado_Tabla_Sucursal]
GO
ALTER TABLE [dbo].[Tabla_Sucursal]  WITH CHECK ADD  CONSTRAINT [FK_Tabla_Sucursal_Tabla_Usuario] FOREIGN KEY([Correo_Dueno])
REFERENCES [dbo].[Tabla_Usuario] ([Email])
GO
ALTER TABLE [dbo].[Tabla_Sucursal] CHECK CONSTRAINT [FK_Tabla_Sucursal_Tabla_Usuario]
GO