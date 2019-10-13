-- Veritabani islemleri 
-- 1) INSERT: Bir veritabanindaki tablolardan birine yeni kayit eklemek icin kullanacagimiz komuttur.


/*

 insert into <tablo_adi>(sutun_adlari) values (sutun_degerleri)
 
*/


USE Northwind;
 
INSERT INTO Categories ( CategoryName , [Description]
                       ) 
VALUES ( 'Kategori Adı' , 'Açıklama Alanı'
       );

SELECT CategoryName , Description
FROM Categories;
 
INSERT INTO Categories ( Description
                       ) 
VALUES ( 'Çok Pahalı'
       );

-- Cannot insert the value NULL into column 'CategoryName', table 'Northwind.dbo.Categories'; column does not allow nulls. INSERT fails.

-- Eğer bir tablodaki sütunların hepsine veri gireceksek tablo adından sonra sütun adlarını açıktan belirtmemize gerek yok, direkt Values 
--ile sütunların içereği değerleri atayabiliriz. Ancak dikkat etmemiz gereken sütunların verilerini girerken, tablonun yapısına uygun olacak
-- şekilde girmeliyiz. (Yani, CompanyName sütunu Phone sütunundan önce olduğu için Values kısmında ilk belirteceğimiz değer CompanyName sütununa 
--ait olmalı aksi durumda sütunların veri tipleri uyumluysa veriler yanlış sütunlara girilir.)

SELECT *
FROM Shippers;

INSERT INTO Shippers
VALUES ( 'MNG Kargo' , '(503) 555-9831'
       );
 
INSERT INTO Shippers
VALUES ( '(503) 555-9831' , 'Aras Kargo'
       );

SELECT *
FROM Shippers;


BEGIN TRANSACTION;

INSERT INTO Shippers
VALUES ( '(503) 555-9831' , 'Yurtiçi Kargo'
       );

ROLLBACK;


-- Customers tablosuna 'Bilge Adam' şirketini ekleyiniz.


INSERT INTO Customers ( CompanyName , CustomerID
                      ) 
VALUES ( 'Bilge Adam' , 'BLGDM'
       );

SELECT *
FROM Customers
WHERE CustomerID = 'BLGDM';

-- Customers tablosundaki CustomerID sütununun tipi nchar(5)'tir. Yani, bu sütun Identity olarak belirtilemez, dolayısıyla bu tabloya bir  kayıt girerken CustomerID sütununa da kendimiz veri girmeliyiz.


-- 2) Update: Bir tablodaki kayıtları güncellemek için kullanılır. Dikkat edilmesi gereken hangi kaydı güncelleyeceğimizi açıktan belirtmek

--AKSI HALDE TÜM KAYITLAR GÜNCELLENEBILIR.

/*

update <tablo_adi> set sutun_adi = sutun_degeri,
                   sutun_adi = sutun_degeri, 
				   vs...

*/
  
SELECT *
FROM Employees;
 
SELECT *
INTO Calisanlar
FROM Employees;

UPDATE Calisanlar
       SET LastName = 'Vuranok';

SELECT *
FROM Calisanlar;

--drop => bir nesneyi kalıcı olarak silmek için kullanılır.


SELECT *
INTO Calisanlar
FROM Employees;

-- DROP TABLE Calisanlar; Çalışanlar tablosunu kalıcı olarak siler


UPDATE Calisanlar
       SET FirstName = 'Murat' , LastName = 'Vuranok' , HomePhone = '+90(212)5556677'
WHERE EmployeeID = 2;


-- Shippers tablosunda yer alan kayıtlardan yanlış eklenmiş olan kaydı düzenleyiniz.
-- CompanyName to Phone
-- Phone to CompanyName


DECLARE @Phone NVARCHAR(50) , @CompanyName NVARCHAR(50);

SELECT @Phone = CompanyName , @CompanyName = Phone
FROM Shippers
WHERE ShipperID = 4;

-- print(@Phone)
-- print(@CompanyName)

UPDATE Shippers
       SET CompanyName = @CompanyName , Phone = @Phone
WHERE ShipperID = 4;

SELECT *
FROM Shippers;
  
SELECT ProductID , ProductName , OldPrice = UnitPrice , NewPrice = UnitPrice
INTO Urunler
FROM Products;

-- DROP TABLE Urunler;
-- Urunler tablosunda yer alan tüm ürünlere %5'lik zam yapınız :)
 
SELECT *
FROM Urunler;
 
UPDATE Urunler
       SET NewPrice = NewPrice + ( NewPrice * 0.05 );


-- 3) Delete: Bir tablodan kayıt silmek için kullanacağımız komuttur. Aynı Update işlemi gibi dikkat edilmesi gerekir, çünkü birden fazla kayıt 
--yanlışlıkla silinebilir.

