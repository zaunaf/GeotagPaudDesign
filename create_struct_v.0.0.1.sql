/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     07/10/2019 21.17.22                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('foto') and o.name = 'FK_FOTO_FOTO_JENI_JENIS_FO')
alter table foto
   drop constraint FK_FOTO_FOTO_JENI_JENIS_FO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('foto') and o.name = 'FK_FOTO_FOTO_SEKO_SEKOLAH')
alter table foto
   drop constraint FK_FOTO_FOTO_SEKO_SEKOLAH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('foto') and o.name = 'FK_FOTO_PETUGAS_F_PENGGUNA')
alter table foto
   drop constraint FK_FOTO_PETUGAS_F_PENGGUNA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('geotag') and o.name = 'FK_GEOTAG_GEOTAG_SE_SEKOLAH')
alter table geotag
   drop constraint FK_GEOTAG_GEOTAG_SE_SEKOLAH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('geotag') and o.name = 'FK_GEOTAG_GEOTAG_ST_STATUS_G')
alter table geotag
   drop constraint FK_GEOTAG_GEOTAG_ST_STATUS_G
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('geotag') and o.name = 'FK_GEOTAG_PETUGAS_G_PENGGUNA')
alter table geotag
   drop constraint FK_GEOTAG_PETUGAS_G_PENGGUNA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('pengguna') and o.name = 'FK_PENGGUNA_USER_SEKO_SEKOLAH')
alter table pengguna
   drop constraint FK_PENGGUNA_USER_SEKO_SEKOLAH
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('foto')
            and   name  = 'foto_sekolah_fk'
            and   indid > 0
            and   indid < 255)
   drop index foto.foto_sekolah_fk
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('foto')
            and   name  = 'foto_jenis_fk'
            and   indid > 0
            and   indid < 255)
   drop index foto.foto_jenis_fk
go

if exists (select 1
            from  sysobjects
           where  id = object_id('foto')
            and   type = 'U')
   drop table foto
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('geotag')
            and   name  = 'petugas_geotag_fk'
            and   indid > 0
            and   indid < 255)
   drop index geotag.petugas_geotag_fk
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('geotag')
            and   name  = 'geotag_status_fk'
            and   indid > 0
            and   indid < 255)
   drop index geotag.geotag_status_fk
go

if exists (select 1
            from  sysobjects
           where  id = object_id('geotag')
            and   type = 'U')
   drop table geotag
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ref.jenis_foto')
            and   type = 'U')
   drop table ref.jenis_foto
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('pengguna')
            and   name  = 'user_sekolah_fk'
            and   indid > 0
            and   indid < 255)
   drop index pengguna.user_sekolah_fk
go

if exists (select 1
            from  sysobjects
           where  id = object_id('pengguna')
            and   type = 'U')
   drop table pengguna
go

if exists (select 1
            from  sysobjects
           where  id = object_id('sekolah')
            and   type = 'U')
   drop table sekolah
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ref.status_geotag')
            and   type = 'U')
   drop table ref.status_geotag
go

if exists(select 1 from systypes where name='id')
   drop type id
go

if exists(select 1 from systypes where name='nama_obyek_panjang')
   drop type nama_obyek_panjang
go

if exists(select 1 from systypes where name='serial')
   drop type serial
go

drop schema ref
go

/*==============================================================*/
/* User: ref                                                    */
/*==============================================================*/
create schema ref
go

/*==============================================================*/
/* Domain: id                                                   */
/*==============================================================*/
create type id
   from uniqueidentifier
go

/*==============================================================*/
/* Domain: nama_obyek_panjang                                   */
/*==============================================================*/
create type nama_obyek_panjang
   from varchar(140)
go

/*==============================================================*/
/* Domain: serial                                               */
/*==============================================================*/
create type serial
   from int
go

/*==============================================================*/
/* Table: foto                                                  */
/*==============================================================*/
create table foto (
   foto_id              uniqueidentifier     not null,
   jenis_foto_id        smallint             not null,
   sekolah_id           uniqueidentifier     not null,
   pengguna_id          uniqueidentifier     not null,
   judul                varchar(250)         null,
   tgl_pengambilan      datetime             null,
   tinggi_pixel         int                  null,
   lebar_pixel          int                  null,
   ukuran               int                  null,
   lintang              numeric(11,7)        null,
   bujur                numeric(11,7)        null,
   tgl_pengiriman       datetime             null,
   status_data          smallint             null,
   constraint PK_FOTO primary key nonclustered (foto_id)
)
go

