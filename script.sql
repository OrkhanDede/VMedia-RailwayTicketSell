USE [RailwayDb]
GO
/****** Object:  Table [dbo].[Passengers]    Script Date: 10/16/2022 11:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Passengers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Gender] [int] NOT NULL,
	[Age] [int] NOT NULL,
	[SeatNo] [int] NOT NULL,
	[Pnr] [nvarchar](450) NOT NULL,
	[ReservationStatus] [int] NOT NULL,
	[FromStationId] [int] NOT NULL,
	[ToStationId] [int] NOT NULL,
	[TicketId] [int] NOT NULL,
 CONSTRAINT [PK_Passengers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stations]    Script Date: 10/16/2022 11:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Code] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_Stations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 10/16/2022 11:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[Status] [int] NOT NULL,
	[PassengerId] [int] NOT NULL,
	[Code] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrainRoutes]    Script Date: 10/16/2022 11:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrainRoutes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartureDateTime] [datetime2](7) NOT NULL,
	[ArrivalDateTime] [datetime2](7) NOT NULL,
	[StationId] [int] NOT NULL,
	[TrainId] [int] NULL,
 CONSTRAINT [PK_TrainRoutes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trains]    Script Date: 10/16/2022 11:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trains](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Code] [nvarchar](450) NOT NULL,
	[FromStationId] [int] NOT NULL,
	[ToStationId] [int] NOT NULL,
 CONSTRAINT [PK_Trains] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrainStatus]    Script Date: 10/16/2022 11:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrainStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AvailableBusinessSeatCount] [int] NOT NULL,
	[AvailableEconomicSeatCount] [int] NOT NULL,
	[BookedBusinessSeatCount] [int] NOT NULL,
	[BookedEconomicSeatCount] [int] NOT NULL,
	[AvailableDate] [datetime2](7) NOT NULL,
	[TrainId] [int] NOT NULL,
 CONSTRAINT [PK_TrainStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tickets] ADD  DEFAULT (N'') FOR [Code]
GO
ALTER TABLE [dbo].[Trains] ADD  DEFAULT ((0)) FOR [FromStationId]
GO
ALTER TABLE [dbo].[Trains] ADD  DEFAULT ((0)) FOR [ToStationId]
GO
ALTER TABLE [dbo].[Passengers]  WITH CHECK ADD  CONSTRAINT [FK_Passengers_Stations_FromStationId] FOREIGN KEY([FromStationId])
REFERENCES [dbo].[Stations] ([Id])
GO
ALTER TABLE [dbo].[Passengers] CHECK CONSTRAINT [FK_Passengers_Stations_FromStationId]
GO
ALTER TABLE [dbo].[Passengers]  WITH CHECK ADD  CONSTRAINT [FK_Passengers_Stations_ToStationId] FOREIGN KEY([ToStationId])
REFERENCES [dbo].[Stations] ([Id])
GO
ALTER TABLE [dbo].[Passengers] CHECK CONSTRAINT [FK_Passengers_Stations_ToStationId]
GO
ALTER TABLE [dbo].[Passengers]  WITH CHECK ADD  CONSTRAINT [FK_Passengers_Tickets_TicketId] FOREIGN KEY([TicketId])
REFERENCES [dbo].[Tickets] ([Id])
GO
ALTER TABLE [dbo].[Passengers] CHECK CONSTRAINT [FK_Passengers_Tickets_TicketId]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Passengers_PassengerId] FOREIGN KEY([PassengerId])
REFERENCES [dbo].[Passengers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Passengers_PassengerId]
GO
ALTER TABLE [dbo].[TrainRoutes]  WITH CHECK ADD  CONSTRAINT [FK_TrainRoutes_Stations_StationId] FOREIGN KEY([StationId])
REFERENCES [dbo].[Stations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TrainRoutes] CHECK CONSTRAINT [FK_TrainRoutes_Stations_StationId]
GO
ALTER TABLE [dbo].[TrainRoutes]  WITH CHECK ADD  CONSTRAINT [FK_TrainRoutes_Trains_TrainId] FOREIGN KEY([TrainId])
REFERENCES [dbo].[Trains] ([Id])
GO
ALTER TABLE [dbo].[TrainRoutes] CHECK CONSTRAINT [FK_TrainRoutes_Trains_TrainId]
GO
ALTER TABLE [dbo].[Trains]  WITH CHECK ADD  CONSTRAINT [FK_Trains_Stations_FromStationId] FOREIGN KEY([FromStationId])
REFERENCES [dbo].[Stations] ([Id])
GO
ALTER TABLE [dbo].[Trains] CHECK CONSTRAINT [FK_Trains_Stations_FromStationId]
GO
ALTER TABLE [dbo].[Trains]  WITH CHECK ADD  CONSTRAINT [FK_Trains_Stations_ToStationId] FOREIGN KEY([ToStationId])
REFERENCES [dbo].[Stations] ([Id])
GO
ALTER TABLE [dbo].[Trains] CHECK CONSTRAINT [FK_Trains_Stations_ToStationId]
GO
ALTER TABLE [dbo].[TrainStatus]  WITH CHECK ADD  CONSTRAINT [FK_TrainStatus_Trains_TrainId] FOREIGN KEY([TrainId])
REFERENCES [dbo].[Trains] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TrainStatus] CHECK CONSTRAINT [FK_TrainStatus_Trains_TrainId]
GO
