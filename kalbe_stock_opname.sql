# Data Check
show databases;
use kalbe_product;
select * from stock_opname;
show create table stock_opname;
show tables;

# Add Primary Key

ALTER TABLE stock_opname
ADD PRIMARY KEY (id_produk);

# Create New Table for 2NF

CREATE TABLE produk(
	id_produk varchar(50) NOT NULL,
	nama_produk varchar(50) DEFAULT NULL,
	harga int DEFAULT NULL,
	primary key (id_produk)
)ENGINE = InnoDB;

INSERT INTO produk(id_produk,nama_produk,harga)
SELECT id_produk, nama_produk , harga 
FROM stock_opname;

select * from produk;

CREATE TABLE opname(
	kode_opname varchar(50) DEFAULT NULL,
	tanggal_cek varchar(50) DEFAULT NULL,
	id_produk varchar(50) NOT NULL,
	jumlah_stok int DEFAULT NULL,
	foreign key (id_produk) references produk(id_produk)
)ENGINE = InnoDB;

INSERT INTO opname(kode_opname,tanggal_cek,id_produk,jumlah_stok)
SELECT kode_opname ,tanggal_cek ,id_produk ,jumlah_stok 
FROM stock_opname;

select * from opname;

# Create Table for 3NF

CREATE TABLE opname_date(
	kode_opname varchar(50) NOT NULL,
	tanggal_cek varchar(50) DEFAULT NULL,
	PRIMARY KEY (kode_opname)
)ENGINE = InnoDB;

INSERT INTO opname_date(kode_opname, tanggal_cek)
SELECT DISTINCT kode_opname , tanggal_cek
FROM opname;

SELECT * FROM opname_date;

ALTER TABLE opname 
DROP COLUMN tanggal_cek;

ALTER TABLE opname 
ADD CONSTRAINT fk_opname_date
FOREIGN KEY (kode_opname) REFERENCES opname_date(kode_opname);

select * from opname;
select * from produk;
select * from opname_date;

# Create Stored Procedure for input new record in produk table

CREATE PROCEDURE InsertProduk(
	IN produk_id VARCHAR(50),
	IN nama_produk VARCHAR(50),
	IN harga_produk integer
)
INSERT INTO produk (id_produk, nama_produk, harga)
VALUES (produk_id,nama_produk,harga_produk);

CALL InsertProduk('KLBF_11','Morinaga',50000);