/*==============================================================*/
/* Index: foto_jenis_fk                                         */
/*==============================================================*/
create index foto_jenis_fk on foto (
jenis_foto_id ASC
)
go

/*==============================================================*/
/* Index: foto_sekolah_fk                                       */
/*==============================================================*/
create index foto_sekolah_fk on foto (
sekolah_id ASC
)
go

/*==============================================================*/
/* Table: geotag                                                */
/*==============================================================*/
create table geotag (
   geotag_id            uniqueidentifier     not null,
   sekolah_id           uniqueidentifier     not null,
   status_geotag_id     smallint             not null,
   pengguna_id          uniqueidentifier     not null,
   tgl_pengambilan      datetime             null,
   lintang              numeric(11,7)        null,
   bujur                numeric(11,7)        null,
   petugas_link         uniqueidentifier     null,
   sekolah_link         uniqueidentifier     null,
   tgl_pengiriman       datetime             null,
   status_data          smallint             null,
   constraint PK_GEOTAG primary key nonclustered (geotag_id)
)
go

/*==============================================================*/
/* Index: geotag_status_fk                                      */
/*==============================================================*/
create index geotag_status_fk on geotag (
status_geotag_id ASC
)
go

/*==============================================================*/
/* Index: petugas_geotag_fk                                     */
/*==============================================================*/
create index petugas_geotag_fk on geotag (
pengguna_id ASC
)
go

/*==============================================================*/
/* Table: jenis_foto                                            */
/*==============================================================*/
create table ref.jenis_foto (
   jenis_foto_id        smallint             not null,
   nama_jenis_foto      varchar(140)         null,
   instruksi            text                 null,
   status_isian         int                  null,
   constraint PK_JENIS_FOTO primary key nonclustered (jenis_foto_id)
)
go

/*==============================================================*/
/* Table: pengguna                                              */
/*==============================================================*/
create table pengguna (
   pengguna_id          uniqueidentifier     not null,
   sekolah_id           uniqueidentifier     null,
   username             varchar(60)          collate SQL_Latin1_General_CP1_CI_AS not null,
   password             varchar(50)          collate SQL_Latin1_General_CP1_CI_AS not null,
   nama                 varchar(100)         collate SQL_Latin1_General_CP1_CI_AS not null,
   nip_nim              varchar(18)          collate SQL_Latin1_General_CP1_CI_AS null,
   jabatan_lembaga      varchar(25)          collate SQL_Latin1_General_CP1_CI_AS null,
   ym                   varchar(20)          collate SQL_Latin1_General_CP1_CI_AS null,
   skype                varchar(20)          collate SQL_Latin1_General_CP1_CI_AS null,
   alamat               varchar(80)          collate SQL_Latin1_General_CP1_CI_AS null,
   kode_wilayah         char(8)              collate SQL_Latin1_General_CP1_CI_AS not null,
   no_telepon           varchar(20)          collate SQL_Latin1_General_CP1_CI_AS null,
   no_hp                varchar(20)          collate SQL_Latin1_General_CP1_CI_AS null,
   aktif                numeric(1)           not null,
   ptk_id               varchar(36)          null,
   peran_id             int                  not null,
   lembaga_id           varchar(36)          null,
   yayasan_id           varchar(36)          null,
   la_id                char(5)              collate SQL_Latin1_General_CP1_CI_AS null,
   dudi_id              varchar(36)          null,
   create_date          datetime             not null,
   roles                text                 null,
   last_update          datetime             null,
   soft_delete          numeric(1)           null,
   last_sync            datetime             null,
   updater_id           varchar(36)          null,
   constraint PK_PENGGUNA primary key nonclustered (pengguna_id)
)
go

/*==============================================================*/
/* Index: user_sekolah_fk                                       */
/*==============================================================*/
create index user_sekolah_fk on pengguna (
sekolah_id ASC
)
go

