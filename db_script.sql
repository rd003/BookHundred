USE [master]
GO
/****** Object:  Database [BookHundred] *****/
CREATE DATABASE [BookHundred]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookHundred', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\BookHundred.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BookHundred_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\BookHundred_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BookHundred] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookHundred].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookHundred] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookHundred] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookHundred] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookHundred] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookHundred] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookHundred] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookHundred] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookHundred] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookHundred] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookHundred] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookHundred] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookHundred] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookHundred] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookHundred] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookHundred] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BookHundred] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookHundred] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookHundred] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookHundred] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookHundred] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookHundred] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookHundred] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookHundred] SET RECOVERY FULL 
GO
ALTER DATABASE [BookHundred] SET  MULTI_USER 
GO
ALTER DATABASE [BookHundred] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookHundred] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookHundred] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookHundred] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BookHundred] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BookHundred] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BookHundred', N'ON'
GO
ALTER DATABASE [BookHundred] SET QUERY_STORE = ON
GO
ALTER DATABASE [BookHundred] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BookHundred]
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 13-09-2023 12:03:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString]
(
    @String NVARCHAR(MAX),
    @Delimiter CHAR(1)
)
RETURNS TABLE
AS
RETURN (
    SELECT Value
    FROM (
        SELECT 
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum,
            LTRIM(RTRIM(SUBSTRING(@String, Number, CHARINDEX(@Delimiter, @String + @Delimiter, Number) - Number))) AS Value
        FROM master.dbo.spt_values
        WHERE Type = 'P'
            AND Number BETWEEN 1 AND LEN(@String) + 1
            AND SUBSTRING(@Delimiter + @String, Number, 1) = @Delimiter
    ) AS Split
    WHERE Value IS NOT NULL
);
GO
/****** Object:  Table [dbo].[Book]    Script Date: 13-09-2023 12:03:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Author] [nvarchar](100) NULL,
	[Country] [nvarchar](100) NULL,
	[ImageLink] [nvarchar](100) NULL,
	[Language] [nvarchar](20) NULL,
	[Link] [nvarchar](200) NULL,
	[Pages] [int] NULL,
	[Title] [nvarchar](100) NULL,
	[Year] [int] NULL,
	[Price] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Book] ON 
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (1, N'Chinua Achebe', N'Nigeria', N'things-fall-apart.jpg', N'English', N'https://en.wikipedia.org/wiki/Things_Fall_Apart\n', 209, N'Things Fall Apart', 1958, 150)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (2, N'Hans Christian Andersen', N'Denmark', N'fairy-tales.jpg', N'Danish', N'https://en.wikipedia.org/wiki/Fairy_Tales_Told_for_Children._First_Collection.
', 784, N'Fairy tales', 1836, 134)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (3, N'Dante Alighieri', N'Italy', N'the-divine-comedy.jpg', N'Italian', N'https://en.wikipedia.org/wiki/Divine_Comedy
', 928, N'The Divine Comedy', 1315, 119)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (4, N'Unknown', N'Sumer and Akkadian Empire', N'the-epic-of-gilgamesh.jpg', N'Akkadian', N'https://en.wikipedia.org/wiki/Epic_of_Gilgamesh
', 160, N'The Epic Of Gilgamesh', -1700, 106)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (5, N'Unknown', N'Achaemenid Empire', N'the-book-of-job.jpg', N'Hebrew', N'https://en.wikipedia.org/wiki/Book_of_Job
', 176, N'The Book Of Job', -600, 337)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (6, N'Unknown', N'India/Iran/Iraq/Egypt/Tajikistan', N'one-thousand-and-one-nights.jpg', N'Arabic', N'https://en.wikipedia.org/wiki/One_Thousand_and_One_Nights
', 288, N'One Thousand and One Nights', 1200, 199)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (7, N'Unknown', N'Iceland', N'njals-saga.jpg', N'Old Norse', N'https://en.wikipedia.org/wiki/Nj%C3%A1ls_saga
', 384, N'Njál''s Saga', 1350, 379)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (8, N'Jane Austen', N'United Kingdom', N'pride-and-prejudice.jpg', N'English', N'https://en.wikipedia.org/wiki/Pride_and_Prejudice
', 226, N'Pride and Prejudice', 1813, 385)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (9, N'Honoré de Balzac', N'France', N'le-pere-goriot.jpg', N'French', N'https://en.wikipedia.org/wiki/Le_P%C3%A8re_Goriot
', 443, N'Le Père Goriot', 1835, 354)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (10, N'Samuel Beckett', N'Republic of Ireland', N'molloy-malone-dies-the-unnamable.jpg', N'French, English', N'https://en.wikipedia.org/wiki/Molloy_(novel)
', 256, N'Molloy, Malone Dies, The Unnamable, the trilogy', 1952, 300)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (11, N'Giovanni Boccaccio', N'Italy', N'the-decameron.jpg', N'Italian', N'https://en.wikipedia.org/wiki/The_Decameron
', 1024, N'The Decameron', 1351, 378)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (12, N'Jorge Luis Borges', N'Argentina', N'ficciones.jpg', N'Spanish', N'https://en.wikipedia.org/wiki/Ficciones
', 224, N'Ficciones', 1965, 329)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (13, N'Emily Brontë', N'United Kingdom', N'wuthering-heights.jpg', N'English', N'https://en.wikipedia.org/wiki/Wuthering_Heights
', 342, N'Wuthering Heights', 1847, 156)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (14, N'Albert Camus', N'Algeria, French Empire', N'l-etranger.jpg', N'French', N'https://en.wikipedia.org/wiki/The_Stranger_(novel)
', 185, N'The Stranger', 1942, 120)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (15, N'Paul Celan', N'Romania, France', N'poems-paul-celan.jpg', N'German', N'
', 320, N'Poems', 1952, 316)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (16, N'Louis-Ferdinand Céline', N'France', N'voyage-au-bout-de-la-nuit.jpg', N'French', N'https://en.wikipedia.org/wiki/Journey_to_the_End_of_the_Night
', 505, N'Journey to the End of the Night', 1932, 313)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (17, N'Miguel de Cervantes', N'Spain', N'don-quijote-de-la-mancha.jpg', N'Spanish', N'https://en.wikipedia.org/wiki/Don_Quixote
', 1056, N'Don Quijote De La Mancha', 1610, 269)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (18, N'Geoffrey Chaucer', N'England', N'the-canterbury-tales.jpg', N'English', N'https://en.wikipedia.org/wiki/The_Canterbury_Tales
', 544, N'The Canterbury Tales', 1450, 269)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (19, N'Anton Chekhov', N'Russia', N'stories-of-anton-chekhov.jpg', N'Russian', N'https://en.wikipedia.org/wiki/List_of_short_stories_by_Anton_Chekhov
', 194, N'Stories', 1886, 277)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (20, N'Joseph Conrad', N'United Kingdom', N'nostromo.jpg', N'English', N'https://en.wikipedia.org/wiki/Nostromo
', 320, N'Nostromo', 1904, 230)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (21, N'Charles Dickens', N'United Kingdom', N'great-expectations.jpg', N'English', N'https://en.wikipedia.org/wiki/Great_Expectations
', 194, N'Great Expectations', 1861, 176)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (22, N'Denis Diderot', N'France', N'jacques-the-fatalist.jpg', N'French', N'https://en.wikipedia.org/wiki/Jacques_the_Fatalist
', 596, N'Jacques the Fatalist', 1796, 199)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (23, N'Alfred Döblin', N'Germany', N'berlin-alexanderplatz.jpg', N'German', N'https://en.wikipedia.org/wiki/Berlin_Alexanderplatz
', 600, N'Berlin Alexanderplatz', 1929, 172)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (24, N'Fyodor Dostoevsky', N'Russia', N'crime-and-punishment.jpg', N'Russian', N'https://en.wikipedia.org/wiki/Crime_and_Punishment
', 551, N'Crime and Punishment', 1866, 278)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (25, N'Fyodor Dostoevsky', N'Russia', N'the-idiot.jpg', N'Russian', N'https://en.wikipedia.org/wiki/The_Idiot
', 656, N'The Idiot', 1869, 241)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (26, N'Fyodor Dostoevsky', N'Russia', N'the-possessed.jpg', N'Russian', N'https://en.wikipedia.org/wiki/Demons_(Dostoyevsky_novel)
', 768, N'The Possessed', 1872, 298)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (27, N'Fyodor Dostoevsky', N'Russia', N'the-brothers-karamazov.jpg', N'Russian', N'https://en.wikipedia.org/wiki/The_Brothers_Karamazov
', 824, N'The Brothers Karamazov', 1880, 152)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (28, N'George Eliot', N'United Kingdom', N'middlemarch.jpg', N'English', N'https://en.wikipedia.org/wiki/Middlemarch
', 800, N'Middlemarch', 1871, 157)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (29, N'Ralph Ellison', N'United States', N'invisible-man.jpg', N'English', N'https://en.wikipedia.org/wiki/Invisible_Man
', 581, N'Invisible Man', 1952, 395)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (30, N'Euripides', N'Greece', N'medea.jpg', N'Greek', N'https://en.wikipedia.org/wiki/Medea_(play)
', 104, N'Medea', -431, 188)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (31, N'William Faulkner', N'United States', N'absalom-absalom.jpg', N'English', N'https://en.wikipedia.org/wiki/Absalom,_Absalom!
', 313, N'Absalom, Absalom!', 1936, 151)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (32, N'William Faulkner', N'United States', N'the-sound-and-the-fury.jpg', N'English', N'https://en.wikipedia.org/wiki/The_Sound_and_the_Fury
', 326, N'The Sound and the Fury', 1929, 383)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (33, N'Gustave Flaubert', N'France', N'madame-bovary.jpg', N'French', N'https://en.wikipedia.org/wiki/Madame_Bovary
', 528, N'Madame Bovary', 1857, 148)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (34, N'Gustave Flaubert', N'France', N'l-education-sentimentale.jpg', N'French', N'https://en.wikipedia.org/wiki/Sentimental_Education
', 606, N'Sentimental Education', 1869, 168)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (35, N'Federico García Lorca', N'Spain', N'gypsy-ballads.jpg', N'Spanish', N'https://en.wikipedia.org/wiki/Gypsy_Ballads
', 218, N'Gypsy Ballads', 1928, 376)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (36, N'Gabriel García Márquez', N'Colombia', N'one-hundred-years-of-solitude.jpg', N'Spanish', N'https://en.wikipedia.org/wiki/One_Hundred_Years_of_Solitude
', 417, N'One Hundred Years of Solitude', 1967, 215)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (37, N'Gabriel García Márquez', N'Colombia', N'love-in-the-time-of-cholera.jpg', N'Spanish', N'https://en.wikipedia.org/wiki/Love_in_the_Time_of_Cholera
', 368, N'Love in the Time of Cholera', 1985, 194)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (38, N'Johann Wolfgang von Goethe', N'Saxe-Weimar', N'faust.jpg', N'German', N'https://en.wikipedia.org/wiki/Goethe%27s_Faust
', 158, N'Faust', 1832, 396)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (39, N'Nikolai Gogol', N'Russia', N'dead-souls.jpg', N'Russian', N'https://en.wikipedia.org/wiki/Dead_Souls
', 432, N'Dead Souls', 1842, 243)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (40, N'Günter Grass', N'Germany', N'the-tin-drum.jpg', N'German', N'https://en.wikipedia.org/wiki/The_Tin_Drum
', 600, N'The Tin Drum', 1959, 200)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (41, N'João Guimarães Rosa', N'Brazil', N'the-devil-to-pay-in-the-backlands.jpg', N'Portuguese', N'https://en.wikipedia.org/wiki/The_Devil_to_Pay_in_the_Backlands
', 494, N'The Devil to Pay in the Backlands', 1956, 354)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (42, N'Knut Hamsun', N'Norway', N'hunger.jpg', N'Norwegian', N'https://en.wikipedia.org/wiki/Hunger_(Hamsun_novel)
', 176, N'Hunger', 1890, 311)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (43, N'Ernest Hemingway', N'United States', N'the-old-man-and-the-sea.jpg', N'English', N'https://en.wikipedia.org/wiki/The_Old_Man_and_the_Sea
', 128, N'The Old Man and the Sea', 1952, 243)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (44, N'Homer', N'Greece', N'the-iliad-of-homer.jpg', N'Greek', N'https://en.wikipedia.org/wiki/Iliad
', 608, N'Iliad', -735, 276)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (45, N'Homer', N'Greece', N'the-odyssey-of-homer.jpg', N'Greek', N'https://en.wikipedia.org/wiki/Odyssey
', 374, N'Odyssey', -800, 268)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (46, N'Henrik Ibsen', N'Norway', N'a-Dolls-house.jpg', N'Norwegian', N'https://en.wikipedia.org/wiki/A_Doll%27s_House
', 68, N'A Doll''s House', 1879, 388)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (47, N'James Joyce', N'Irish Free State', N'ulysses.jpg', N'English', N'https://en.wikipedia.org/wiki/Ulysses_(novel)
', 228, N'Ulysses', 1922, 187)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (48, N'Franz Kafka', N'Czechoslovakia', N'stories-of-franz-kafka.jpg', N'German', N'https://en.wikipedia.org/wiki/Franz_Kafka_bibliography#Short_stories
', 488, N'Stories', 1924, 132)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (49, N'Franz Kafka', N'Czechoslovakia', N'the-trial.jpg', N'German', N'https://en.wikipedia.org/wiki/The_Trial
', 160, N'The Trial', 1925, 211)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (50, N'Franz Kafka', N'Czechoslovakia', N'the-castle.jpg', N'German', N'https://en.wikipedia.org/wiki/The_Castle_(novel)
', 352, N'The Castle', 1926, 159)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (51, N'Kālidāsa', N'India', N'the-recognition-of-shakuntala.jpg', N'Sanskrit', N'https://en.wikipedia.org/wiki/Abhij%C3%B1%C4%81na%C5%9B%C4%81kuntalam
', 147, N'The recognition of Shakuntala', 150, 234)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (52, N'Yasunari Kawabata', N'Japan', N'the-sound-of-the-mountain.jpg', N'Japanese', N'https://en.wikipedia.org/wiki/The_Sound_of_the_Mountain
', 288, N'The Sound of the Mountain', 1954, 117)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (53, N'Nikos Kazantzakis', N'Greece', N'zorba-the-greek.jpg', N'Greek', N'https://en.wikipedia.org/wiki/Zorba_the_Greek
', 368, N'Zorba the Greek', 1946, 168)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (54, N'D. H. Lawrence', N'United Kingdom', N'sons-and-lovers.jpg', N'English', N'https://en.wikipedia.org/wiki/Sons_and_Lovers
', 432, N'Sons and Lovers', 1913, 333)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (55, N'Halldór Laxness', N'Iceland', N'independent-people.jpg', N'Icelandic', N'https://en.wikipedia.org/wiki/Independent_People
', 470, N'Independent People', 1934, 249)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (56, N'Giacomo Leopardi', N'Italy', N'poems-giacomo-leopardi.jpg', N'Italian', N'
', 184, N'Poems', 1818, 239)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (57, N'Doris Lessing', N'United Kingdom', N'the-golden-notebook.jpg', N'English', N'https://en.wikipedia.org/wiki/The_Golden_Notebook
', 688, N'The Golden Notebook', 1962, 168)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (58, N'Astrid Lindgren', N'Sweden', N'pippi-longstocking.jpg', N'Swedish', N'https://en.wikipedia.org/wiki/Pippi_Longstocking
', 160, N'Pippi Longstocking', 1945, 115)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (59, N'Lu Xun', N'China', N'diary-of-a-madman.jpg', N'Chinese', N'https://en.wikipedia.org/wiki/A_Madman%27s_Diary
', 389, N'Diary of a Madman', 1918, 146)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (60, N'Naguib Mahfouz', N'Egypt', N'children-of-gebelawi.jpg', N'Arabic', N'https://en.wikipedia.org/wiki/Children_of_Gebelawi
', 355, N'Children of Gebelawi', 1959, 281)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (61, N'Thomas Mann', N'Germany', N'buddenbrooks.jpg', N'German', N'https://en.wikipedia.org/wiki/Buddenbrooks
', 736, N'Buddenbrooks', 1901, 307)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (62, N'Thomas Mann', N'Germany', N'the-magic-mountain.jpg', N'German', N'https://en.wikipedia.org/wiki/The_Magic_Mountain
', 720, N'The Magic Mountain', 1924, 283)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (63, N'Herman Melville', N'United States', N'moby-dick.jpg', N'English', N'https://en.wikipedia.org/wiki/Moby-Dick
', 378, N'Moby Dick', 1851, 101)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (64, N'Michel de Montaigne', N'France', N'essais.jpg', N'French', N'https://en.wikipedia.org/wiki/Essays_(Montaigne)
', 404, N'Essays', 1595, 227)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (65, N'Elsa Morante', N'Italy', N'history.jpg', N'Italian', N'https://en.wikipedia.org/wiki/History_(novel)
', 600, N'History', 1974, 271)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (66, N'Toni Morrison', N'United States', N'beloved.jpg', N'English', N'https://en.wikipedia.org/wiki/Beloved_(novel)
', 321, N'Beloved', 1987, 300)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (67, N'Murasaki Shikibu', N'Japan', N'the-tale-of-genji.jpg', N'Japanese', N'https://en.wikipedia.org/wiki/The_Tale_of_Genji
', 1360, N'The Tale of Genji', 1006, 100)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (68, N'Robert Musil', N'Austria', N'the-man-without-qualities.jpg', N'German', N'https://en.wikipedia.org/wiki/The_Man_Without_Qualities
', 365, N'The Man Without Qualities', 1931, 346)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (69, N'Vladimir Nabokov', N'Russia/United States', N'lolita.jpg', N'English', N'https://en.wikipedia.org/wiki/Lolita
', 317, N'Lolita', 1955, 200)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (70, N'George Orwell', N'United Kingdom', N'nineteen-eighty-four.jpg', N'English', N'https://en.wikipedia.org/wiki/Nineteen_Eighty-Four
', 272, N'Nineteen Eighty-Four', 1949, 352)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (71, N'Ovid', N'Roman Empire', N'the-metamorphoses-of-ovid.jpg', N'Classical Latin', N'https://en.wikipedia.org/wiki/Metamorphoses
', 576, N'Metamorphoses', 100, 193)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (72, N'Fernando Pessoa', N'Portugal', N'the-book-of-disquiet.jpg', N'Portuguese', N'https://en.wikipedia.org/wiki/The_Book_of_Disquiet
', 272, N'The Book of Disquiet', 1928, 246)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (73, N'Edgar Allan Poe', N'United States', N'tales-and-poems-of-edgar-allan-poe.jpg', N'English', N'https://en.wikipedia.org/wiki/Edgar_Allan_Poe_bibliography#Tales
', 842, N'Tales', 1950, 150)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (74, N'Marcel Proust', N'France', N'a-la-recherche-du-temps-perdu.jpg', N'French', N'https://en.wikipedia.org/wiki/In_Search_of_Lost_Time
', 2408, N'In Search of Lost Time', 1920, 384)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (75, N'François Rabelais', N'France', N'gargantua-and-pantagruel.jpg', N'French', N'https://en.wikipedia.org/wiki/Gargantua_and_Pantagruel
', 623, N'Gargantua and Pantagruel', 1533, 148)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (76, N'Juan Rulfo', N'Mexico', N'pedro-paramo.jpg', N'Spanish', N'https://en.wikipedia.org/wiki/Pedro_P%C3%A1ramo
', 124, N'Pedro Páramo', 1955, 347)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (77, N'Rumi', N'Sultanate of Rum', N'the-masnavi.jpg', N'Persian', N'https://en.wikipedia.org/wiki/Masnavi
', 438, N'The Masnavi', 1236, 315)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (78, N'Salman Rushdie', N'United Kingdom, India', N'midnights-children.jpg', N'English', N'https://en.wikipedia.org/wiki/Midnight%27s_Children
', 536, N'Midnight''s Children', 1981, 270)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (79, N'Saadi', N'Persia, Persian Empire', N'bostan.jpg', N'Persian', N'https://en.wikipedia.org/wiki/Bustan_(book)
', 298, N'Bostan', 1257, 299)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (80, N'Tayeb Salih', N'Sudan', N'season-of-migration-to-the-north.jpg', N'Arabic', N'https://en.wikipedia.org/wiki/Season_of_Migration_to_the_North
', 139, N'Season of Migration to the North', 1966, 338)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (81, N'José Saramago', N'Portugal', N'blindness.jpg', N'Portuguese', N'https://en.wikipedia.org/wiki/Blindness_(novel)
', 352, N'Blindness', 1995, 297)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (82, N'William Shakespeare', N'England', N'hamlet.jpg', N'English', N'https://en.wikipedia.org/wiki/Hamlet
', 432, N'Hamlet', 1603, 211)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (83, N'William Shakespeare', N'England', N'king-lear.jpg', N'English', N'https://en.wikipedia.org/wiki/King_Lear
', 384, N'King Lear', 1608, 254)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (84, N'William Shakespeare', N'England', N'othello.jpg', N'English', N'https://en.wikipedia.org/wiki/Othello
', 314, N'Othello', 1609, 298)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (85, N'Sophocles', N'Greece', N'oedipus-the-king.jpg', N'Greek', N'https://en.wikipedia.org/wiki/Oedipus_the_King
', 88, N'Oedipus the King', -430, 378)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (86, N'Stendhal', N'France', N'le-rouge-et-le-noir.jpg', N'French', N'https://en.wikipedia.org/wiki/The_Red_and_the_Black
', 576, N'The Red and the Black', 1830, 241)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (87, N'Laurence Sterne', N'England', N'the-life-and-opinions-of-tristram-shandy.jpg', N'English', N'https://en.wikipedia.org/wiki/The_Life_and_Opinions_of_Tristram_Shandy,_Gentleman
', 640, N'The Life And Opinions of Tristram Shandy', 1760, 346)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (88, N'Italo Svevo', N'Italy', N'confessions-of-zeno.jpg', N'Italian', N'https://en.wikipedia.org/wiki/Zeno%27s_Conscience
', 412, N'Confessions of Zeno', 1923, 113)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (89, N'Jonathan Swift', N'Ireland', N'gullivers-travels.jpg', N'English', N'https://en.wikipedia.org/wiki/Gulliver%27s_Travels
', 178, N'Gulliver''s Travels', 1726, 334)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (90, N'Leo Tolstoy', N'Russia', N'war-and-peace.jpg', N'Russian', N'https://en.wikipedia.org/wiki/War_and_Peace
', 1296, N'War and Peace', 1867, 163)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (91, N'Leo Tolstoy', N'Russia', N'anna-karenina.jpg', N'Russian', N'https://en.wikipedia.org/wiki/Anna_Karenina
', 864, N'Anna Karenina', 1877, 102)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (92, N'Leo Tolstoy', N'Russia', N'the-death-of-ivan-ilyich.jpg', N'Russian', N'https://en.wikipedia.org/wiki/The_Death_of_Ivan_Ilyich
', 92, N'The Death of Ivan Ilyich', 1886, 197)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (93, N'Mark Twain', N'United States', N'the-adventures-of-huckleberry-finn.jpg', N'English', N'https://en.wikipedia.org/wiki/Adventures_of_Huckleberry_Finn
', 224, N'The Adventures of Huckleberry Finn', 1884, 101)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (94, N'Valmiki', N'India', N'ramayana.jpg', N'Sanskrit', N'https://en.wikipedia.org/wiki/Ramayana
', 152, N'Ramayana', -450, 138)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (95, N'Virgil', N'Roman Empire', N'the-aeneid.jpg', N'Classical Latin', N'https://en.wikipedia.org/wiki/Aeneid
', 442, N'The Aeneid', -23, 392)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (96, N'Vyasa', N'India', N'the-mahab-harata.jpg', N'Sanskrit', N'https://en.wikipedia.org/wiki/Mahabharata
', 276, N'Mahabharata', -700, 316)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (97, N'Walt Whitman', N'United States', N'leaves-of-grass.jpg', N'English', N'https://en.wikipedia.org/wiki/Leaves_of_Grass
', 152, N'Leaves of Grass', 1855, 375)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (98, N'Virginia Woolf', N'United Kingdom', N'mrs-dalloway.jpg', N'English', N'https://en.wikipedia.org/wiki/Mrs_Dalloway
', 216, N'Mrs Dalloway', 1925, 329)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (99, N'Virginia Woolf', N'United Kingdom', N'to-the-lighthouse.jpg', N'English', N'https://en.wikipedia.org/wiki/To_the_Lighthouse
', 209, N'To the Lighthouse', 1927, 108)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (100, N'Marguerite Yourcenar', N'France/Belgium', N'emoirs-of-hadrian.jpg', N'French', N'https://en.wikipedia.org/wiki/Memoirs_of_Hadrian
', 408, N'Memoirs of Hadrian', 1951, 103)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (101, N'Munshi Premchand', N'India', N'', N'Hindi', N'', 500, N'Godan', 1943, 300)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (104, N'Dharamveer Bharti', N'Inida', N'', N'Hindi', N'', 302, N'Gunahon Ka Devta', 1949, 395)
GO
INSERT [dbo].[Book] ([Id], [Author], [Country], [ImageLink], [Language], [Link], [Pages], [Title], [Year], [Price]) VALUES (106, N'Dharamveer Bharti', N'Inida', N'', N'Hindi', N'', 300, N'Sooraj ka satwan ghoda', 1952, 380)
GO
SET IDENTITY_INSERT [dbo].[Book] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Author]    Script Date: 13-09-2023 12:03:37 ******/
CREATE NONCLUSTERED INDEX [IX_Author] ON [dbo].[Book]
(
	[Author] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Language]    Script Date: 13-09-2023 12:03:37 ******/
