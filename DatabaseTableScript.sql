USE [master]
GO

CREATE TABLE [dbo].[SpottingLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Make] [varchar](128) NOT NULL,
	[Model] [varchar](128) NOT NULL,
	[Registration] [varchar](50) NOT NULL,
	[Location] [varchar](255) NOT NULL,
	[SpottedWhen] [datetime] NOT NULL,
	[Image] [varchar](50) NULL
 CONSTRAINT [PK_SpottingLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO