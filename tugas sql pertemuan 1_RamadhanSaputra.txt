1. membuat table produk 
create table produk (
    -> id int NOT NULL auto_increment primary key,
    -> kode varchar (10) unique,
    -> nama varchar (45),
    -> harga_beli double,
    -> harga_jual double,
    -> stok int,
    -> min_stok int,
    -> jenis_produk_id int NOT NULL references jenis_produk(id));

2. membuat table pesanan_items
 create table pesanan_item (
    -> id int NOT NULL auto_increment primary key,
    -> produk_id int NOT NULL references produk (id),
    -> pesanan_id int NOT NULL references pesanan (id),
    -> qty int,
    -> harga double);

3. membuat table vendor 
create table vendor (
    -> id int NOT NULL auto_increment primary key,
    -> nomor varchar (4) unique,
    -> nama varchar (45),
    -> kota varchar (35),
    -> kontak varchar (30));

4. membuat table pembelian
create table pembelian (
    -> id int NOT NULL auto_increment primary key,
    -> tanggal date,
    -> nomor int,
    -> produk_id int NOT NULL references produk(id),
    -> jumlah int,
    -> harga double,
    -> vendor_id int NOT NULL references vendor(id));

5. Tambahkan kolom alamat pada pelanggan dengan tipe data varchar (40)
alter table pelanggan add column if not exists alamat varchar (40) after email;

6. Ubah kolom nama pada pelanggan menjadi nama_pelanggan
 alter table pelanggan change nama nama_pelanggan varchar(45);

7. edit tipe data nama_pelanggan menjadi varchar(50)
alter table pelanggan modify nama_pelanggan varchar (50) after kode;