/*
	Delete From <tablo_adi>	
*/
 
DELETE FROM Urunler;

SELECT *
FROM Urunler;

DROP TABLE Urunler;
 
SELECT *
FROM Calisanlar;
 
BEGIN TRAN; 
DELETE FROM Calisanlar
WHERE EmployeeID = 1; 
ROLLBACK;
 
DELETE FROM Calisanlar
WHERE TitleOfCourtesy IN ( 'Dr.' , 'Mr.'
                         );
 
DELETE FROM Calisanlar
WHERE Title = 'Sales Representative';

 
-- LIKE KULLANIMI
-- 1. YOL

SELECT FirstName , LastName
FROM Employees
WHERE FirstName = 'Michael';

-- 2. YOL

SELECT FirstName , LastName
FROM Employees
WHERE FirstName LIKE 'Michael';



-- Adının ilk harfi A ile başlayanlar
SELECT EmployeeID,FirstName , LastName
FROM Employees
WHERE FirstName LIKE 'A%';   

-- Soyadının son harfi N olanlar
SELECT EmployeeID,FirstName , LastName
FROM Employees
WHERE LastName LIKE '%N'; 

-- Adının içerisinde E harfi geçenler

SELECT EmployeeID,FirstName , LastName
FROM Employees
WHERE FirstName LIKE '%E%'; 

-- Adının ilk harfi A veya L olanlar
-- 1. YOL
 
SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName LIKE 'A%'
      OR 
      FirstName LIKE 'L%'
ORDER BY 2;

-- 2. YOL
SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName LIKE '[AL]%' 
ORDER BY 2;

-- Adının içerisinde R veya T harfi bulunanlar

SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName LIKE '%[RT]%' 
ORDER BY 2;

-- Adının ilk harfi alfabetik olarak J ile R aralığında olanlar

SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName LIKE '[J-R]%' 
ORDER BY 2;

-- Adı şu şekilde olanlar: tAmEr, yAsEmin, tAnEr (A ile E arasında tek bir karakter olanlar)

SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName LIKE '%A_E%' 
ORDER BY 2;

--Adının içerisinde A ile E arasında iki tane karakter olanlar
SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName LIKE '%A__E%' 
ORDER BY 2;



-- Adının ilk harfi M olmayanlar
-- 1. YOL
SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName NOT LIKE 'M%' 
ORDER BY 2;

-- 2. YOL

SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName LIKE '[^M]%' 
ORDER BY 2;


-- Adının ilk iki harfi LA, LN, AA veya AN olanlar

-- Uzun Yol
SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName LIKE 'LA%'
      OR 
      FirstName LIKE 'LN%'
      OR 
      FirstName LIKE 'AA%'
      OR 
      FirstName LIKE 'AN%'
ORDER BY 2;

-- Kısa Yol
SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName LIKE '[LA][AN]%' 
ORDER BY 2;

-- Icerisinde _ geçen isimlerin listelenmesi : Normalde _ karakterinin özel bir anlamı vardır ve tek bir karakter yerine geçer, ancak [] içinde belirttiğimizde sıradan bir karakter gibi aratabiliriz.
-- I. YOL

SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName LIKE '%[_]%' 
ORDER BY 2;

-- 2. YOL

SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName LIKE '%?_%' escape '?'  
ORDER BY 2;


-- Adının 2. Karakteri N olanların listelenmesi
SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE FirstName LIKE '_N%'   
ORDER BY 2;



-- Customers tablosundan CustomerID'sinin 2. harfi A, 4. harfi T olanların %10'luk kısmını getiren sorguyu yazınız.



SELECT TOP 10 PERCENT *
FROM Customers
WHERE CustomerID LIKE '_A_T%'
ORDER BY CustomerID;







-- Tarih Fonksiyonlari
-- https://docs.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql?view=sql-server-ver15
 
/*
year	    yy,    yyyy
quarter	    qq,    q
month	    mm,    m
dayofyear	dy,    y
day	        dd,    d
week	    wk,    ww
weekday	    dw	   
hour	    hh	   
minute	    mi,    n
second	    ss,    s
millisecond	ms	   
microsecond	mcs	   
nanosecond	ns	   
TZoffset	tz
ISO_WEEK	isowk, isoww
 
*/


SELECT GETDATE(); --       2019-10-13 13:19:41.460

SELECT DATEPART(qq , GETDATE());

SELECT FirstName , LastName , DATEPART(yy , BirthDate) , YEAR(BirthDate)
FROM Employees;

SELECT DATEDIFF(Day , BirthDate , GETDATE()) AS [Yaşadığı Gün Sayısı]
FROM Employees;

