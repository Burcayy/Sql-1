-- Yorum satırı

CREATE DATABASE SecondDB; --  Database Olusturma
GO                        -- yukaridaki islem bitmeden alt satira gecme

USE SecondDB;
GO

CREATE TABLE Categories ( 
             CategoryId   INT PRIMARY KEY IDENTITY(1 , 1) , 
             CategoryName NVARCHAR(50) NOT NULL , -- bos gecilemez olarak isaretledik
             Description  NVARCHAR(150) NULL ,    -- default olarak bos gecilebilir yazmasaniz bi le, bos gecilebilir olacaktir 
             CreatedDate  DATETIME DEFAULT(GETDATE())
                        );  
GO

CREATE TABLE Products ( 
             ProductId    INT PRIMARY KEY IDENTITY(1 , 1) , 
             ProductName  NVARCHAR(50) NOT NULL , 
             UnitsInStock SMALLINT DEFAULT(1) , 
             UnitPrice    MONEY , 
             CreatedDate  DATETIME DEFAULT(GETDATE()) , 
             CategoryId   INT FOREIGN KEY REFERENCES Categories(CategoryId) -- bir kategorinin birden fazla ürünü olur, ürünler tablosuna foreignkey olarak kategori tablosunun primary key alanını ekliyoruz.
                      );