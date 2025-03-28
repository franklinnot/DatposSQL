USE [master]
GO
/****** Object:  Database [datpos_project]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE DATABASE [datpos_project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'datpos_project', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\datpos_project.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'datpos_project_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\datpos_project_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [datpos_project] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [datpos_project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [datpos_project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [datpos_project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [datpos_project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [datpos_project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [datpos_project] SET ARITHABORT OFF 
GO
ALTER DATABASE [datpos_project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [datpos_project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [datpos_project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [datpos_project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [datpos_project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [datpos_project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [datpos_project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [datpos_project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [datpos_project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [datpos_project] SET  DISABLE_BROKER 
GO
ALTER DATABASE [datpos_project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [datpos_project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [datpos_project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [datpos_project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [datpos_project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [datpos_project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [datpos_project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [datpos_project] SET RECOVERY FULL 
GO
ALTER DATABASE [datpos_project] SET  MULTI_USER 
GO
ALTER DATABASE [datpos_project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [datpos_project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [datpos_project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [datpos_project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [datpos_project] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [datpos_project] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'datpos_project', N'ON'
GO
ALTER DATABASE [datpos_project] SET QUERY_STORE = OFF
GO
USE [datpos_project]
GO
/****** Object:  UserDefinedTableType [dbo].[ud_accesos_rol]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE TYPE [dbo].[ud_accesos_rol] AS TABLE(
	[id_acceso] [bigint] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ud_detalles_variante]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE TYPE [dbo].[ud_detalles_variante] AS TABLE(
	[nombre] [nvarchar](128) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ud_usuarios_almacen]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE TYPE [dbo].[ud_usuarios_almacen] AS TABLE(
	[id_almacen] [bigint] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ud_usuarios_sucursal]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE TYPE [dbo].[ud_usuarios_sucursal] AS TABLE(
	[id_sucursal] [bigint] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ud_variantes]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE TYPE [dbo].[ud_variantes] AS TABLE(
	[nombre] [nvarchar](128) NULL
)
GO
/****** Object:  Table [dbo].[acceso]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[acceso](
	[id_acceso] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[ruta] [nvarchar](128) NOT NULL,
	[estado] [char](1) NOT NULL,
 CONSTRAINT [PK__acceso__F2593D4AAE6B9B9A] PRIMARY KEY CLUSTERED 
(
	[id_acceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[acceso_rol]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[acceso_rol](
	[id_acceso_rol] [bigint] IDENTITY(1,1) NOT NULL,
	[id_acceso] [bigint] NOT NULL,
	[id_rol] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_acceso_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[almacen]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[almacen](
	[id_almacen] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [nvarchar](24) NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[departamento] [nvarchar](64) NULL,
	[ciudad] [nvarchar](64) NULL,
	[direccion] [nvarchar](255) NULL,
	[estado] [char](1) NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__almacen__098D5D1308D5AD44] PRIMARY KEY CLUSTERED 
(
	[id_almacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[asociado]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[asociado](
	[id_asociado] [bigint] IDENTITY(1,1) NOT NULL,
	[ruc] [char](11) NULL,
	[dni] [char](8) NULL,
	[nombre] [nvarchar](255) NOT NULL,
	[telefono] [nvarchar](32) NULL,
	[correo] [nvarchar](255) NULL,
	[tipo_asociado] [char](1) NOT NULL,
	[estado] [char](1) NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__asociado__3BF69789F1B111DE] PRIMARY KEY CLUSTERED 
(
	[id_asociado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caja]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caja](
	[id_caja] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [nvarchar](24) NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[estado] [char](1) NOT NULL,
	[id_sucursal] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__caja__C71E247686F81729] PRIMARY KEY CLUSTERED 
(
	[id_caja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[comprobante_pago]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comprobante_pago](
	[id_comprobante_pago] [bigint] IDENTITY(1,1) NOT NULL,
	[numero] [nvarchar](128) NOT NULL,
	[serie] [nvarchar](64) NOT NULL,
	[codigo] [nvarchar](64) NULL,
	[estado] [char](1) NOT NULL,
	[id_tipo_comprobante] [bigint] NOT NULL,
	[id_venta] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__comproba__AEE83DFD95867588] PRIMARY KEY CLUSTERED 
(
	[id_comprobante_pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalle_lista_precios]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_lista_precios](
	[id_detalle_lista_precios] [bigint] IDENTITY(1,1) NOT NULL,
	[precio_unitario] [float] NOT NULL,
	[descuento_maximo] [float] NULL,
	[id_lista_precios] [bigint] NOT NULL,
	[id_producto] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_detalle_lista_precios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalle_operacion]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_operacion](
	[id_detalle_operacion] [bigint] IDENTITY(1,1) NOT NULL,
	[costo_unitario] [float] NOT NULL,
	[cantidad] [int] NOT NULL,
	[id_operacion] [bigint] NOT NULL,
	[id_producto] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_detalle_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalle_variante]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_variante](
	[id_detalle_variante] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[estado] [char](1) NOT NULL,
	[id_variante] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__detalle___F00315950B639D55] PRIMARY KEY CLUSTERED 
(
	[id_detalle_variante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalle_venta]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_venta](
	[id_detalle_venta] [bigint] IDENTITY(1,1) NOT NULL,
	[precio_unitario] [float] NOT NULL,
	[cantidad] [int] NOT NULL,
	[subtotal_bruto] [float] NOT NULL,
	[descuento] [float] NOT NULL,
	[subtotal] [float] NOT NULL,
	[igv] [float] NOT NULL,
	[isc] [float] NULL,
	[total] [float] NOT NULL,
	[id_venta] [bigint] NOT NULL,
	[id_detalle_lista_precios] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_detalle_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[empresa](
	[id_empresa] [bigint] IDENTITY(1,1) NOT NULL,
	[ruc] [char](11) NOT NULL,
	[razon_social] [nvarchar](128) NOT NULL,
	[nombre_comercial] [nvarchar](128) NOT NULL,
	[email] [nvarchar](128) NULL,
	[telefono] [nvarchar](32) NOT NULL,
	[departamento] [nvarchar](64) NOT NULL,
	[ciudad] [nvarchar](64) NOT NULL,
	[direccion] [nvarchar](255) NOT NULL,
	[igv] [float] NOT NULL,
	[monto_maximo_boleta] [float] NOT NULL,
	[facturacion_electronica] [char](1) NOT NULL,
	[cantidad_sucursales] [int] NOT NULL,
	[cantidad_usuarios] [int] NOT NULL,
	[sucursales_registradas] [int] NOT NULL,
	[usuarios_registrados] [int] NOT NULL,
	[dias_plazo] [int] NOT NULL,
	[logo] [varbinary](max) NULL,
	[estado] [char](1) NOT NULL,
 CONSTRAINT [PK__empresa__4A0B7E2C70053C8C] PRIMARY KEY CLUSTERED 
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[failed_jobs]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[failed_jobs](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[uuid] [nvarchar](255) NOT NULL,
	[connection] [nvarchar](max) NOT NULL,
	[queue] [nvarchar](max) NOT NULL,
	[payload] [nvarchar](max) NOT NULL,
	[exception] [nvarchar](max) NOT NULL,
	[failed_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[familia]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[familia](
	[id_familia] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [nvarchar](24) NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[color] [char](7) NULL,
	[estado] [char](1) NOT NULL,
	[id_tipo_producto] [char](1) NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__familia__609C4852C9594342] PRIMARY KEY CLUSTERED 
(
	[id_familia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lista_precios]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lista_precios](
	[id_lista_precios] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [nvarchar](24) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[fecha_inicio_vigencia] [date] NOT NULL,
	[fecha_fin_vigencia] [date] NULL,
	[es_preferencial] [char](1) NOT NULL,
	[estado] [char](1) NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__lista_pr__8423FAE7D5A3A20B] PRIMARY KEY CLUSTERED 
(
	[id_lista_precios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[metodo_pago]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[metodo_pago](
	[id_metodo_pago] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[estado] [char](1) NOT NULL,
 CONSTRAINT [PK__metodo_p__85BE0EBC328E8AD8] PRIMARY KEY CLUSTERED 
(
	[id_metodo_pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[migrations]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[migrations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[migration] [nvarchar](255) NOT NULL,
	[batch] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[operacion]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[operacion](
	[id_operacion] [bigint] IDENTITY(1,1) NOT NULL,
	[fecha_operacion] [datetime] NOT NULL,
	[fecha_actualizacion] [datetime] NULL,
	[serie] [nvarchar](128) NOT NULL,
	[numero] [nvarchar](128) NOT NULL,
	[codigo] [nvarchar](128) NULL,
	[estado] [char](1) NOT NULL,
	[id_usuario] [bigint] NOT NULL,
	[id_almacen_origen] [bigint] NULL,
	[id_almacen_destino] [bigint] NULL,
	[id_tipo_operacion] [bigint] NOT NULL,
	[id_asociado] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__operacio__AC60F4268B942FFE] PRIMARY KEY CLUSTERED 
(
	[id_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pago]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pago](
	[id_pago] [bigint] IDENTITY(1,1) NOT NULL,
	[monto_pagado] [float] NOT NULL,
	[cambio] [float] NOT NULL,
	[numero_tarjeta] [nvarchar](128) NULL,
	[estado] [char](1) NOT NULL,
	[id_metodo_pago] [bigint] NOT NULL,
	[id_venta] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__pago__0941B074184E7B74] PRIMARY KEY CLUSTERED 
(
	[id_pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pago_tarifa]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pago_tarifa](
	[id_pago_tarifa] [bigint] IDENTITY(1,1) NOT NULL,
	[fecha_pago] [datetime] NOT NULL,
	[fecha_inicio] [date] NOT NULL,
	[fecha_renovacion] [date] NOT NULL,
	[duracion_meses] [int] NOT NULL,
	[monto] [float] NOT NULL,
	[estado] [char](1) NOT NULL,
	[id_tipo_tarifa] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__pago_tar__F7B7BAB112A07BB5] PRIMARY KEY CLUSTERED 
(
	[id_pago_tarifa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[password_reset_tokens]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[password_reset_tokens](
	[email] [nvarchar](255) NOT NULL,
	[token] [nvarchar](255) NOT NULL,
	[created_at] [datetime] NULL,
 CONSTRAINT [password_reset_tokens_email_primary] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personal_access_tokens]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personal_access_tokens](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[tokenable_type] [nvarchar](255) NOT NULL,
	[tokenable_id] [bigint] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[token] [nvarchar](64) NOT NULL,
	[abilities] [nvarchar](max) NULL,
	[last_used_at] [datetime] NULL,
	[expires_at] [datetime] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[precios_sucursal]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[precios_sucursal](
	[id_precios_sucursal] [bigint] IDENTITY(1,1) NOT NULL,
	[id_sucursal] [bigint] NOT NULL,
	[id_lista_precios] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_precios_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[producto](
	[id_producto] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [nvarchar](128) NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[stock_minimo] [int] NULL,
	[stock_maximo] [int] NULL,
	[imagen] [nvarchar](max) NULL,
	[fecha_vencimiento] [date] NULL,
	[alerta_stock] [char](1) NULL,
	[alerta_vencimiento] [char](1) NULL,
	[tiene_igv] [char](1) NOT NULL,
	[isc] [float] NULL,
	[estado] [char](1) NOT NULL,
	[id_familia] [bigint] NOT NULL,
	[id_unidad_medida] [bigint] NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__producto__FF341C0D887D8063] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto_almacen]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[producto_almacen](
	[id_producto_almacen] [bigint] IDENTITY(1,1) NOT NULL,
	[stock] [int] NOT NULL,
	[id_producto] [bigint] NOT NULL,
	[id_almacen] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_producto_almacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[retiro_dinero]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[retiro_dinero](
	[id_retiro_dinero] [bigint] IDENTITY(1,1) NOT NULL,
	[fecha_retiro] [datetime] NOT NULL,
	[saldo_actual] [float] NOT NULL,
	[monto_retirado] [float] NOT NULL,
	[saldo_restante] [float] NOT NULL,
	[id_turno_caja] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_retiro_dinero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol](
	[id_rol] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [nvarchar](24) NULL,
	[nombre] [nvarchar](64) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[estado] [char](1) NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__rol__6ABCB5E0999D282C] PRIMARY KEY CLUSTERED 
(
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sucursal]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sucursal](
	[id_sucursal] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [nvarchar](24) NOT NULL,
	[nombre] [nvarchar](64) NOT NULL,
	[departamento] [nvarchar](64) NULL,
	[ciudad] [nvarchar](64) NULL,
	[direccion] [nvarchar](255) NULL,
	[telefono] [nvarchar](32) NULL,
	[estado] [char](1) NOT NULL,
	[id_almacen] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__sucursal__4C758013F6EBD20E] PRIMARY KEY CLUSTERED 
(
	[id_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_comprobante]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipo_comprobante](
	[id_tipo_comprobante] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](64) NOT NULL,
	[igv] [float] NOT NULL,
	[estado] [char](1) NOT NULL,
	[serie] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK__tipo_com__CDF2A6D246683B6E] PRIMARY KEY CLUSTERED 
(
	[id_tipo_comprobante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_operacion]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipo_operacion](
	[id_tipo_operacion] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[tipo_operacion] [char](1) NOT NULL,
	[estado] [char](1) NULL,
	[serie] [nvarchar](128) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__tipo_ope__8AB1EA781EF23840] PRIMARY KEY CLUSTERED 
(
	[id_tipo_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_producto]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipo_producto](
	[id_tipo_producto] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[estado] [char](1) NOT NULL,
 CONSTRAINT [PK__tipo_pro__F5E0BFB8E3A5D28E] PRIMARY KEY CLUSTERED 
(
	[id_tipo_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_tarifa]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipo_tarifa](
	[id_tipo_tarifa] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
	[monto] [float] NOT NULL,
	[duracion_meses] [int] NOT NULL,
	[cantidad_sucursales] [int] NOT NULL,
	[cantidad_usuarios] [int] NOT NULL,
	[estado] [char](1) NOT NULL,
 CONSTRAINT [PK__tipo_tar__AC577B3D7AC48F26] PRIMARY KEY CLUSTERED 
(
	[id_tipo_tarifa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[turno_caja]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[turno_caja](
	[id_turno_caja] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [nvarchar](24) NOT NULL,
	[fecha_apertura] [datetime] NOT NULL,
	[fecha_cierre] [datetime] NULL,
	[saldo_inicial] [float] NOT NULL,
	[total_ventas] [float] NULL,
	[total_retirado] [float] NULL,
	[saldo_facturado] [float] NULL,
	[saldo_entregado] [float] NULL,
	[diferencia_saldo] [float] NULL,
	[estado] [char](1) NOT NULL,
	[id_usuario] [bigint] NOT NULL,
	[id_caja] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__turno_ca__8A54E044DD98022E] PRIMARY KEY CLUSTERED 
(
	[id_turno_caja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[unidad_medida]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[unidad_medida](
	[id_unidad_medida] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [nvarchar](24) NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[estado] [char](1) NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__unidad_m__2F721BD3121D751B] PRIMARY KEY CLUSTERED 
(
	[id_unidad_medida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[id_usuario] [bigint] IDENTITY(1,1) NOT NULL,
	[dni] [char](8) NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[email_verified_at] [datetime] NULL,
	[password] [nvarchar](255) NOT NULL,
	[remember_token] [nvarchar](100) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[estado] [char](1) NOT NULL,
	[id_rol] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__usuario__4E3E04AD49173472] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario_almacen]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario_almacen](
	[id_usuario_almacen] [bigint] IDENTITY(1,1) NOT NULL,
	[id_usuario] [bigint] NOT NULL,
	[id_almacen] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario_almacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario_sucursal]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario_sucursal](
	[id_usuario_sucursal] [bigint] IDENTITY(1,1) NOT NULL,
	[id_usuario] [bigint] NOT NULL,
	[id_sucursal] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[variante]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[variante](
	[id_variante] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[estado] [char](1) NOT NULL,
	[id_producto] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__variante__85058CA98FE71712] PRIMARY KEY CLUSTERED 
(
	[id_variante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[venta]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[venta](
	[id_venta] [bigint] IDENTITY(1,1) NOT NULL,
	[suma_subtotal_bruto] [float] NOT NULL,
	[suma_descuento] [float] NOT NULL,
	[suma_subtotal] [float] NOT NULL,
	[suma_impuesto] [float] NOT NULL,
	[suma_total] [float] NOT NULL,
	[fecha_venta] [datetime] NOT NULL,
	[fecha_actualizacion] [datetime] NULL,
	[es_preventa] [char](10) NOT NULL,
	[estado] [char](1) NOT NULL,
	[id_turno_caja] [bigint] NOT NULL,
	[id_asociado] [bigint] NOT NULL,
	[id_empresa] [bigint] NOT NULL,
 CONSTRAINT [PK__venta__459533BF691DB1E0] PRIMARY KEY CLUSTERED 
(
	[id_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_acceso_rol_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_acceso_rol_id_empresa] ON [dbo].[acceso_rol]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_almacen_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [idx_almacen_codigo] ON [dbo].[almacen]
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_almacen_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_almacen_id_empresa] ON [dbo].[almacen]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_asociado_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_asociado_id_empresa] ON [dbo].[asociado]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_caja_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [idx_caja_codigo] ON [dbo].[caja]
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_caja_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_caja_id_empresa] ON [dbo].[caja]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_comprobante_pago_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_comprobante_pago_id_empresa] ON [dbo].[comprobante_pago]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_detalle_lista_precios_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_detalle_lista_precios_id_empresa] ON [dbo].[detalle_lista_precios]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_detalle_operacion_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_detalle_operacion_id_empresa] ON [dbo].[detalle_operacion]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_detalle_variante_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_detalle_variante_id_empresa] ON [dbo].[detalle_variante]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_detalle_venta_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_detalle_venta_id_empresa] ON [dbo].[detalle_venta]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_empresa_ruc]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_empresa_ruc] ON [dbo].[empresa]
(
	[ruc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [failed_jobs_uuid_unique]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [failed_jobs_uuid_unique] ON [dbo].[failed_jobs]
(
	[uuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_familia_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [idx_familia_codigo] ON [dbo].[familia]
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_familia_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_familia_id_empresa] ON [dbo].[familia]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_lista_precios_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_lista_precios_id_empresa] ON [dbo].[lista_precios]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_operacion_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_operacion_id_empresa] ON [dbo].[operacion]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_pago_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_pago_id_empresa] ON [dbo].[pago]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [personal_access_tokens_token_unique]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [personal_access_tokens_token_unique] ON [dbo].[personal_access_tokens]
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [personal_access_tokens_tokenable_type_tokenable_id_index]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [personal_access_tokens_tokenable_type_tokenable_id_index] ON [dbo].[personal_access_tokens]
(
	[tokenable_type] ASC,
	[tokenable_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_producto_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_producto_id_empresa] ON [dbo].[producto]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_producto_almacen_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_producto_almacen_id_empresa] ON [dbo].[producto_almacen]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_retiro_dinero_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_retiro_dinero_id_empresa] ON [dbo].[retiro_dinero]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_rol_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [idx_rol_codigo] ON [dbo].[rol]
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_rol_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_rol_id_empresa] ON [dbo].[rol]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_sucursal_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [idx_sucursal_codigo] ON [dbo].[sucursal]
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tipo_operacion_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_tipo_operacion_id_empresa] ON [dbo].[tipo_operacion]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_turno_caja_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_turno_caja_id_empresa] ON [dbo].[turno_caja]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_unidad_medida_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [idx_unidad_medida_codigo] ON [dbo].[unidad_medida]
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_unidad_medida_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_unidad_medida_id_empresa] ON [dbo].[unidad_medida]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_usuario_dni]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [idx_usuario_dni] ON [dbo].[usuario]
(
	[dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_usuario_email]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_usuario_email] ON [dbo].[usuario]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [usuario_email_unique]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [usuario_email_unique] ON [dbo].[usuario]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_usuario_almacen_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_usuario_almacen_id_empresa] ON [dbo].[usuario_almacen]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_variante_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_variante_id_empresa] ON [dbo].[variante]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_venta_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_venta_id_empresa] ON [dbo].[venta]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[failed_jobs] ADD  DEFAULT (getdate()) FOR [failed_at]
GO
ALTER TABLE [dbo].[acceso_rol]  WITH CHECK ADD  CONSTRAINT [acceso_rol_id] FOREIGN KEY([id_rol])
REFERENCES [dbo].[rol] ([id_rol])
GO
ALTER TABLE [dbo].[acceso_rol] CHECK CONSTRAINT [acceso_rol_id]
GO
ALTER TABLE [dbo].[acceso_rol]  WITH CHECK ADD  CONSTRAINT [Relation_61] FOREIGN KEY([id_acceso])
REFERENCES [dbo].[acceso] ([id_acceso])
GO
ALTER TABLE [dbo].[acceso_rol] CHECK CONSTRAINT [Relation_61]
GO
ALTER TABLE [dbo].[acceso_rol]  WITH CHECK ADD  CONSTRAINT [Relation_acceso_rol_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[acceso_rol] CHECK CONSTRAINT [Relation_acceso_rol_id_empresa]
GO
ALTER TABLE [dbo].[almacen]  WITH CHECK ADD  CONSTRAINT [Relation_almacen_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[almacen] CHECK CONSTRAINT [Relation_almacen_id_empresa]
GO
ALTER TABLE [dbo].[asociado]  WITH CHECK ADD  CONSTRAINT [Relation_asociado_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[asociado] CHECK CONSTRAINT [Relation_asociado_id_empresa]
GO
ALTER TABLE [dbo].[caja]  WITH CHECK ADD  CONSTRAINT [Relation_23] FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[sucursal] ([id_sucursal])
GO
ALTER TABLE [dbo].[caja] CHECK CONSTRAINT [Relation_23]
GO
ALTER TABLE [dbo].[caja]  WITH CHECK ADD  CONSTRAINT [Relation_caja_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[caja] CHECK CONSTRAINT [Relation_caja_id_empresa]
GO
ALTER TABLE [dbo].[comprobante_pago]  WITH CHECK ADD  CONSTRAINT [Relation_50] FOREIGN KEY([id_venta])
REFERENCES [dbo].[venta] ([id_venta])
GO
ALTER TABLE [dbo].[comprobante_pago] CHECK CONSTRAINT [Relation_50]
GO
ALTER TABLE [dbo].[comprobante_pago]  WITH CHECK ADD  CONSTRAINT [Relation_55] FOREIGN KEY([id_tipo_comprobante])
REFERENCES [dbo].[tipo_comprobante] ([id_tipo_comprobante])
GO
ALTER TABLE [dbo].[comprobante_pago] CHECK CONSTRAINT [Relation_55]
GO
ALTER TABLE [dbo].[comprobante_pago]  WITH CHECK ADD  CONSTRAINT [Relation_comprobante_pago_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[comprobante_pago] CHECK CONSTRAINT [Relation_comprobante_pago_id_empresa]
GO
ALTER TABLE [dbo].[detalle_lista_precios]  WITH CHECK ADD  CONSTRAINT [Relation_65] FOREIGN KEY([id_lista_precios])
REFERENCES [dbo].[lista_precios] ([id_lista_precios])
GO
ALTER TABLE [dbo].[detalle_lista_precios] CHECK CONSTRAINT [Relation_65]
GO
ALTER TABLE [dbo].[detalle_lista_precios]  WITH CHECK ADD  CONSTRAINT [Relation_68] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
GO
ALTER TABLE [dbo].[detalle_lista_precios] CHECK CONSTRAINT [Relation_68]
GO
ALTER TABLE [dbo].[detalle_lista_precios]  WITH CHECK ADD  CONSTRAINT [Relation_detalle_lista_precios_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[detalle_lista_precios] CHECK CONSTRAINT [Relation_detalle_lista_precios_id_empresa]
GO
ALTER TABLE [dbo].[detalle_operacion]  WITH CHECK ADD  CONSTRAINT [Relation_58] FOREIGN KEY([id_operacion])
REFERENCES [dbo].[operacion] ([id_operacion])
GO
ALTER TABLE [dbo].[detalle_operacion] CHECK CONSTRAINT [Relation_58]
GO
ALTER TABLE [dbo].[detalle_operacion]  WITH CHECK ADD  CONSTRAINT [Relation_59] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
GO
ALTER TABLE [dbo].[detalle_operacion] CHECK CONSTRAINT [Relation_59]
GO
ALTER TABLE [dbo].[detalle_operacion]  WITH CHECK ADD  CONSTRAINT [Relation_detalle_operacion_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[detalle_operacion] CHECK CONSTRAINT [Relation_detalle_operacion_id_empresa]
GO
ALTER TABLE [dbo].[detalle_variante]  WITH CHECK ADD  CONSTRAINT [Relation_83] FOREIGN KEY([id_variante])
REFERENCES [dbo].[variante] ([id_variante])
GO
ALTER TABLE [dbo].[detalle_variante] CHECK CONSTRAINT [Relation_83]
GO
ALTER TABLE [dbo].[detalle_variante]  WITH CHECK ADD  CONSTRAINT [Relation_detalle_variante_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[detalle_variante] CHECK CONSTRAINT [Relation_detalle_variante_id_empresa]
GO
ALTER TABLE [dbo].[detalle_venta]  WITH CHECK ADD  CONSTRAINT [Relation_49] FOREIGN KEY([id_detalle_lista_precios])
REFERENCES [dbo].[detalle_lista_precios] ([id_detalle_lista_precios])
GO
ALTER TABLE [dbo].[detalle_venta] CHECK CONSTRAINT [Relation_49]
GO
ALTER TABLE [dbo].[detalle_venta]  WITH CHECK ADD  CONSTRAINT [Relation_9] FOREIGN KEY([id_venta])
REFERENCES [dbo].[venta] ([id_venta])
GO
ALTER TABLE [dbo].[detalle_venta] CHECK CONSTRAINT [Relation_9]
GO
ALTER TABLE [dbo].[detalle_venta]  WITH CHECK ADD  CONSTRAINT [Relation_detalle_venta_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[detalle_venta] CHECK CONSTRAINT [Relation_detalle_venta_id_empresa]
GO
ALTER TABLE [dbo].[familia]  WITH CHECK ADD  CONSTRAINT [Relation_familia_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[familia] CHECK CONSTRAINT [Relation_familia_id_empresa]
GO
ALTER TABLE [dbo].[lista_precios]  WITH CHECK ADD  CONSTRAINT [Relation_lista_precios_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[lista_precios] CHECK CONSTRAINT [Relation_lista_precios_id_empresa]
GO
ALTER TABLE [dbo].[operacion]  WITH CHECK ADD  CONSTRAINT [Relation_39] FOREIGN KEY([id_almacen_origen])
REFERENCES [dbo].[almacen] ([id_almacen])
GO
ALTER TABLE [dbo].[operacion] CHECK CONSTRAINT [Relation_39]
GO
ALTER TABLE [dbo].[operacion]  WITH CHECK ADD  CONSTRAINT [Relation_52] FOREIGN KEY([id_almacen_destino])
REFERENCES [dbo].[almacen] ([id_almacen])
GO
ALTER TABLE [dbo].[operacion] CHECK CONSTRAINT [Relation_52]
GO
ALTER TABLE [dbo].[operacion]  WITH CHECK ADD  CONSTRAINT [Relation_67] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[operacion] CHECK CONSTRAINT [Relation_67]
GO
ALTER TABLE [dbo].[operacion]  WITH CHECK ADD  CONSTRAINT [Relation_69] FOREIGN KEY([id_tipo_operacion])
REFERENCES [dbo].[tipo_operacion] ([id_tipo_operacion])
GO
ALTER TABLE [dbo].[operacion] CHECK CONSTRAINT [Relation_69]
GO
ALTER TABLE [dbo].[operacion]  WITH CHECK ADD  CONSTRAINT [Relation_79] FOREIGN KEY([id_asociado])
REFERENCES [dbo].[asociado] ([id_asociado])
GO
ALTER TABLE [dbo].[operacion] CHECK CONSTRAINT [Relation_79]
GO
ALTER TABLE [dbo].[operacion]  WITH CHECK ADD  CONSTRAINT [Relation_operacion_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[operacion] CHECK CONSTRAINT [Relation_operacion_id_empresa]
GO
ALTER TABLE [dbo].[pago]  WITH CHECK ADD  CONSTRAINT [Relation_70] FOREIGN KEY([id_venta])
REFERENCES [dbo].[venta] ([id_venta])
GO
ALTER TABLE [dbo].[pago] CHECK CONSTRAINT [Relation_70]
GO
ALTER TABLE [dbo].[pago]  WITH CHECK ADD  CONSTRAINT [Relation_73] FOREIGN KEY([id_metodo_pago])
REFERENCES [dbo].[metodo_pago] ([id_metodo_pago])
GO
ALTER TABLE [dbo].[pago] CHECK CONSTRAINT [Relation_73]
GO
ALTER TABLE [dbo].[pago]  WITH CHECK ADD  CONSTRAINT [Relation_pago_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[pago] CHECK CONSTRAINT [Relation_pago_id_empresa]
GO
ALTER TABLE [dbo].[pago_tarifa]  WITH CHECK ADD  CONSTRAINT [Relation_71] FOREIGN KEY([id_tipo_tarifa])
REFERENCES [dbo].[tipo_tarifa] ([id_tipo_tarifa])
GO
ALTER TABLE [dbo].[pago_tarifa] CHECK CONSTRAINT [Relation_71]
GO
ALTER TABLE [dbo].[pago_tarifa]  WITH CHECK ADD  CONSTRAINT [Relation_72] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[pago_tarifa] CHECK CONSTRAINT [Relation_72]
GO
ALTER TABLE [dbo].[precios_sucursal]  WITH CHECK ADD  CONSTRAINT [Relation_123] FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[sucursal] ([id_sucursal])
GO
ALTER TABLE [dbo].[precios_sucursal] CHECK CONSTRAINT [Relation_123]
GO
ALTER TABLE [dbo].[precios_sucursal]  WITH CHECK ADD  CONSTRAINT [Relation_130] FOREIGN KEY([id_lista_precios])
REFERENCES [dbo].[lista_precios] ([id_lista_precios])
GO
ALTER TABLE [dbo].[precios_sucursal] CHECK CONSTRAINT [Relation_130]
GO
ALTER TABLE [dbo].[precios_sucursal]  WITH CHECK ADD  CONSTRAINT [Relation_precios_sucursal_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[precios_sucursal] CHECK CONSTRAINT [Relation_precios_sucursal_id_empresa]
GO
ALTER TABLE [dbo].[producto]  WITH CHECK ADD  CONSTRAINT [Relation_31] FOREIGN KEY([id_unidad_medida])
REFERENCES [dbo].[unidad_medida] ([id_unidad_medida])
GO
ALTER TABLE [dbo].[producto] CHECK CONSTRAINT [Relation_31]
GO
ALTER TABLE [dbo].[producto]  WITH CHECK ADD  CONSTRAINT [Relation_48] FOREIGN KEY([id_familia])
REFERENCES [dbo].[familia] ([id_familia])
GO
ALTER TABLE [dbo].[producto] CHECK CONSTRAINT [Relation_48]
GO
ALTER TABLE [dbo].[producto]  WITH CHECK ADD  CONSTRAINT [Relation_producto_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[producto] CHECK CONSTRAINT [Relation_producto_id_empresa]
GO
ALTER TABLE [dbo].[producto_almacen]  WITH CHECK ADD  CONSTRAINT [Relation_57] FOREIGN KEY([id_almacen])
REFERENCES [dbo].[almacen] ([id_almacen])
GO
ALTER TABLE [dbo].[producto_almacen] CHECK CONSTRAINT [Relation_57]
GO
ALTER TABLE [dbo].[producto_almacen]  WITH CHECK ADD  CONSTRAINT [Relation_89] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
GO
ALTER TABLE [dbo].[producto_almacen] CHECK CONSTRAINT [Relation_89]
GO
ALTER TABLE [dbo].[producto_almacen]  WITH CHECK ADD  CONSTRAINT [Relation_producto_almacen_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[producto_almacen] CHECK CONSTRAINT [Relation_producto_almacen_id_empresa]
GO
ALTER TABLE [dbo].[retiro_dinero]  WITH CHECK ADD  CONSTRAINT [Relation_74] FOREIGN KEY([id_turno_caja])
REFERENCES [dbo].[turno_caja] ([id_turno_caja])
GO
ALTER TABLE [dbo].[retiro_dinero] CHECK CONSTRAINT [Relation_74]
GO
ALTER TABLE [dbo].[retiro_dinero]  WITH CHECK ADD  CONSTRAINT [Relation_retiro_dinero_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[retiro_dinero] CHECK CONSTRAINT [Relation_retiro_dinero_id_empresa]
GO
ALTER TABLE [dbo].[rol]  WITH CHECK ADD  CONSTRAINT [Relation_rol_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[rol] CHECK CONSTRAINT [Relation_rol_id_empresa]
GO
ALTER TABLE [dbo].[sucursal]  WITH CHECK ADD  CONSTRAINT [FK_id_almacen_to_sucursal] FOREIGN KEY([id_almacen])
REFERENCES [dbo].[almacen] ([id_almacen])
GO
ALTER TABLE [dbo].[sucursal] CHECK CONSTRAINT [FK_id_almacen_to_sucursal]
GO
ALTER TABLE [dbo].[sucursal]  WITH CHECK ADD  CONSTRAINT [Relation_4] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[sucursal] CHECK CONSTRAINT [Relation_4]
GO
ALTER TABLE [dbo].[tipo_operacion]  WITH CHECK ADD  CONSTRAINT [Relation_tipo_operacion_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[tipo_operacion] CHECK CONSTRAINT [Relation_tipo_operacion_id_empresa]
GO
ALTER TABLE [dbo].[turno_caja]  WITH CHECK ADD  CONSTRAINT [Relation_60] FOREIGN KEY([id_caja])
REFERENCES [dbo].[caja] ([id_caja])
GO
ALTER TABLE [dbo].[turno_caja] CHECK CONSTRAINT [Relation_60]
GO
ALTER TABLE [dbo].[turno_caja]  WITH CHECK ADD  CONSTRAINT [Relation_66] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[turno_caja] CHECK CONSTRAINT [Relation_66]
GO
ALTER TABLE [dbo].[turno_caja]  WITH CHECK ADD  CONSTRAINT [Relation_turno_caja_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[turno_caja] CHECK CONSTRAINT [Relation_turno_caja_id_empresa]
GO
ALTER TABLE [dbo].[unidad_medida]  WITH CHECK ADD  CONSTRAINT [Relation_unidad_medida_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[unidad_medida] CHECK CONSTRAINT [Relation_unidad_medida_id_empresa]
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [Relation_75] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [Relation_75]
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [Relation_87] FOREIGN KEY([id_rol])
REFERENCES [dbo].[rol] ([id_rol])
GO
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [Relation_87]
GO
ALTER TABLE [dbo].[usuario_almacen]  WITH CHECK ADD  CONSTRAINT [FK_usuario_almacen_almacen] FOREIGN KEY([id_almacen])
REFERENCES [dbo].[almacen] ([id_almacen])
GO
ALTER TABLE [dbo].[usuario_almacen] CHECK CONSTRAINT [FK_usuario_almacen_almacen]
GO
ALTER TABLE [dbo].[usuario_almacen]  WITH CHECK ADD  CONSTRAINT [FK_usuario_almacen_usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[usuario_almacen] CHECK CONSTRAINT [FK_usuario_almacen_usuario]
GO
ALTER TABLE [dbo].[usuario_almacen]  WITH CHECK ADD  CONSTRAINT [Relation_usuario_almacen_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[usuario_almacen] CHECK CONSTRAINT [Relation_usuario_almacen_id_empresa]
GO
ALTER TABLE [dbo].[usuario_sucursal]  WITH CHECK ADD  CONSTRAINT [FK_usuario_sucursal_empresa] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[usuario_sucursal] CHECK CONSTRAINT [FK_usuario_sucursal_empresa]
GO
ALTER TABLE [dbo].[usuario_sucursal]  WITH CHECK ADD  CONSTRAINT [FK_usuario_sucursal_sucursal] FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[sucursal] ([id_sucursal])
GO
ALTER TABLE [dbo].[usuario_sucursal] CHECK CONSTRAINT [FK_usuario_sucursal_sucursal]
GO
ALTER TABLE [dbo].[usuario_sucursal]  WITH CHECK ADD  CONSTRAINT [Relation_usuario_sucursal_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[usuario_sucursal] CHECK CONSTRAINT [Relation_usuario_sucursal_id_empresa]
GO
ALTER TABLE [dbo].[variante]  WITH CHECK ADD  CONSTRAINT [Relation_41] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
GO
ALTER TABLE [dbo].[variante] CHECK CONSTRAINT [Relation_41]
GO
ALTER TABLE [dbo].[variante]  WITH CHECK ADD  CONSTRAINT [Relation_variante_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[variante] CHECK CONSTRAINT [Relation_variante_id_empresa]
GO
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [Relation_51] FOREIGN KEY([id_turno_caja])
REFERENCES [dbo].[turno_caja] ([id_turno_caja])
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [Relation_51]
GO
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [Relation_78] FOREIGN KEY([id_asociado])
REFERENCES [dbo].[asociado] ([id_asociado])
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [Relation_78]
GO
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [Relation_venta_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [Relation_venta_id_empresa]
GO
/****** Object:  StoredProcedure [dbo].[sp_actualizar_estado_empresa_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   PROCEDURE [dbo].[sp_actualizar_estado_empresa_by_id]
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    -- Tabla variable para capturar el estado anterior y el nuevo de la empresa.
    DECLARE @Changes TABLE (
         OldEstado CHAR(1),
         NewEstado CHAR(1)
    );

    -- Actualizamos el estado de la empresa de acuerdo a la prioridad:
    -- 1. Activo (1): Tiene al menos un pago en estado 1.
    -- 2. Pendiente de pago (2): No tiene pagos activos pero s� uno en periodo de gracia (estado 2).
    -- 3. Modo prueba (3): No tiene pagos en estado 1 ni 2, pero s� tiene uno en estado 3.
    -- 4. Inhabilitado (0): No cumple ninguna de las condiciones anteriores.
    UPDATE e
    SET estado = CASE
        WHEN EXISTS (
            SELECT 1 
            FROM pago_tarifa p 
            WHERE p.id_empresa = e.id_empresa 
              AND p.estado = '1'
        ) THEN '1'

        WHEN EXISTS (
            SELECT 1 
            FROM pago_tarifa p 
            WHERE p.id_empresa = e.id_empresa 
              AND p.estado = '2'
        ) THEN '2'

        WHEN EXISTS (
            SELECT 1 
            FROM pago_tarifa p 
            WHERE p.id_empresa = e.id_empresa 
              AND p.estado = '3'
			  AND e.estado = '3' -- La empresa debe estar ya en modo prueba para porque quedarse en este estado
        ) THEN '3'

        ELSE '0'
    END
    OUTPUT deleted.estado, inserted.estado 
           INTO @Changes(OldEstado, NewEstado)
    FROM empresa e
    WHERE e.id_empresa = @id_empresa;

    -- Obtenemos el estado anterior y el nuevo de la empresa.
    DECLARE @OldEstado CHAR(1), @NewEstado CHAR(1);
    SELECT TOP 1 @OldEstado = OldEstado, @NewEstado = NewEstado
    FROM @Changes;

    -- Si la empresa pasa de modo prueba (3) a otro estado, se elimina la data asociada.
    IF @OldEstado = '3' AND @NewEstado <> '3'
    BEGIN
         EXEC sp_eliminar_datos_empresa_modo_prueba @id_empresa = @id_empresa;
    END;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_actualizar_estado_pago_tarifa_empresa_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_actualizar_estado_pago_tarifa_empresa_by_id]
     @id_pago_tarifa BIGINT
AS
BEGIN
     SET NOCOUNT ON;
     DECLARE @id_empresa BIGINT;
     --
     DECLARE @fecha_actual DATE = CAST(GETDATE() AS DATE);
     DECLARE @fecha_inicio DATE,
            @fecha_renovacion DATE,
            @dias_plazo INT,
            @nuevo_estado CHAR(1);

     -- Obtenemos los valores necesarios de pago_tarifa y los días de plazo de la empresa.
     SELECT @id_empresa = pt.id_empresa
     FROM pago_tarifa pt;

     SELECT
          @fecha_inicio = pt.fecha_inicio,
          @fecha_renovacion = pt.fecha_renovacion,
          @dias_plazo = e.dias_plazo
     FROM pago_tarifa pt
          INNER JOIN empresa e ON e.id_empresa = pt.id_empresa
     WHERE pt.id_pago_tarifa = @id_pago_tarifa
          AND e.id_empresa = @id_empresa;

     -- Determinar el estado a asignar según las fechas:
     -- 3: Pendiente de activación (si la fecha actual es menor que fecha_inicio).
     -- 1: Activo (si la fecha actual está entre fecha_inicio y fecha_renovacion).
     -- 2: Periodo de gracia (si la fecha actual es mayor que fecha_renovacion pero menor o igual que (fecha_renovacion + días_plazo)).
     -- 4: Expirado (si la fecha actual es mayor que (fecha_renovacion + días_plazo)).
     IF (@fecha_actual < @fecha_inicio)
     BEGIN
          SET @nuevo_estado = '3';
     -- Pendiente de activación
     END
     ELSE IF (@fecha_actual >= @fecha_inicio AND @fecha_actual <= @fecha_renovacion)
     BEGIN
          SET @nuevo_estado = '1';
     -- Activo
     END
     ELSE IF (@fecha_actual > @fecha_renovacion AND @fecha_actual <= DATEADD(DAY, @dias_plazo, @fecha_renovacion))
     BEGIN
          SET @nuevo_estado = '2';
     -- Periodo de gracia
     END
     ELSE IF (@fecha_actual > DATEADD(DAY, @dias_plazo, @fecha_renovacion))
     BEGIN
          SET @nuevo_estado = '4';
     -- Expirado
     END

     -- Actualizamos el estado del pago_tarifa para el registro específico.
     UPDATE pago_tarifa
     SET estado = @nuevo_estado
     WHERE id_pago_tarifa = @id_pago_tarifa;

     -- Finalmente, se actualiza el estado de la empresa en función de sus suscripciones.
     EXEC sp_actualizar_estado_empresa_by_id @id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_actualizar_estados_empresas]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_actualizar_estados_empresas]
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Tabla temporal para almacenar los cambios en el estado de cada empresa.
    DECLARE @Changes TABLE (
         id_empresa BIGINT,
         OldEstado CHAR(1),
         NewEstado CHAR(1)
    );

    -- Se actualiza el estado de cada empresa según los registros asociados en pago_tarifa.
    UPDATE e
    SET estado = CASE
        -- 1. Activo: Tiene al menos un pago en estado 1.
        WHEN EXISTS (
            SELECT 1 
            FROM pago_tarifa p 
            WHERE p.id_empresa = e.id_empresa 
              AND p.estado = '1'
        ) THEN '1'

        -- 2. Pendiente de pago: No tiene pagos activos, pero tiene al menos uno en periodo de gracia (estado 2).
        WHEN EXISTS (
            SELECT 1 
            FROM pago_tarifa p 
            WHERE p.id_empresa = e.id_empresa 
              AND p.estado = '2'
        ) THEN '2'

        -- 3. Modo prueba: No tiene pagos activos ni en periodo de gracia, pero tiene al menos uno pendiente de activación (estado 3).
        WHEN EXISTS (
            SELECT 1 
            FROM pago_tarifa p 
            WHERE p.id_empresa = e.id_empresa 
              AND p.estado = '3'
			  AND e.estado = '3' -- La empresa debe estar en modo prueba para poder mantenerse en este estado
        ) THEN '3'

        -- 4. Inhabilitado: No se encontró ningún registro válido (estados 1, 2 o 3).
        ELSE '0'
	END
    OUTPUT deleted.id_empresa, deleted.estado, inserted.estado 
           INTO @Changes (id_empresa, OldEstado, NewEstado)
    FROM empresa e;

    -- Se recorre la tabla de cambios para identificar empresas que pasan de estado 3 a otro.
    DECLARE @id_empresa BIGINT;

    DECLARE change_cursor CURSOR LOCAL FAST_FORWARD FOR
        SELECT id_empresa 
        FROM @Changes
        WHERE OldEstado = '3' AND NewEstado <> '3';

    OPEN change_cursor;
    FETCH NEXT FROM change_cursor INTO @id_empresa;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Ejecuta el procedimiento para eliminar datos asociados a modo prueba.
        EXEC sp_eliminar_datos_empresa_modo_prueba @id_empresa = @id_empresa;
        
        FETCH NEXT FROM change_cursor INTO @id_empresa;
    END;

    CLOSE change_cursor;
    DEALLOCATE change_cursor;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_actualizar_estados_pagos_tarifa]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[sp_actualizar_estados_pagos_tarifa]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @fecha_actual DATE = CAST(GETDATE() AS DATE);

    UPDATE p
    SET estado = CASE 
         WHEN @fecha_actual < p.fecha_inicio THEN '3'
         WHEN @fecha_actual >= p.fecha_inicio 
              AND @fecha_actual <= p.fecha_renovacion THEN '1'
         WHEN @fecha_actual > p.fecha_renovacion 
              AND @fecha_actual <= DATEADD(DAY, e.dias_plazo, p.fecha_renovacion) THEN '2'
         WHEN @fecha_actual > DATEADD(DAY, e.dias_plazo, p.fecha_renovacion) THEN '4'
         ELSE p.estado  -- En caso de que no se cumpla alguna condición, se mantiene el estado actual.
    END
    FROM pago_tarifa p
    INNER JOIN empresa e ON e.id_empresa = p.id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_almacen_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_eliminar_almacen_by_codigo]
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM almacen WHERE codigo = @codigo AND id_empresa = @id_empresa;

        IF @@ROWCOUNT > 0
        BEGIN
        COMMIT TRANSACTION;
        SELECT 'true' AS verificar;
    END
        ELSE
        BEGIN
        ROLLBACK TRANSACTION;
        SELECT 'false' AS verificar;
    END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 'false' AS verificar;
        THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_almacen_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_eliminar_almacen_by_id]
    @id_almacen BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM almacen WHERE id_almacen = @id_almacen;

        IF @@ROWCOUNT > 0
        BEGIN
        COMMIT TRANSACTION;
        SELECT 'true' AS verificar;
    END
        ELSE
        BEGIN
        ROLLBACK TRANSACTION;
        SELECT 'false' AS verificar;
    END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 'false' AS verificar;
        THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_caja_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_eliminar_caja_by_codigo]
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM caja WHERE codigo = @codigo AND id_empresa = @id_empresa;

        IF @@ROWCOUNT > 0
        BEGIN
        COMMIT TRANSACTION;
        SELECT 'true' AS verificar;
    END
        ELSE
        BEGIN
        ROLLBACK TRANSACTION;
        SELECT 'false' AS verificar;
    END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 'false' AS verificar;
        THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_caja_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_eliminar_caja_by_id]
    @id_caja BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM caja WHERE id_caja = @id_caja;

        IF @@ROWCOUNT > 0
        BEGIN
        COMMIT TRANSACTION;
        SELECT 'true' AS verificar;
    END
        ELSE
        BEGIN
        ROLLBACK TRANSACTION;
        SELECT 'false' AS verificar;
    END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 'false' AS verificar;
        THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_datos_empresa_modo_prueba]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[sp_eliminar_datos_empresa_modo_prueba]
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM comprobante_pago  WHERE id_empresa = @id_empresa;
    DELETE FROM pago              WHERE id_empresa = @id_empresa;
    DELETE FROM detalle_venta     WHERE id_empresa = @id_empresa;
    DELETE FROM venta             WHERE id_empresa = @id_empresa;
    DELETE FROM retiro_dinero     WHERE id_empresa = @id_empresa;
    DELETE FROM turno_caja        WHERE id_empresa = @id_empresa;
    DELETE FROM producto_almacen  WHERE id_empresa = @id_empresa;
    DELETE FROM detalle_operacion WHERE id_empresa = @id_empresa;
    DELETE FROM operacion         WHERE id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_acceso_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_acceso_by_id]
    @id_acceso BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM acceso WHERE id_acceso = @id_acceso)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_almacen_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_almacen_by_codigo]
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM almacen WHERE codigo = @codigo AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_almacen_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_almacen_by_id]
    @id_almacen BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM almacen WHERE id_almacen = @id_almacen and id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_caja_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_caja_by_codigo]
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM caja WHERE codigo = @codigo AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_empresa_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_empresa_by_id]
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM empresa WHERE id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;

EXEC sp_existencia_empresa_by_id @id_empresa = 1;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_exclusive_almacen_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_exclusive_almacen_by_id]
    @id_almacen BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(
        SELECT 1
        FROM almacen
        WHERE id_almacen = @id_almacen
            AND id_empresa = @id_empresa
       )
        AND NOT EXISTS(
         SELECT 1
        FROM sucursal
        WHERE id_almacen = @id_almacen
       )
    BEGIN
        SELECT 'true' AS verificar;
    END
    ELSE
    BEGIN
        SELECT 'false' AS verificar;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_familia_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_familia_by_codigo]
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM familia WHERE codigo = @codigo AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_familia_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_familia_by_id]
    @id_familia BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM familia WHERE id_familia = @id_familia AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_producto_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_producto_by_codigo]
    @codigo NVARCHAR(128),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM producto WHERE codigo = @codigo AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_rol_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_rol_by_codigo]
    @codigo NVARCHAR(64),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM rol WHERE codigo = @codigo AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_rol_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_rol_by_id]
    @id_rol BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM rol WHERE id_rol = @id_rol AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_sucursal_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_sucursal_by_codigo]
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM sucursal WHERE codigo = @codigo AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_sucursal_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_sucursal_by_id]
    @id_sucursal BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM sucursal WHERE id_sucursal = @id_sucursal and id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_tipo_producto_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_existencia_tipo_producto_by_id]
    @id_tipo_producto BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM tipo_producto WHERE id_tipo_producto = @id_tipo_producto)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_unidad_medida_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_unidad_medida_by_codigo]
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM unidad_medida WHERE codigo = @codigo AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_unidad_medida_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_unidad_medida_by_id]
    @id_unidad_medida BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM unidad_medida WHERE id_unidad_medida = @id_unidad_medida AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_usuario_by_dni]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_usuario_by_dni]
    @dni CHAR(8),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM usuario WHERE dni = @dni AND id_empresa = @id_empresa)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_existencia_usuario_by_email]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_existencia_usuario_by_email]
    @email NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM usuario WHERE email = @email)
    BEGIN
        SELECT 'true' AS 'verificar'
    END
    ELSE
    BEGIN
        SELECT 'false' AS 'verificar'
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_accesos]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_accesos]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.id_acceso, a.nombre, a.ruta, a.estado
    FROM acceso a;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_accesos_by_id_rol]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_get_accesos_by_id_rol]
    @id_rol BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT a.id_acceso, a.nombre, a.ruta, a.estado
    FROM acceso a
    INNER JOIN acceso_rol ar ON a.id_acceso = ar.id_acceso
    WHERE ar.id_rol = @id_rol and id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_almacen_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_almacen_by_codigo]
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_almacen,
        codigo,
        nombre,
        departamento,
        ciudad,
        direccion,
        estado,
        id_empresa
    FROM almacen
    WHERE codigo = @codigo AND id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_almacen_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_almacen_by_id]
    @id_almacen BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_almacen,
        codigo,
        nombre,
        departamento,
        ciudad,
        direccion,
        estado,
        id_empresa
    FROM almacen
    WHERE id_almacen = @id_almacen and id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_almacenes_by_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_almacenes_by_id_empresa]
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_almacen,
        codigo,
        nombre,
        departamento,
        ciudad,
        direccion,
        estado,
        id_empresa
    FROM almacen
    WHERE id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_almacenes_by_id_usuario]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_almacenes_by_id_usuario]
    @id_usuario BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.id_almacen, a.codigo, a.nombre, a.estado
    FROM almacen a
    INNER JOIN usuario_almacen ua ON a.id_almacen = ua.id_almacen
    WHERE ua.id_usuario = @id_usuario AND ua.id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_caja_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_caja_by_codigo]
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_caja,
        codigo,
        nombre,
        estado,
        id_sucursal,
        id_empresa
    FROM caja
    WHERE codigo = @codigo AND id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_caja_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_get_caja_by_id]
    @id_caja BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_caja,
        codigo,
        nombre,
        estado,
        id_sucursal,
        id_empresa
    FROM caja
    WHERE id_caja = @id_caja and id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_empresa_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[sp_get_empresa_by_id]
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        id_empresa,
        ruc, 
        razon_social,
        nombre_comercial,
        email,
        telefono,
        departamento,
        ciudad,
        direccion,
        igv,
        monto_maximo_boleta,
        cantidad_sucursales, 
        cantidad_usuarios,
        sucursales_registradas,
        usuarios_registrados,
        logo,
        estado
    FROM empresa
    WHERE id_empresa = @id_empresa;
END;


EXEC sp_get_empresa_by_id @id_empresa = 1;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_empresa_by_ruc]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_get_empresa_by_ruc]
    @ruc CHAR(11)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        id_empresa,
        ruc, 
        razon_social,
        nombre_comercial,
        email,
        telefono,
        departamento,
        ciudad,
        direccion,
        igv,
        monto_maximo_boleta,
        cantidad_sucursales, 
        cantidad_usuarios,
        sucursales_registradas,
        usuarios_registrados,
        logo,
        estado
    FROM empresa
    WHERE ruc = @ruc;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_exclusive_almacenes_by_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_get_exclusive_almacenes_by_id_empresa]
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        a.id_almacen,
        a.codigo,
        a.nombre,
        a.departamento,
        a.ciudad,
        a.direccion,
        a.estado,
        a.id_empresa
    FROM almacen a
        LEFT JOIN sucursal s ON a.id_almacen = s.id_almacen
    WHERE a.id_empresa = @id_empresa
    AND s.id_almacen IS NULL;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_familia_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_familia_by_codigo]
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_familia,
        codigo,
        nombre,
        color,
        estado,
        id_empresa
    FROM familia
    WHERE codigo = @codigo AND id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_familia_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_familia_by_id]
    @id_familia BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_familia,
        codigo,
        nombre,
        color,
        estado,
        id_empresa
    FROM familia
    WHERE id_familia = @id_familia and id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_familias_by_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_familias_by_id_empresa]
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_familia,
        codigo,
        nombre,
        descripcion,
        color,
        estado,
        id_tipo_producto,
        id_empresa
    FROM familia
    WHERE id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_rol_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_rol_by_id]
    @id_rol BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        id_rol,
        nombre,
        estado,
        id_empresa
    FROM rol
    WHERE id_rol = @id_rol AND id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_roles_by_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_roles_by_id_empresa]
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_rol,
        nombre,
        estado,
        id_empresa
    FROM rol
    WHERE id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_sucursal_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_sucursal_by_codigo]
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_sucursal,
        codigo,
        nombre,
        departamento,
        ciudad,
        direccion,
        telefono,
        estado,
        id_almacen,
        id_empresa
    FROM sucursal
    WHERE codigo = @codigo AND id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_sucursal_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_sucursal_by_id]
    @id_sucursal BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_sucursal,
        codigo,
        nombre,
        departamento,
        ciudad,
        direccion,
        telefono,
        estado,
        id_almacen,
        id_empresa
    FROM sucursal
    WHERE id_sucursal = @id_sucursal and id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_sucursales_by_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_sucursales_by_id_empresa]
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_sucursal,
        codigo,
        nombre,
        departamento,
        ciudad,
        direccion,
        telefono,
        estado,
        id_almacen,
        id_empresa
    FROM sucursal
    WHERE id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_sucursales_by_id_usuario]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_sucursales_by_id_usuario]
    @id_usuario BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.id_sucursal, s.codigo, s.nombre, s.estado
    FROM sucursal s
    INNER JOIN usuario_sucursal us ON s.id_sucursal = us.id_sucursal
    WHERE us.id_usuario = @id_usuario AND us.id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_tipo_producto_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_tipo_producto_by_id]
@id_tipo_producto BIGINT
AS
BEGIN
    SELECT 
        id_tipo_producto,
        nombre,
        estado
    FROM tipo_producto
    WHERE id_tipo_producto = @id_tipo_producto;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_tipos_productos]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_tipos_productos]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT t.id_tipo_producto, t.nombre, t.estado
    FROM tipo_producto t;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_unidad_medida_by_codigo]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_unidad_medida_by_codigo]
    @codigo NVARCHAR(24),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_unidad_medida,
        codigo,
        nombre,
        descripcion,
        estado,
        id_empresa
    FROM unidad_medida
    WHERE codigo = @codigo AND id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_unidad_medida_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_get_unidad_medida_by_id]
    @id_unidad_medida BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        id_unidad_medida,
        codigo,
        nombre,
        descripcion,
        estado,
        id_empresa
    FROM unidad_medida
    WHERE id_unidad_medida = @id_unidad_medida AND id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_unidades_medida_by_id_empresa]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_get_unidades_medida_by_id_empresa]
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_unidad_medida,
        codigo,
        nombre,
        descripcion,
        estado,
        id_empresa
    FROM unidad_medida
    WHERE id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_usuario_by_dni]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_get_usuario_by_dni]
    @dni CHAR(8),
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        id_usuario,
        dni,
        email,
        created_at,
        nombre,
        estado,
        id_rol,
        id_empresa
    FROM usuario
    WHERE dni = @dni and id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_usuario_by_id]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_get_usuario_by_id]
    @id_usuario BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        id_usuario,
        dni,
        email,
        created_at,
        nombre,
        foto,
        estado,
        id_rol,
        id_empresa
    FROM usuario
    WHERE id_usuario = @id_usuario and id_empresa = @id_empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_accesos_rol]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_registrar_accesos_rol]
    @id_rol BIGINT,
    @id_empresa BIGINT,
    @accesos ud_accesos_rol READONLY
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Insertar los accesos recibidos en la tabla acceso_rol en base al rol
        INSERT INTO acceso_rol
        (id_acceso, id_rol, id_empresa)
        SELECT id_acceso, @id_rol, @id_empresa
        FROM @accesos a
        WHERE NOT EXISTS (
            SELECT 1
            FROM acceso_rol ar
            WHERE ar.id_acceso = a.id_acceso
                AND ar.id_rol = @id_rol
                AND ar.id_empresa = @id_empresa
        );
        -- No hacer COMMIT o ROLLBACK aquí
    END TRY
    BEGIN CATCH
        -- No hacer ROLLBACK aquí, pero asegurarse de que la excepción se propague
        ;THROW; -- Punto y coma añadido antes de THROW
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_almacen]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_registrar_almacen]
    @codigo NVARCHAR(24),
    @nombre NVARCHAR(128),
    @departamento NVARCHAR(64) = NULL,
    @ciudad NVARCHAR(64) = NULL,
    @direccion NVARCHAR(255) = NULL,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @nuevo_id INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validar si el codigo ya existe
        IF EXISTS (SELECT 1
        FROM almacen
        WHERE codigo = @codigo and id_empresa = @id_empresa)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;

        INSERT INTO almacen (codigo, nombre, departamento, ciudad, direccion, estado, id_empresa)
        VALUES (@codigo, @nombre, @departamento, @ciudad, @direccion, 1, @id_empresa);
        
        SET @nuevo_id = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_caja]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_registrar_caja]
    @codigo NVARCHAR(24),
    @nombre NVARCHAR(128) = NULL,
    @id_sucursal BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @nuevo_id INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validar si el codigo de la caja ya existe
        IF EXISTS (SELECT 1
        FROM caja
        WHERE codigo = @codigo and id_empresa = @id_empresa)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;

        INSERT INTO caja (codigo, nombre, estado, id_sucursal, id_empresa)
        VALUES (@codigo, @nombre, 1, @id_sucursal, @id_empresa);
        
        SET @nuevo_id = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_familia]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_registrar_familia]
    @codigo NVARCHAR(24),
    @nombre NVARCHAR(128),
    @descripcion NVARCHAR(255) = NULL,
    @color CHAR(7) = NULL,
    @id_tipo_producto BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @nuevo_id INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validar si el codigo de la familia ya existe
        IF EXISTS (SELECT 1
        FROM familia
        WHERE codigo = @codigo and id_empresa = @id_empresa)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;

        INSERT INTO familia (codigo, nombre, descripcion, color, estado, id_tipo_producto, id_empresa)
        VALUES (@codigo, @nombre, @descripcion, @color, 1, @id_tipo_producto, @id_empresa);
        
        SET @nuevo_id = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_producto]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_registrar_producto]
    @codigo NVARCHAR(128),
    @nombre NVARCHAR(128),
    @imagen NVARCHAR(MAX) = NULL,
    @stock_minimo INTEGER = NULL,
    @stock_maximo INTEGER = NULL,
    @fecha_vencimiento DATE = NULL,
    @alerta_stock CHAR(1) = NULL,
    @alerta_vencimiento CHAR(1) = NULL,
    @tiene_igv CHAR(1),
    @isc FLOAT,
    @id_familia BIGINT,
    @id_unidad_medida BIGINT,
    @id_empresa BIGINT,
    @variantes NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id INT;

    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validar si el código del producto ya existe
        IF EXISTS (SELECT 1
    FROM producto
    WHERE codigo = @codigo AND id_empresa = @id_empresa)
        BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END;

        INSERT INTO producto
        (codigo, nombre, imagen,
        stock_minimo, stock_maximo,
        fecha_vencimiento,
        alerta_stock, alerta_vencimiento,
        tiene_igv, isc,
        estado, id_familia,
        id_unidad_medida, id_empresa)
    VALUES
        (
            @codigo, @nombre, @imagen,
            @stock_minimo, @stock_maximo,
            @fecha_vencimiento,
            @alerta_stock, @alerta_vencimiento,
            @tiene_igv, @isc,
            1, @id_familia,
            @id_unidad_medida, @id_empresa
        );
        
        SET @nuevo_id = SCOPE_IDENTITY();
        
        -- Insertar variantes y detalles
        IF @variantes IS NOT NULL
        BEGIN
        EXEC sp_registrar_variantes @variantes = @variantes, @id_producto = @nuevo_id, @id_empresa = @id_empresa;
    END
        
        COMMIT TRANSACTION;
        
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_rol]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_registrar_rol]
    @codigo NVARCHAR(24),
    @nombre NVARCHAR(64),
    @descripcion NVARCHAR(255),
    @accesos NVARCHAR(MAX),
    -- Se espera un JSON con un arreglo de objetos que contengan "id_acceso"
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @nuevo_id INT;
    DECLARE @accesosTable ud_accesos_rol;
    -- Tabla temporal
    DECLARE @transactionCount INT = @@TRANCOUNT;
    -- Guarda el conteo actual de transacciones

    BEGIN TRY
        IF @transactionCount = 0
        BEGIN
            BEGIN TRANSACTION;
        END
        
        -- Validar si el rol ya existe
        IF EXISTS (SELECT 1
        FROM rol
        WHERE codigo = @codigo and id_empresa = @id_empresa)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;

        -- Convertir el JSON a una tabla
        INSERT INTO @accesosTable
        (id_acceso)
        SELECT id_acceso
        FROM OPENJSON(@accesos)
        WITH (id_acceso BIGINT '$.id_acceso');
        
        -- Insertar el nuevo rol
        INSERT INTO rol
        (codigo, nombre, descripcion, estado, id_empresa)
        VALUES (@codigo, @nombre, @descripcion, 1, @id_empresa);
        
        SET @nuevo_id = SCOPE_IDENTITY();  -- Obtener el ID generado para el rol
        
        -- Registrar los accesos asociados al rol
        EXEC sp_registrar_accesos_rol @id_rol = @nuevo_id, @id_empresa = @id_empresa, @accesos = @accesosTable;
        
        -- Verificar que se hayan registrado los accesos
        IF NOT EXISTS (
            SELECT 1
            FROM acceso_rol
            WHERE id_rol = @nuevo_id
                AND id_empresa = @id_empresa
        )
        BEGIN
            ;THROW 51000, 'Los accesos no se registraron correctamente.', 1;
        END
        
        IF @transactionCount = 0
        BEGIN
            COMMIT TRANSACTION;
        END
        
        -- Devuelve el ID del nuevo rol
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        IF @transactionCount = 0 AND XACT_STATE() <> 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        
        -- Re-lanzar la excepción capturada
        ;THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_sucursal]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_registrar_sucursal]
    @codigo NVARCHAR(24),
    @nombre NVARCHAR(64),
    @departamento NVARCHAR(64) = NULL,
    @ciudad NVARCHAR(64) = NULL,
    @direccion NVARCHAR(255) = NULL,
    @telefono NVARCHAR(32) = NULL,
    @id_almacen BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id INT;
    DECLARE @sucursales_registradas INT, @cantidad_sucursales INT;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar si el codigo ya existe
        IF EXISTS (SELECT 1
        FROM sucursal
        WHERE codigo = @codigo and id_empresa = @id_empresa)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;

        -- Obtener la cantidad de sucursales registradas y el límite
        SELECT
            @sucursales_registradas = ISNULL(sucursales_registradas, 0),
            @cantidad_sucursales = ISNULL(cantidad_sucursales, 0)
        FROM empresa
        WHERE id_empresa = @id_empresa;

        -- Si la empresa no puede registrar más sucursales, detener el proceso
        IF @sucursales_registradas >= @cantidad_sucursales
        BEGIN
            ROLLBACK TRANSACTION;
            -- Detener la ejecución
            RETURN;
        END;


        INSERT INTO sucursal (codigo, nombre, departamento, ciudad, direccion, telefono, estado, id_almacen, id_empresa)
        VALUES (@codigo, @nombre, @departamento, @ciudad, @direccion, @telefono, 1, @id_almacen, @id_empresa);

        SET @nuevo_id = SCOPE_IDENTITY();  -- Obtener el ID generado

        UPDATE empresa
        SET sucursales_registradas = sucursales_registradas + 1
        WHERE id_empresa = @id_empresa;

        COMMIT TRANSACTION;

        -- Devuelve el ID con SELECT
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        EXEC sp_eliminar_almacen_by_id @id_almacen = @id_almacen;
        THROW;
    END CATCH;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_unidad_medida]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_registrar_unidad_medida]
    @nombre NVARCHAR(255),
    @codigo NVARCHAR(24),
    @descripcion NVARCHAR(255) = NULL,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar si la unidad de medidad ya existe por codigo
        IF EXISTS (SELECT 1
        FROM unidad_medida
        WHERE codigo = @codigo)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;


        -- Insertar 
        INSERT INTO unidad_medida
        (codigo, nombre, descripcion, estado, id_empresa)
        VALUES
        (@codigo, @nombre, @descripcion, '1', @id_empresa);
        
        SET @nuevo_id = SCOPE_IDENTITY();

        COMMIT TRANSACTION;

        -- Retornar el ID del nuevo usuario
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_usuario]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_registrar_usuario]
    @dni CHAR(8),
    @nombre NVARCHAR(255),
    @email NVARCHAR(255),
    @password NVARCHAR(255),
    @sucursales NVARCHAR(MAX),
    @almacenes NVARCHAR(MAX),
    @id_rol BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id INT;
    DECLARE @usuarios_registrados INT, @cantidad_usuarios INT;
    -- Tablas temporales
    DECLARE @almacenesTable ud_usuarios_almacen;
    DECLARE @sucursalesTable ud_usuarios_sucursal;
    -- Guarda el conteo actual de transacciones
    DECLARE @transactionCount INT = @@TRANCOUNT;

    BEGIN TRY
        IF @transactionCount = 0
        BEGIN
            BEGIN TRANSACTION;
        END

        -- Obtener la cantidad de usuarios registrados y el límite
        SELECT
            @usuarios_registrados = ISNULL(usuarios_registrados, 0),
            @cantidad_usuarios = ISNULL(cantidad_usuarios, 0)
        FROM empresa
        WHERE id_empresa = @id_empresa;

        -- Si la empresa no puede registrar más usuarios, detener el proceso
        IF @usuarios_registrados >= @cantidad_usuarios
        BEGIN
            ROLLBACK TRANSACTION;
            -- Detener la ejecución
            RETURN;
        END;
        
        -- Validar si el usuario ya existe por dni y empresa
        IF EXISTS (SELECT 1
        FROM usuario
        WHERE dni = @dni and id_empresa = @id_empresa)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;

        -- Validar si el usuario en la bd ya existe por Email
        IF EXISTS (SELECT 1
        FROM usuario
        WHERE email = @email)
        BEGIN
            ROLLBACK TRANSACTION;
            -- Evitar duplicados
            RETURN;
        END;

        -- Validar el estado del rol
        IF NOT EXISTS (
            SELECT 1
            FROM rol
            WHERE id_rol = @id_rol AND id_empresa = @id_empresa AND estado = '1'
        )
        BEGIN
            ROLLBACK TRANSACTION;
            RETURN;
        END;

  
        -- Convertir el JSON a una tabla
        INSERT INTO @almacenesTable
        (id_almacen)
        SELECT id_almacen
        FROM OPENJSON(@almacenes)
        WITH (id_almacen BIGINT '$.id_almacen');
    
        INSERT INTO @sucursalesTable
        (id_sucursal)
        SELECT id_sucursal
        FROM OPENJSON(@sucursales)
        WITH (id_sucursal BIGINT '$.id_sucursal');


        -- Insertar el nuevo usuario
        INSERT INTO usuario 
        (dni, nombre, email, password, created_at, updated_at, estado, id_rol, id_empresa)
        VALUES
        (@dni, @nombre, @email, @password, GETDATE(), GETDATE(), 1, @id_rol, @id_empresa);
        
        SET @nuevo_id = SCOPE_IDENTITY();
        
        -- Registrar los almacenes y sucursales
        EXEC sp_registrar_usuarios_sucursal @id_usuario = @nuevo_id, @id_empresa = @id_empresa, @sucursales = @sucursalesTable;
        EXEC sp_registrar_usuarios_almacen @id_usuario = @nuevo_id, @id_empresa = @id_empresa, @almacenes = @almacenesTable;
        
        -- Verificar que se hayan registrado los accesos
        IF NOT EXISTS (
            SELECT 1
            FROM usuario_sucursal
            WHERE id_usuario = @nuevo_id
            AND id_empresa = @id_empresa
        )
        BEGIN
            ;THROW 51000, 'Los accesos no se registraron correctamente.', 1;
        END

        IF NOT EXISTS (
            SELECT 1
            FROM usuario_almacen
            WHERE id_usuario = @nuevo_id
            AND id_empresa = @id_empresa
        )
        BEGIN
            ;THROW 51000, 'Los accesos no se registraron correctamente.', 1;
        END

        UPDATE empresa
        SET usuarios_registrados = usuarios_registrados + 1
        WHERE id_empresa = @id_empresa;

        
        IF @transactionCount = 0
                BEGIN
            COMMIT TRANSACTION;
        END

        -- Retornar el ID del nuevo usuario
        SELECT @nuevo_id AS nuevo_id;
    END TRY
    BEGIN CATCH
        IF @transactionCount = 0 AND XACT_STATE() <> 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        ;THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_usuarios_almacen]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_registrar_usuarios_almacen]
    @id_usuario BIGINT,
    @id_empresa BIGINT,
    @almacenes ud_usuarios_almacen READONLY
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Insertar los almacenes recibidos en la tabla usuario_almacen en base al usuario
        INSERT INTO usuario_almacen
        (id_almacen, id_usuario, id_empresa)
        SELECT id_almacen, @id_usuario, @id_empresa
        FROM @almacenes a
        WHERE NOT EXISTS (
            SELECT 1
            FROM usuario_almacen ua
            WHERE ua.id_almacen = a.id_almacen
                AND ua.id_usuario = @id_usuario
                AND ua.id_empresa = @id_empresa
        );
        -- No hacer COMMIT o ROLLBACK aquí
    END TRY
    BEGIN CATCH
        -- No hacer ROLLBACK aquí, pero asegurarse de que la excepción se propague
        ;THROW; -- Punto y coma añadido antes de THROW
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_usuarios_sucursal]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_registrar_usuarios_sucursal]
    @id_usuario BIGINT,
    @id_empresa BIGINT,
    @sucursales ud_usuarios_sucursal READONLY
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Insertar los sucursales recibidos en la tabla usuario_sucursal en base al usuario
        INSERT INTO usuario_sucursal
        (id_sucursal, id_usuario, id_empresa)
        SELECT id_sucursal, @id_usuario, @id_empresa
        FROM @sucursales s
        WHERE NOT EXISTS (
        SELECT 1
        FROM usuario_sucursal us
        WHERE us.id_sucursal = s.id_sucursal
        AND us.id_usuario = @id_usuario
        AND us.id_empresa = @id_empresa
        );
        -- No hacer COMMIT o ROLLBACK aquí
    END TRY
    BEGIN CATCH
        -- No hacer ROLLBACK aquí, pero asegurarse de que la excepción se propague
        ;THROW; -- Punto y coma añadido antes de THROW
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_variantes]    Script Date: 24/3/2025 8:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_registrar_variantes]
    @variantes NVARCHAR(MAX),
    @id_producto BIGINT,
    @id_empresa BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @nuevo_id INT;
    DECLARE @variantTable TABLE (variante NVARCHAR(128),
        detalles NVARCHAR(MAX));
    DECLARE @detailTable TABLE (nombre NVARCHAR(128));

    BEGIN TRY
        -- No se inicia una nueva transacción, se asume que ya está en una transacción activa
        
        -- Convertir el JSON de variantes a una tabla
        INSERT INTO @variantTable
        (variante, detalles)
    SELECT variante, detalles
    FROM OPENJSON(@variantes)
        WITH (
            variante NVARCHAR(128) '$.variante',
            detalles NVARCHAR(MAX) AS JSON
        );

        DECLARE @variante NVARCHAR(128);
        DECLARE @detalles NVARCHAR(MAX);

        DECLARE variant_cursor CURSOR FOR
        SELECT variante, detalles
    FROM @variantTable;

        OPEN variant_cursor;

        FETCH NEXT FROM variant_cursor INTO @variante, @detalles;

        WHILE @@FETCH_STATUS = 0
        BEGIN
        -- Insertar el nuevo variante
        INSERT INTO variante
            (nombre, estado, id_producto, id_empresa)
        VALUES
            (@variante, 1, @id_producto, @id_empresa);

        SET @nuevo_id = SCOPE_IDENTITY();

        -- Convertir el JSON de detalles a una tabla
        INSERT INTO @detailTable
            (nombre)
        SELECT detalle
        FROM OPENJSON(@detalles)
            WITH (detalle NVARCHAR(128) '$.detalle');

        -- Insertar los detalles del variante
        INSERT INTO detalle_variante
            (nombre, estado, id_variante, id_empresa)
        SELECT nombre, 1, @nuevo_id, @id_empresa
        FROM @detailTable;

        -- Limpiar la tabla temporal de detalles
        DELETE FROM @detailTable;

        FETCH NEXT FROM variant_cursor INTO @variante, @detalles;
    END

        CLOSE variant_cursor;
        DEALLOCATE variant_cursor;
        
        -- Se confía en el procedimiento externo para el COMMIT
    END TRY
    BEGIN CATCH
        -- Se propaga el error para que lo gestione el procedimiento externo
        THROW;
    END CATCH;
END;
GO
USE [master]
GO
ALTER DATABASE [datpos_project] SET  READ_WRITE 
GO