SELECT YEAR(GETDATE()) - YEAR(BirthDate) AS Yıl
FROM Employees;

-- DATEDIFF => iki tarih arasındaki zaman farkını teslim eder.
-- DATEPART => bir tarih içerisindeki belirli bir alanı verdiğiniz parametreye göre size teslim eder.









-- Aggregate Fonksiyonlar (Toplam Fonksiyonlari, Gruplamali Fonksiyonlar)

-- Count   - sorgu içerisinde, toplam adet teslim eder
-- Sum     - sorgu içerisinde, değerlerin toplamını teslim eder.
-- AVG     - sorgu içerisinde, değerlerin ortalamasını teslim eder.
-- MAX     - sorgu içerisinde, en büyük değeri teslim eder
-- MIN     - sorgu içerisinde, en küçük değeri teslim eder


-- COUNT(Sütun adi | *): Bir tablodaki kayit sayisini öğrenmek için kullanilir.


SELECT COUNT(FirstName)
FROM Employees; -- 9

SELECT COUNT(Region)
FROM Employees;  -- Region sütunundaki kayit sayisi (Region sütunu null geçilebileceği için bir tablodaki kayit sayisini bu sütundan yola çikarak öğrenmek yanliş sonuçlar oluşturabilir. Çünkü aggregate fonksiyonlari NULL değer içeren kayitlari dikkate almaz. Bu nedenle kayit sayisini öğrenebilmek için ya * karakterini ya da NULL değer geçilemeyen sütunlardan birinin adini kullanmamiz gerekir.

SELECT COUNT(*)
FROM Employees; -- 9



SELECT COUNT(DISTINCT City)
FROM Employees; --5 tekil kayıt teslim edilir.


-- SUM(Sütun adi): Bir sütundaki değerlerin toplamini verir.


SELECT SUM(EmployeeID)
FROM Employees;  -- EmployeeID sütunundaki verilerin toplami

-- Çalişanlarin yaşlarinin toplamini bulunuz.

-- 1. YOL

SELECT SUM(YEAR(GETDATE()) - YEAR(BirthDate)) AS Age
FROM Employees;
-- 2. YOL

SELECT SUM(DATEDIFF(year , birthdate , GETDATE())) AS Age
FROM Employees;

-- Select SUM(FirstName) From Employees -- SUM fonksiyonunu sayisal sütunlarla kullanabilirsiniz.

-- AVG(Sütun adi): Bir sütundaki değerlerin ortalamasini verir.


SELECT AVG(EmployeeID)
FROM Employees;

-- Çalişanlarin yaşlarinin ortalamasi
SELECT AVG(DATEDIFF(year , birthdate , GETDATE())) AS Age
FROM Employees;  -- NULL olanlar işleme katilmayacaği için ortalama hesaplanirken bütün kişilerin sayisina bölünmez, NULL olmayan kişilerin sayisina bölünür.

SELECT AVG(LastName)
FROM Employees; -- AVG fonksiyonu sayisal sütunlarla kullanilir.



-- MAX(Sütun adi): Bir sütundaki en büyük değeri verir.


SELECT MAX(EmployeeID)
FROM Employees;

SELECT MAX(FirstName)
FROM Employees;   -- Sütunun sayisal sütun olmasina gerek yok, alfabetik olarak en büyük değeri de verir.

-- MIN(Sütun adi): Bir sütundaki en küçük değeri verir.

SELECT MIN(EmployeeID)
FROM Employees;

SELECT MIN(FirstName)
FROM Employees;

-- CASE - WHEN - THEN Kullanimi



SELECT EmployeeID AS PersonelID , FirstName AS Ad , Soyad = LastName , Title , Country
FROM Employees;
 

SELECT FirstName , LastName ,
                   CASE(Country)
                       WHEN 'USA'
                       THEN 'Amerika Birleşik Devletreli'
                   --WHEN 'UK'
                   --THEN 'İngiltere Birleşik Krallığı'
                   --ELSE 'Ülke Belirtilmedi'
                       ELSE Country
                   END AS 'Country'
FROM Employees;

-- EmployeeID değeri 5'ten büyük ise, 5'ten büyüktür, kküçük ise 5'ten küçüktür, eşit ise 5'e eşittir yazdırınız :)
 


SELECT EmployeeID , FirstName , LastName ,
                                CASE 
                                    WHEN EmployeeID > 5
                                    THEN 'ID değeri 5''ten büyüktür'
                                    WHEN EmployeeID < 5
                                    THEN 'ID değeri 5''ten küçüktür'
                                    ELSE 'ID değeri 5''e eşittir'
                                END AS Durum
FROM Employees;