/*==============================================================*/
/* Table: sekolah                                               */
/*==============================================================*/
create table sekolah (
   sekolah_id           uniqueidentifier     not null,
   nama                 varchar(100)         collate SQL_Latin1_General_CP1_CI_AS not null,
   nama_nomenklatur     varchar(100)         collate SQL_Latin1_General_CP1_CI_AS null,
   nss                  char(12)             collate SQL_Latin1_General_CP1_CI_AS null,
   npsn                 char(8)              collate SQL_Latin1_General_CP1_CI_AS null,
   bentuk_pendidikan_id smallint             not null,
   alamat_jalan         varchar(80)          collate SQL_Latin1_General_CP1_CI_AS not null,
   rt                   numeric(2)           null,
   rw                   numeric(2)           null,
   nama_dusun           varchar(60)          collate SQL_Latin1_General_CP1_CI_AS null,
   desa_kelurahan       varchar(60)          collate SQL_Latin1_General_CP1_CI_AS not null,
   kode_wilayah         char(8)              collate SQL_Latin1_General_CP1_CI_AS not null,
   kode_pos             char(5)              collate SQL_Latin1_General_CP1_CI_AS null,
   lintang              numeric(11,7)        null,
   bujur                numeric(11,7)        null,
   nomor_telepon        varchar(20)          collate SQL_Latin1_General_CP1_CI_AS null,
   nomor_fax            varchar(20)          collate SQL_Latin1_General_CP1_CI_AS null,
   email                varchar(60)          collate SQL_Latin1_General_CP1_CI_AS null,
   website              varchar(100)         collate SQL_Latin1_General_CP1_CI_AS null,
   kebutuhan_khusus_id  int                  not null,
   status_sekolah       numeric(1)           not null,
   sk_pendirian_sekolah varchar(80)          collate SQL_Latin1_General_CP1_CI_AS null,
   tanggal_sk_pendirian datetime             null,
   status_kepemilikan_id numeric(1)           not null,
   yayasan_id           varchar(36)          null,
   sk_izin_operasional  varchar(80)          collate SQL_Latin1_General_CP1_CI_AS null,
   tanggal_sk_izin_operasional datetime             null,
   no_rekening          varchar(20)          collate SQL_Latin1_General_CP1_CI_AS null,
   nama_bank            varchar(20)          collate SQL_Latin1_General_CP1_CI_AS null,
   cabang_kcp_unit      varchar(60)          collate SQL_Latin1_General_CP1_CI_AS null,
   rekening_atas_nama   varchar(50)          collate SQL_Latin1_General_CP1_CI_AS null,
   mbs                  numeric(1)           not null,
   luas_tanah_milik     numeric(7)           not null,
   luas_tanah_bukan_milik numeric(7)           not null,
   kode_registrasi      bigint               null,
   npwp                 char(15)             collate SQL_Latin1_General_CP1_CI_AS null,
   nm_wp                varchar(100)         collate SQL_Latin1_General_CP1_CI_AS null,
   flag                 char(3)              collate SQL_Latin1_General_CP1_CI_AS null,
   create_date          datetime             null,
   last_update          datetime             null,
   soft_delete          numeric(1)           null,
   last_sync            datetime             null,
   updater_id           varchar(36)          null,
   constraint PK_SEKOLAH primary key nonclustered (sekolah_id)
)
go

/*==============================================================*/
/* Table: status_geotag                                         */
/*==============================================================*/
create table ref.status_geotag (
   status_geotag_id     smallint             not null,
   nama_status_geotag   varchar(80)          null,
   constraint PK_STATUS_GEOTAG primary key nonclustered (status_geotag_id)
)
go

alter table foto
   add constraint FK_FOTO_FOTO_JENI_JENIS_FO foreign key (jenis_foto_id)
      references ref.jenis_foto (jenis_foto_id)
go

alter table foto
   add constraint FK_FOTO_FOTO_SEKO_SEKOLAH foreign key (sekolah_id)
      references sekolah (sekolah_id)
go

alter table foto
   add constraint FK_FOTO_PETUGAS_F_PENGGUNA foreign key (pengguna_id)
      references pengguna (pengguna_id)
go

alter table geotag
   add constraint FK_GEOTAG_GEOTAG_SE_SEKOLAH foreign key (sekolah_id)
      references sekolah (sekolah_id)
go

alter table geotag
   add constraint FK_GEOTAG_GEOTAG_ST_STATUS_G foreign key (status_geotag_id)
      references ref.status_geotag (status_geotag_id)
go

alter table geotag
   add constraint FK_GEOTAG_PETUGAS_G_PENGGUNA foreign key (pengguna_id)
      references pengguna (pengguna_id)
go

alter table pengguna
   add constraint FK_PENGGUNA_USER_SEKO_SEKOLAH foreign key (sekolah_id)
      references sekolah (sekolah_id)
go