CREATE NONCLUSTERED INDEX [IX_Language] ON [dbo].[Book]
(
	[Language] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Title]    Script Date: 13-09-2023 12:03:37 ******/
CREATE NONCLUSTERED INDEX [IX_Title] ON [dbo].[Book]
(
	[Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spAddBook]    Script Date: 13-09-2023 12:03:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spAddBook]
@Author nvarchar(100) =null,
@Country nvarchar(100)=null,
@ImageLink nvarchar(100)=null, 
@Language nvarchar(20)=null,
@Link nvarchar(200)=null,
@Pages int=null,
@Title nvarchar(100)=null,
@Year int =null,
@Price int = null,
@Id int output
as
begin
  insert into Book 
  ([Author],[Country],[ImageLink],[Language],[Link],[Pages],[Title],[Year],[Price])
  values(@Author,@Country,@ImageLink,@Language,@Link,@Pages,@Title,@Year,@Price)
  /* return recently added column */
 set @Id= SCOPE_IDENTITY()
end
GO
/****** Object:  StoredProcedure [dbo].[spDeleteBook]    Script Date: 13-09-2023 12:03:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spDeleteBook]
@Id int
as
begin
  delete from dbo.Book
  where Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[spGetBookById]    Script Date: 13-09-2023 12:03:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spGetBookById]
@Id int
as
begin
  select * from dbo.Book
  where Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[spGetBooks]    Script Date: 13-09-2023 12:03:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spGetBooks]  
 @page int=1,  
 @limit int=10,  
 @languages nvarchar(200)= null,  
 @searchTerm nvarchar(40) = null,  
 @sortColumn nvarchar(30)='id',  
 @sortDirection nvarchar(30)='asc'  
as  
begin  
  
select * from dbo.Book  
 where (@searchTerm is null or author like '%'+@searchTerm+'%' or title like '%'+@searchTerm+'%')  
 and (@languages is null or [language] in  
(select * from string_split(@languages,',')))  
order by   
case when @sortColumn='id' and @sortDirection='asc' then id end,  
case when @sortColumn='id' and @sortDirection='desc' then id end desc,  
case when @sortColumn='title' and @sortDirection='asc' then title end,  
case when @sortColumn='title' and @sortDirection='desc' then title  end desc,  
case when @sortColumn='author' and @sortDirection='asc' then author end,  
case when @sortColumn='author' and @sortDirection='desc' then author  end desc,  
case when @sortColumn='language' and @sortDirection='asc' then [language] end,  
case when @sortColumn='language' and @sortDirection='desc' then [language] end desc  
  
OFFSET (@page - 1) * @limit ROWS  
FETCH NEXT @limit ROWS ONLY;  
  
select count(id) as TotalRecords,CAST(CEILING((count(id)*1.0)/@limit)as int) as TotalPages 
 from dbo.Book  
 where (@searchTerm is null or author like '%'+@searchTerm+'%' or title like '%'+@searchTerm+'%')  
 and (@languages is null or [language] in  
(select * from string_split(@languages,',')))  
  
end  
GO
/****** Object:  StoredProcedure [dbo].[spGetLanguages]    Script Date: 13-09-2023 12:03:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spGetLanguages]
as
begin
 select distinct [Language] from Book order by [Language]
end
GO
/****** Object:  StoredProcedure [dbo].[spUpdateBook]    Script Date: 13-09-2023 12:03:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spUpdateBook]
@Id int,
@Author nvarchar(100) =null,
@Country nvarchar(100)=null,
@ImageLink nvarchar(100)=null, 
@Language nvarchar(20)=null,
@Link nvarchar(200)=null,
@Pages int=null,
@Title nvarchar(100)=null,
@Year int =null,
@Price int = null
as
begin
   update  dbo.Book
   set [Author]=@Author,
   [Country]=@Country,
   [ImageLink]=@ImageLink,
   [Language]=@Language,
   [Link]=@Link,
   [Pages]=@Pages,
   [Title]=@Title,
   [Year]=@Year,
   [Price]=@Price
  where Id=@Id
end
GO
USE [master]
GO
ALTER DATABASE [BookHundred] SET  READ_WRITE 
GO
